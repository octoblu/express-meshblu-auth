_ = require 'lodash'

class MeshbluAuthExpress
  constructor: (meshbluOptions={}, dependencies={}) ->
    @MeshbluHttp = dependencies.MeshbluHttp ? require 'meshblu-http'
    @meshbluOptions = _.defaults meshbluOptions,
      server: 'meshblu.octoblu.com'
      port: 443

  authDeviceWithMeshblu: (uuid, token, callback=->) =>
    return callback new Error('Meshblu credentials missing') unless uuid? && token?
    options = _.extend {}, @meshbluOptions, uuid: uuid, token: token
    meshbluHttp = new @MeshbluHttp options
    meshbluHttp.whoami (error, body) =>
      return callback error if error?
      return callback new Error('No device found') if _.isEmpty body
      callback()

  getFromAnywhere: (request) =>
    @setFromHeaders request
    @setFromSkynetHeaders request
    @setFromXMeshbluHeaders request
    @setFromCookies request
    @setFromBasicAuth request
    @setFromBearerToken request

  setFromBasicAuth: (request) =>
    @_setFromAuthorizationHeader request, 'Basic'

  setFromBearerToken: (request) =>
    @_setFromAuthorizationHeader request, 'Bearer'

  setFromCookies: (request) =>
    @_setFromObject request, request.cookies

  setFromHeaders: (request) =>
    @_setFromObject request, request.headers

  setFromSkynetHeaders: (request) =>
    @_setFromObject request,
      meshblu_auth_uuid: request.headers.skynet_auth_uuid
      meshblu_auth_token: request.headers.skynet_auth_token

  setFromXMeshbluHeaders: (request) =>
    lowerCaseHeaders = _.mapKeys request.headers, (value, key) => key?.toLocaleLowerCase()
    @_setFromObject request,
      meshblu_auth_uuid: lowerCaseHeaders['x-meshblu-uuid']
      meshblu_auth_token: lowerCaseHeaders['x-meshblu-token']

  _setFromAuthorizationHeader: (request, scheme) =>
    return unless request.headers?
    parts = request.headers.authorization?.split(' ')
    return unless parts? && parts[0]?.toLocaleLowerCase() == scheme?.toLocaleLowerCase()

    auth = new Buffer(parts[1], 'base64').toString().split(':')
    uuid = auth[0]
    token = auth[1]

    @_setMeshbluAuth request, uuid, token

  _setFromObject: (request, object) =>
    {meshblu_auth_uuid, meshblu_auth_token} = object ? {}

    return unless meshblu_auth_uuid? && meshblu_auth_token?
    @_setMeshbluAuth request, meshblu_auth_uuid, meshblu_auth_token

  _setMeshbluAuth: (request, uuid, token) =>
    return unless uuid? && token?
    request.meshbluAuth ?= {}
    request.meshbluAuth.uuid = _.trim uuid
    request.meshbluAuth.token = _.trim token

module.exports = MeshbluAuthExpress
