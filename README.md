# Express Meshblu Device Authentication Middleware
Express middleware to support all meshblu auth styles for a singular device

## Supported Auth Methods

* cookies: `request.cookies.meshblu_auth_uuid` and `request.cookies.meshblu_auth_token`
* headers: `request.cookies.meshblu_auth_uuid` and `request.cookies.meshblu_auth_token`
* basic: `Authorization: Basic c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo=`
* bearer: `Authorization: Bearer c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo=`

## Example:
    var express = require('express');
    var meshbluAuthDevice = require('express-meshblu-auth-device');
    var app = express();

    app.use(meshbluAuthDevice(
      uuid: '340d1779-300c-45cd-b133-2f316df8097a'
      server: 'meshblu.octoblu.com',
      port: 443,
      protocol: 'https'
    ));
    app.use(function (request, response) {
      response.json({uuid: request.meshbluAuthDevice.uuid, token: request.meshbluAuthDevice.token});
    });
    app.listen(3333);
