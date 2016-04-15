_ = require 'lodash'

class MeshbluAuthExpress
  constructor: (@meshbluOptions, dependencies={}) ->
    @MeshbluHttp = dependencies.MeshbluHttp ? require 'meshblu-http'

  authDeviceWithMeshblu: (uuid, token, callback=->) =>
    return callback new Error('Meshblu credentials missing') unless uuid? && token?
    options = _.extend {}, @meshbluOptions, uuid: uuid, token: token
    meshbluHttp = new @MeshbluHttp options
    meshbluHttp.whoami (error, body) =>
      return callback error if error?
      return callback null, null if _.isEmpty body
      return callback null, _.defaults {uuid: uuid, token: token}, @meshbluOptions


  getFromAnywhere: (request) =>
    auth = @getFromHeaders request
    return auth if auth?
    auth = @getFromSkynetHeaders request
    return auth if auth?
    auth = @getFromXMeshbluHeaders request
    return auth if auth?
    auth = @getFromCookies request
    return auth if auth?
    auth = @getFromBasicAuth request
    return auth if auth?
    auth = @getFromBearerToken request
    return auth if auth?

    return null

  getFromBasicAuth: (request) =>
    @_getFromAuthorizationHeader request, 'Basic'

  getFromBearerToken: (request) =>
    @_getFromAuthorizationHeader request, 'Bearer'

  getFromCookies: (request) =>
    @_getFromObject request, request.cookies

  getFromHeaders: (request) =>
    @_getFromObject request, request.headers

  getFromSkynetHeaders: (request) =>
    @_getFromObject request,
      meshblu_auth_uuid: request.headers.skynet_auth_uuid
      meshblu_auth_token: request.headers.skynet_auth_token

  getFromXMeshbluHeaders: (request) =>
    lowerCaseHeaders = _.mapKeys request.headers, (value, key) => key?.toLocaleLowerCase()
    @_getFromObject request,
      meshblu_auth_uuid: lowerCaseHeaders['x-meshblu-uuid']
      meshblu_auth_token: lowerCaseHeaders['x-meshblu-token']

  _getFromAuthString: (authString) =>
    auth = new Buffer(authString, 'base64').toString().split(':')
    return null unless _.size(auth) == 2
    return {
      uuid:  _.trim auth[0]
      token: _.trim auth[1]
    }

  _getFromAuthorizationHeader: (request, scheme) =>
    return null unless request.headers?
    parts = request.headers.authorization?.split(' ')
    return null unless parts? && parts[0]?.toLocaleLowerCase() == scheme?.toLocaleLowerCase()
    return @_getFromAuthString parts[1]

  _getFromObject: (request, object) =>
    {meshblu_auth_uuid, meshblu_auth_token, meshblu_auth_bearer} = object ? {}

    if meshblu_auth_bearer?
      {uuid, token} = @_getFromAuthString meshblu_auth_bearer
      meshblu_auth_uuid = uuid
      meshblu_auth_token = token

    return null unless meshblu_auth_uuid? && meshblu_auth_token?
    return {
      uuid:  _.trim meshblu_auth_uuid
      token: _.trim meshblu_auth_token
    }

  _setMeshbluAuth: (request, uuid, token) =>
    return unless uuid? && token?
    uuid  = _.trim uuid
    token = _.trim token
    request.meshbluAuth = _.defaults {uuid: uuid, token: token}, @meshbluOptions, request.meshbluAuth

module.exports = MeshbluAuthExpress
