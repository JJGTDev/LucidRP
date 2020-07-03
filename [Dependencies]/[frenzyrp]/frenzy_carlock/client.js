/** @type {IESX} */
let ESX = null

/**
 *
 * @param {Number} ms
 */
let Wait = (ms) => new Promise(res => setTimeout(res, ms))

let lastVehicle = null

let hornStatus = false

let vehicleCache = null

let activePlate = ""

let activeModel = ""

let entityCache = null

let initiated = false

let boyPed = null

let busy = false

let ped = GetPlayerPed(-1)


const esxLoader = setTick(async () => {
    await Wait(0)
    if (ESX === null) {
        emit("esx:getSharedObject", obj => {
            ESX = obj
            clearTick(esxLoader)
        })
    }
})

const cacheTick = setTick(async () => {
    await Wait(0)
    if(vehicleCache === null) {
        if(ESX == null) {
            return
        }
        ESX.TriggerServerCallback('esx_carlock:getOwnedVehicles', (vehicles) => {
            vehicleCache = vehicles
            clearTick(cacheTick)
        })
    }
})

const vehicleScanner = setTick(async () => {
    await Wait(500)
    const vehicleEntity = GetVehiclePedIsIn(ped, false)
    if(vehicleEntity === 0) {
        return
    }
    if( vehicleEntity === entityCache) {
        return
    }
    vehicleCache.forEach((vehicle) => {
        if(vehicle.plate === GetVehicleNumberPlateText(vehicleEntity).trim()) {
            emit('mythic_notify:client:SendAlert', {type: 'inform', text: `Key switched: ${getFriendlyName(GetEntityModel(vehicleEntity))}`})
            entityCache = vehicleEntity
            activePlate = vehicle.plate.trim()
        }
    })
})

const buttonScanner = setTick(async () => {
    if(busy === true) {
        return
    }
    if(IsControlJustPressed(1, 182) && GetLastInputMethod(2)) {
        ped = GetPlayerPed(-1)
        if(activePlate === "") {
            emit('mythic_notify:client:SendAlert', {type: 'inform', text: `No active keys`})
            return
        }
        const pedLocation = GetEntityCoords(ped)
        const nearbyVehicles = ESX.Game.GetVehiclesInArea({x: pedLocation[0],y: pedLocation[1], z: pedLocation[2]}, 30)
        let found = false
        for(let i = 0; i < nearbyVehicles.length; i++) {
            if(GetVehicleNumberPlateText(nearbyVehicles[i]).trim() === activePlate.trim()) {
                entityCache = nearbyVehicles[i]
                found = true
                const status = await toggleLocks()
            }
        }
        if(found === false) {
            emit('mythic_notify:client:SendAlert', {type: 'inform', text: `Vehicle out of range`})
        }
    }
})

RegisterCommand('lockcar', () => {
    toggleLocks()
})

onNet('frenzy_carlock:update', () => {
    ped = GetPlayerPed(-1)
    ESX.TriggerServerCallback('esx_carlock:getOwnedVehicles', (vehicles) => {
        vehicleCache = vehicles
    })
})

RegisterCommand('keys', () => {
    ESX.TriggerServerCallback('esx_carlock:getOwnedVehicles', (vehicles) => {
        vehicleCache = vehicles
        let elements = []
        for(let i = 0; i < vehicles.length; i++) {
            if(vehicles[i].stored === true) {
                continue
            }
            const vehicleData = JSON.parse(vehicles[i].vehicle)
            const modelName = getFriendlyName(vehicleData.model)
            elements.push({
                label: `${modelName} - ${vehicles[i].plate}`,
                value: vehicles[i].plate.trim()
            })
        }
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'lock_keys_menu', {
            title: 'Active Car Keys',
            align: 'right',
            elements: elements
        }, (data, menu) => {
            activePlate = data.current.value.trim()
            activeModel = data.current.label
            const [x,y,z] = GetEntityCoords(GetPlayerPed(-1))
            const vehicleScan = ESX.Game.GetVehiclesInArea({x,y,z}, 500)
            let found = false
            for(let i = 0; i < vehicleScan.length; i++) {
                if(GetVehicleNumberPlateText(vehicleScan[i]).trim() === activePlate.trim()) {
                    entityCache = vehicleScan[i]
                    found = true
                }
            }
            if(found === false) {
                entityCache = null
            }
            if (activeModel && activePlate) {
                emit('mythic_notify:client:SendAlert', {type: 'inform', text: `Key switched: ${activeModel}`})
            }
            menu.close()
        }, (data2, menu) => {
            ESX.UI.Menu.CloseAll()
        })
    })
})

const toggleLocks = async (lockStatus) => {
    busy = true
    const control = await requestControl(entityCache)
    if(control === false) {
        emit('mythic_notify:client:SendAlert', {type: 'error', text: `Key fob didn't seem to work`})
        busy = false
        return
    }
    busy = false
    let lockedStatus
    if(!!lockStatus) {
        lockedStatus = lockStatus
    } else {
        lockedStatus = GetVehicleDoorLockStatus(entityCache)
    }
    emit('animations:playEmote', 'fob')
    switch(lockedStatus) {
        case 1:
            SetVehicleDoorsLocked(entityCache, 2)
            hornStatus = true
            SetVehicleLights(entityCache, 2)
            await Wait(100)
            SetVehicleLights(entityCache, 0)
            hornStatus = false
            SetVehicleAlarm(entityCache, true)
            emit('mythic_notify:client:SendAlert', {type: 'error', text: `${getFriendlyName(GetEntityModel(entityCache))} locked`})
            break
        case 2:
            SetVehicleDoorsLocked(entityCache, 1)
            hornStatus = true
            SetVehicleLights(entityCache, 2)
            await Wait(100)
            SetVehicleLights(entityCache, 0)
            hornStatus = false
            await Wait(100)
            SetVehicleLights(entityCache, 2)
            hornStatus = true
            await Wait(100)
            SetVehicleLights(entityCache, 0)
            hornStatus = false
            SetVehicleAlarm(entityCache, false)
            emit('mythic_notify:client:SendAlert', {type: 'success', text: `${getFriendlyName(GetEntityModel(entityCache))} unlocked`})
    }
    return lockedStatus
}

const horny = setTick(async () => {
    if(hornStatus === true) {
        SoundVehicleHornThisFrame(entityCache)
    }
})

const getFriendlyName = (model) => {
    let dispName = GetDisplayNameFromVehicleModel(model)
    let full = GetLabelText(dispName)
    return (full === 'NULL') ? dispName : full
}


RegisterCommand('hereboy', async () => {
    if(boyPed !== null) {
        ClearPedTasks(boyPed)
        ClearPedTasksImmediately(boyPed)
        DeleteEntity(boyPed)
        boyPed = null
        emit('mythic_notify:client:SendAlert', {type: 'error', text: `Bring car cancelled`})
        return
    }
    if(entityCache === null) {
        emit('mythic_notify:client:SendAlert', {type: 'error', text: `Service unavailable`})
        return
    }
    let allowedVehicle = false
    for(let i = 0; i < CONFIG.hereboy_vehicles.length; i++) {
        const cachedVehicleModel = GetEntityModel(entityCache)
        if(GetHashKey(CONFIG.hereboy_vehicles[i]) === cachedVehicleModel) {
            allowedVehicle = true
        }
    }
    if(allowedVehicle === false) {
        emit('mythic_notify:client:SendAlert', {type: 'error', text: `Feature not available for this vehicle`})
        return
    }
    const [x, y, z] = GetEntityCoords(GetPlayerPed(-1))
    if(IsPointOnRoad(x,y,z) === false) {
        emit('mythic_notify:client:SendAlert', {type: 'error', text: `You need to be on a road`})
        return
    }
    const pedsetup = await setupModel(`CS_Priest`)
    boyPed = CreatePedInsideVehicle(entityCache, 4, GetHashKey("CS_Priest"), -1, true, true)
    if(boyPed === 0) {
        emit('mythic_notify:client:SendAlert', {type: 'error', text: `Service unavailable`})
        return
    }
    SetEntityInvincible(boyPed, true)
    SetEntityVisible(boyPed, false)
    TaskVehicleDriveToCoordLongrange(boyPed, entityCache, x, y, z, 20, 447, 1.0)
    emit('mythic_notify:client:SendAlert', {type: 'success', text: `${getFriendlyName(GetEntityModel(entityCache))} is on the way!`})
    emit('animations:playEmote', 'fob')
    toggleLocks(1)
    const scanForVehicle = setTick(async () => {
        if(boyPed === null) {
            clearTick(scanForVehicle)
        }
        await Wait(500)
        const vehicleRad = ESX.Game.GetVehiclesInArea({x,y,z}, 10)
        console.log(vehicleRad)
        for(let i = 0; i < vehicleRad.length; i++) {
            if(vehicleRad[i] === entityCache) {
                emit('mythic_notify:client:SendAlert', {type: 'success', text: `${getFriendlyName(GetEntityModel(entityCache))} has arrived`})
                ClearPedTasks(boyPed)
                ClearPedTasksImmediately(boyPed)
                await Wait(1500)
                DeleteEntity(boyPed)
                boyPed = null
                clearTick(scanForVehicle)
            }
        }
    })
})


const requestControl = (entity) => {
    return new Promise((resolve, reject) => {
        let controlled = false
        const controlTick = setTick(async () => {
            if(controlled === true) {
                clearTick(controlTick)
                resolve(true)
                clearTimeout(killTick)
                return
            }
            await Wait(10)
            request = NetworkRequestControlOfEntity(entity)
            if(request === 1) {
                controlled = true
            }
        })
        const killTick = setTimeout(() => {
            clearTick(controlTick)
            resolve(false)
        }, 5000)
    })
}

const setupModel = async (model) => {
    RequestModel(model)
    const modelLoader = setTick(async () => {
        if(HasModelLoaded(model) === true) {
            SetModelAsNoLongerNeeded(model)
            clearTick(modelLoader)
            return
        }
    })
}


const busyTick = setTick(async () => {
    if(busy === false) {
        RemoveLoadingPrompt()
        return
    }
    BeginTextCommandBusyString('STRING')
    AddTextComponentSubstringPlayerName('')
    EndTextCommandBusyString(4)
})