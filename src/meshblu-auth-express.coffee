_ = require 'lodash'

class MeshbluAuthExpress
  setFromAnywhere: (request) =>
    @setFromHeaders request
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

  _setFromAuthorizationHeader: (request, scheme) =>
    return unless request.headers?
    parts = request.headers.authorization?.split(' ')
    return unless parts? && parts[0] == scheme

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
