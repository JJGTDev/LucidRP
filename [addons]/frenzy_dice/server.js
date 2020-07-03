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
    payload.players.forEach((id) => {
        emitNet('frenzy_rolldie:number', id, {
            sender: payload.sender,
            number: payload.number
        })
    })
})

