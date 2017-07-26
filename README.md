# Express Meshblu Authentication Middleware

Express middleware to support all meshblu auth styles

[![Build Status](https://travis-ci.org/octoblu/express-meshblu-auth.svg?branch=master)](https://travis-ci.org/octoblu/express-meshblu-auth) [![Code Climate](https://codeclimate.com/github/octoblu/express-meshblu-auth/badges/gpa.svg)](https://codeclimate.com/github/octoblu/express-meshblu-auth) [![Test Coverage](https://codeclimate.com/github/octoblu/express-meshblu-auth/badges/coverage.svg)](https://codeclimate.com/github/octoblu/express-meshblu-auth) [![npm version](https://badge.fury.io/js/express-meshblu-auth.svg)](http://badge.fury.io/js/express-meshblu-auth) [![Gitter](https://badges.gitter.im/octoblu/help.svg)](https://gitter.im/octoblu/help)

## Supported Auth Methods

* cookies: `request.cookies.meshblu_auth_uuid` and `request.cookies.meshblu_auth_token`
* headers: `request.cookies.meshblu_auth_uuid` and `request.cookies.meshblu_auth_token`
* basic: `Authorization: Basic c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo=`
* bearer: `Authorization: Bearer c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo=`

## Example:

```javascript
var express = require('express');
var MeshbluAuth = require('express-meshblu-auth');
var meshbluAuth = new MeshbluAuth({
  protocol: 'https',
  server: 'meshblu.octoblu.com',
  port: 443
});

var app = express();
// Retrieves the uuid & token from the request,
// validate them, then add them to request.meshbluAuth
app.use(meshbluAuth.auth());

// Retrieves the uuid & token from the request,
// validate them by retrieving the device, then:
// add credentials to request.meshbluAuth
// add device to request.meshbluDevice
app.use(meshbluAuth.get());

// Returns a 401 if no uuid & token were provided in the request
// Returns a 403 if the uuid & token provided were invalid
// calls next otherwise
// meshbluAuth.auth or meshbluAuth.get MUST BE CALLED FIRST in the middleware chain
app.use(meshbluAuth.gateway());

// Returns a 401 if no uuid & token were provided in the request
// Returns a 403 if the uuid & token provided were invalid
// Returns a 403 if the uuid given does not match the authorized uuid
// calls next otherwise
// meshbluAuth.auth or meshbluAuth.get MUST BE CALLED FIRST in the middleware chain
app.use(meshbluAuth.gatewayDevice('uuid'));

// Can be used instead of gateway. Redirects user if uuid & token were not
// provided or were not valid
app.use(meshbluAuth.gatewayRedirect('/login'));

app.use(function (request, response) {
  response.json({uuid: request.meshbluAuth.uuid, token: request.meshbluAuth.token});
});
app.listen(3333);
```
