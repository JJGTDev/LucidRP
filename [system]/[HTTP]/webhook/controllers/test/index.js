const TestController = {
    get: {
        handler: async(request, response) => {
            return response.status(200).json({
                message: "Webhooks are online",
            })
        }
    }
}

module.exports = TestController