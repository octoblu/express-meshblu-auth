MeshbluAuthExpress = require './src/meshblu-auth-express'

module.exports = (meshbluOptions) ->
  meshbluAuthExpress = new MeshbluAuthExpress meshbluOptions

  middleware = (request, response, next) ->
    meshbluAuthExpress.getFromAnywhere request
    {uuid, token} = request.meshbluAuth ? {}
    return response.status(401).end() unless uuid? && token?
    meshbluAuthExpress.authDeviceWithMeshblu uuid, token, (error) ->
      if error?
        console.error error
        return response.status(401).end()
      next()

  middleware
