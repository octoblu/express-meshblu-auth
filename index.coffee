MeshbluAuthExpress = require './src/meshblu-auth-express'

class MeshbluAuth
  constructor: (options) ->
    @meshbluAuthExpress = new MeshbluAuthExpress options

  retrieve: (req, res, next) =>
    credentials = @meshbluAuthExpress.getFromAnywhere req
    return next() unless credentials?

    {uuid, token} = credentials
    @meshbluAuthExpress.authDeviceWithMeshblu uuid, token, (error, meshbluAuth) ->
      return res.sendStatus(500) if error?
      req.meshbluAuth = meshbluAuth if meshbluAuth?
      next()

  gateway: (req, res, next) =>
    credentials = @meshbluAuthExpress.getFromAnywhere req
    return res.sendStatus 401 unless credentials?
    return res.sendStatus 403 unless req.meshbluAuth?
    return next()

module.exports = MeshbluAuth
