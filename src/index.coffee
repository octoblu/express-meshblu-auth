_ = require 'lodash'
debug = require('debug')('express-meshblu-auth')
MeshbluAuthExpress = require './src/meshblu-auth-express'

class MeshbluAuth
  constructor: (options) ->
    @meshbluAuthExpress = new MeshbluAuthExpress options

  auth: =>
    (req, res, next) =>
      credentials = @meshbluAuthExpress.getFromAnywhere req
      debug 'uuid', _.get(credentials, 'uuid')
      return next() unless credentials?

      {uuid, token} = credentials
      @meshbluAuthExpress.authDeviceWithMeshblu uuid, token, (error, meshbluAuth) ->
        return res.status(500).send(error: error.message) if error?
        req.meshbluAuth = meshbluAuth if meshbluAuth?
        next()

  get: =>
    (req, res, next) =>
      credentials = @meshbluAuthExpress.getFromAnywhere req
      debug 'uuid', _.get(credentials, 'uuid')
      return next() unless credentials?

      {uuid, token} = credentials
      @meshbluAuthExpress.getDeviceFromMeshblu uuid, token, (error, response={}) ->
        return res.status(500).send(error: error.message) if error?
        {meshbluAuth, meshbluDevice} = response
        req.meshbluAuth = meshbluAuth if meshbluAuth?
        req.meshbluDevice = meshbluDevice if meshbluDevice?
        next()

  gateway: =>
    (req, res, next) =>
      credentials = @meshbluAuthExpress.getFromAnywhere req
      return res.status(401).send(error: 'Unauthorized') unless credentials?
      return res.status(403).send(error: 'Forbidden') unless req.meshbluAuth?
      return next()

  gatewayDevice: (uuid) =>
    (req, res, next) =>
      credentials = @meshbluAuthExpress.getFromAnywhere req
      return res.status(401).send(error: 'Unauthorized') unless credentials?
      return res.status(403).send(error: 'Forbidden') unless req.meshbluAuth?
      return res.status(403).send(error: 'Forbidden') unless req.meshbluAuth.uuid == uuid
      return next()

  gatewayRedirect: (location) =>
    (req, res, next) =>
      return res.redirect location unless req.meshbluAuth?
      return next()

module.exports = MeshbluAuth
