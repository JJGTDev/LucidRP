/** @type {IESX} */
let ESX = null

/**
 *
 * @param {Number} ms
 */
let Wait = (ms) => new Promise(res => setTimeout(res, ms))

const esxLoader = setTick(async () => {
    await Wait(0)
    if (ESX === null) {
        emit("esx:getSharedObject", obj => {
            ESX = obj
            clearTick(esxLoader)
        })
    }
})

onNet('frenzy_rolldie:sync', async (payload) => {
    ESX.ShowNotification(`${payload.sender} just rolled ${payload.number}`)
})

RegisterCommand('rolldie', async (source, args) => {
    let max = 100
    if(args[0] !== "" && args[0] !== null) {
        max = parseInt(args[0])
    }
    const randomNum = Math.floor(Math.random() * max)
    const nearbyPlayers = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 30, true)
    if(nearbyPlayers.length <= 0) {
        ESX.ShowNotification(`There isn't anyone to participate with`)
    }
    let nearbyPlayersServerIds = []
    for(let i = 0; i < nearbyPlayers.length; i++) {
        nearbyPlayersServerIds.push(GetPlayerServerId(nearbyPlayers[i]))
    }
    const payload = {
        players: nearbyPlayersServerIds,
        sender: `${ESX.GetPlayerData().firstname} ${ESX.GetPlayerData().lastname}`,
        number: randomNum
    }
    emitNet('frenzy_rolldie:send', payload)
})

