# Express Meshblu Authentication Middleware
Express middleware to support all meshblu auth styles

## Supported Auth Methods

* cookies: `request.cookies.meshblu_auth_uuid` and `request.cookies.meshblu_auth_token`
* headers: `request.cookies.meshblu_auth_uuid` and `request.cookies.meshblu_auth_token`
* basic: `Authorization: Basic c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo=`
* bearer: `Authorization: Bearer c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo=`

## Example:
    var express = require('express');
    var meshbluAuth = require('express-meshblu-auth');
    var app = express();

    app.use(meshbluAuth(
      server: 'meshblu.octoblu.com',
      port: 443,
      protocol: 'https'
    ));
    app.use(function (request, response) {
      request.send({uuid: request.meshbluAuth.uuid, token: request.meshbluAuth.token});
    });
    app.listen(3333);
