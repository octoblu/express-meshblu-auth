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
      response.json({uuid: request.meshbluAuth.uuid, token: request.meshbluAuth.token});
    });
    app.listen(3333);

[![Build Status](https://travis-ci.org/octoblu/express-meshblu-auth.svg?branch=master)](https://travis-ci.org/octoblu/express-meshblu-auth)
[![Code Climate](https://codeclimate.com/github/octoblu/express-meshblu-auth/badges/gpa.svg)](https://codeclimate.com/github/octoblu/express-meshblu-auth)
[![Test Coverage](https://codeclimate.com/github/octoblu/express-meshblu-auth/badges/coverage.svg)](https://codeclimate.com/github/octoblu/express-meshblu-auth)
[![npm version](https://badge.fury.io/js/express-meshblu-auth.svg)](http://badge.fury.io/js/express-meshblu-auth)
[![Gitter](https://badges.gitter.im/octoblu/help.svg)](https://gitter.im/octoblu/help)
