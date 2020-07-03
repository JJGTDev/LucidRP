const resourceName = GetCurrentResourceName()

const RestartController = {
    post: {
        handler: async (request, response) => {
            if(request.body === "" || request.body.resources.length <= 0) {
                return response.status(400).json({
                    message: "invalid request"
                })
            }
            ExecuteCommand("refresh")
            request.body.resources.forEach((resource) => {
                setImmediate(() => {
                    if(resourceName !== resource) {
                        const state = GetResourceState(resource)
                        switch(state) {
                            case "started":
                                ExecuteCommand(`restart ${resource}`)
                                break
                            case "stopped":
                            case "uninitialized":
                                ExecuteCommand(`start ${resource}`)
                                break
                        }
                    }
                })
            })
            response.status(200).json({
                "restarted": request.body.resources
            })
        }
    }
}

module.exports = RestartController