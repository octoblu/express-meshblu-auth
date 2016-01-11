MeshbluAuthExpress = require './src/meshblu-auth-express'

module.exports = (meshbluOptions) ->
  meshbluAuthExpress = new MeshbluAuthExpress meshbluOptions

  middleware = (request, response, next) ->
    meshbluAuthExpress.getFromAnywhere request
    {uuid, token} = request.meshbluAuth ? {}
    return response.status(401).end() unless uuid? && token?
    meshbluAuthExpress.authDeviceWithMeshblu uuid, token, (error, device) ->
      if error?
        console.error error.stack
        return response.status(error.code ? 403).send("Meshblu Authentication Failed")
      request.meshbluAuth.device = device
      next()

  middleware
