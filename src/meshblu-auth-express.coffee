_     = require 'lodash'
debug = require('debug')('express-meshblu-auth:info')

class MeshbluAuthExpress
  constructor: (@meshbluOptions, dependencies={}) ->
    @MeshbluHttp = dependencies.MeshbluHttp ? require 'meshblu-http'

  authDeviceWithMeshblu: (uuid, token, callback=->) =>
    return callback new Error('Meshblu credentials missing') unless uuid? && token?
    options = @_extendMeshbluAuth({ uuid, token })
    meshbluHttp = new @MeshbluHttp options
    meshbluHttp.authenticate (error) =>
      if error?
        isUserError = @_isUserError error
        debug 'authenticate got an error', { isUserError }, error
        return callback null, null if isUserError
        return callback error
      meshbluAuth = @_defaultMeshbluAuth { uuid, token }
      return callback null, meshbluAuth

  getDeviceFromMeshblu: (uuid, token, callback=->) =>
    return callback new Error('Meshblu credentials missing') unless uuid? && token?
    options = @_extendMeshbluAuth({ uuid, token })
    meshbluHttp = new @MeshbluHttp options
    meshbluHttp.whoami (error, meshbluDevice) =>
      if error?
        isUserError = @_isUserError error
        debug 'whoami got an error', { isUserError }, error
        return callback null, null if isUserError
        return callback error
      return callback null, null unless meshbluDevice?
      meshbluAuth = @_defaultMeshbluAuth { uuid, token }
      return callback null, {meshbluAuth, meshbluDevice}

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

  _generateBearerToken: ({uuid,token}) =>
    return new Buffer("#{uuid}:#{token}").toString 'base64'

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

  _isUserError: (error) =>
    return unless error.code?
    error.code < 500

  _extendMeshbluAuth: ({ uuid, token }) =>
    return _.extend {}, @meshbluOptions, { uuid, token }

  _defaultMeshbluAuth: ({ uuid, token }) =>
    bearerToken = @_generateBearerToken { uuid, token }
    return _.defaults { uuid, token, bearerToken }, @meshbluOptions

  _setMeshbluAuth: (request, uuid, token) =>
    return unless uuid? && token?
    uuid  = _.trim uuid
    token = _.trim token
    request.meshbluAuth = _.defaults {uuid, token}, @meshbluOptions, request.meshbluAuth

module.exports = MeshbluAuthExpress
