MeshbluAuthExpress = require './src/meshblu-auth-express'

class MeshbluAuth
  constructor: (options) ->
    @meshbluAuthExpress = new MeshbluAuthExpress options

  retrieve: =>
    (req, res, next) =>
      credentials = @meshbluAuthExpress.getFromAnywhere req
      return next() unless credentials?

      {uuid, token} = credentials
      @meshbluAuthExpress.authDeviceWithMeshblu uuid, token, (error, meshbluAuth) ->
        return res.status(500).send(error: error.message) if error?
        req.meshbluAuth = meshbluAuth if meshbluAuth?
        next()

  gateway: =>
    (req, res, next) =>
      credentials = @meshbluAuthExpress.getFromAnywhere req
      return res.send(401).send(error: 'Unauthorized') unless credentials?
      return res.status(403).send(error: 'Forbidden') unless req.meshbluAuth?
      return next()

  gatewayRedirect: (location) =>
    (req, res, next) =>
      return res.redirect location unless req.meshbluAuth?
      return next()

module.exports = MeshbluAuth
