const client_secret = ":)#d0n7:)!--"
let countDown
let subdomain
const Timer = {
    duration: 0,
    /**
     *
     * @param {number} amount The amount of time to remove from the duration in `seconds`
     * @returns {number} the modified duration
     */
    removeDuration(amount) {
        this.duration = (amount !== undefined && amount !== null) ? this.duration - parseInt(amount) : 0
        return this.duration
    },
    /**
     *
     * @param {number} amount The amount of time to add to the duration in `seconds`
     * @returns {number} the modified duration
     */
    addDuration(amount) {
        this.duration = (amount !== undefined && amount !== null) ? this.duration + parseInt(amount) : 0
        return this.duration
    },
    completeText() {
        return `${this.minutesTotalText()}  ${this.secondsTotalText()}`
    },
    secondsInMinute() {
        return parseInt(this.duration % 60, 10)
    },
    minutesInHour() {
        return parseInt((this.duration / 60) % 60, 10)
    },
    minutesTotal() {
        return parseInt(this.duration / 60, 10)
    },
    minutesTotalText() {
        if(this.minutesTotal() === 1) {
            return `${this.minutesTotal()} minute`
        } else if(this.minutesTotal() > 1) {
            return `${this.minutesTotal()} minutes`
        } else {
            return ``
        }
    },
    secondsTotalText() {
        if(this.secondsInMinute() === 1) {
            return `${this.secondsInMinute()} second`
        } else if(this.secondsInMinute() > 1) {
            return `${this.secondsInMinute()} seconds`
        } else {
            return ``
        }
    }
}
const UpdateController = {
    post: {
        params: ':duration',
        handler: async (request, response) => {
            const host = request.header("host")
            const duration = parseInt(request.params["duration"])
            let intervalsraw = request.query.intervals
            let intervals = intervalsraw.split(",")
            const regex = /(http:\/\/)?(([^.]+)\.)?frenzyrp\.com/
            let m
            if ((m = regex.exec(host)) !== null) {
                subdomain = m[3]
            } else if(host !== "localhost:3001") {
                return response.status(400).json({
                    "message": "invalid host",
                })
            }
            if(request.header("x-frenzy") === "" || request.header("x-frenzy") === undefined || request.header("x-frenzy") === null) {
                return response.status(400).json({
                    "message": "Good try ;)"
                })
            } else {
                if(request.header("x-frenzy") !== client_secret) {
                    return response.status(400).json({
                        "message": "Really good try ;)",
                    })
                } else {
                    Timer.duration = duration
                    clearInterval(countDown)
                    let initialMessage
                    initialMessage = `Server restarting in ${Timer.minutesTotalText()} ${Timer.secondsTotalText()}`
                    ExecuteCommand(`stop swarmgate_open`)
                    // SendMessage(-1, ["Announcement", initialMessage])
                    // emit('frenzy_cam:internalSync', 'dying')
                    emitNet('es_wsync:updateWeather', -1, 'THUNDER', true)
                    countDown = setInterval(() => {
                        if(intervalTime(Timer, intervals) === true) {
                            SendMessage(-1, ["Announcement", `Server restarting in ${Timer.minutesTotalText()} ${Timer.secondsTotalText()}`])
                        }
                        if(Timer.removeDuration(1) < 0) {
                            TriggerClientEvent('frenzy_admin:kickAllClient', -1)
                            clearInterval(countDown)
                        }
                    }, 1000)
                    response.status(200).json({
                        "message": "ok"
                    })
                }
            }
        }
    }
}
/**
 *
 * @param {Number} target
 * @param {Array<String>} message
 */
const SendMessage = (target, message) => {
    TriggerClientEvent('chat:addMessage', target, { template: '<div class="chat-message-system"><b>{0}:</b> {1}</div>',args: message})
}

/**
 *
 * @param {Timer} timer
 * @param {Array<String>} intervals
 */
const intervalTime = (timer, intervals) => {
    let isIntervalTime = false
    for(let i = 0; i < intervals.length; i++) {
        let fullTime, minutes, seconds
        if(extractIntervals(intervals[i]) !== null && extractIntervals(intervals[i]) !== undefined) {
            [fullTime, minutes, seconds] = extractIntervals(intervals[i])
            minutes = parseInt(minutes)
            seconds = parseInt(seconds)
            if(minutes === timer.minutesTotal() && seconds === timer.secondsInMinute()) {
                return isIntervalTime = true
            }
        }
    }
    return false
}

/**
 *
 * @param {String} input - The interval to text/extract
 */
const extractIntervals = (input) => {
    if(input === null || input === "") {
        return
    }
    const regex = /(\d+):(\d+)/gm;
    const str = input;
    let m;
    m = regex.exec(str)
    return m
}

module.exports = UpdateController