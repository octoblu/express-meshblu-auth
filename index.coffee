MeshbluAuthExpress = require './src/meshblu-auth-express'

module.exports = ->
  meshbluAuthExpress = new MeshbluAuthExpress

  middleware = (request, response, next) ->
    meshbluAuthExpress.getFromAnywhere request
    {uuid, token} = request.meshbluAuth
    return response.status(401).end() unless uuid? && token?
    next()

  middleware
