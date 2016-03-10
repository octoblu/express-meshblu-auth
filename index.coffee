MeshbluAuthExpress = require './src/meshblu-auth-express'

module.exports = (meshbluOptions, {errorCallback}={}) ->
  meshbluAuthExpress = new MeshbluAuthExpress meshbluOptions

  middleware = (req, res, next) ->

    meshbluAuthExpress.getFromAnywhere req
    {uuid, token} = req.meshbluAuth ? {}

    unless uuid? && token?
      return errorCallback new Error('could not get uuid and token'), {req, res} if errorCallback?
      return res.status(401).end()

    meshbluAuthExpress.authDeviceWithMeshblu uuid, token, (error) ->
      if error?
        return errorCallback error, {req, res} if errorCallback?
        return res.status(error.code ? 403).send("Meshblu Authentication Failed")
      next()

  middleware
