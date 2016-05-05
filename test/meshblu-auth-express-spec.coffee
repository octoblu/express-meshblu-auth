MeshbluAuthExpress = require '../src/meshblu-auth-express'

describe 'MeshbluAuthExpress', ->
  describe '->getFromAnywhere', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe '2nd to worst case (bearer token)', ->
      beforeEach ->
        @result = @sut.getFromAnywhere headers: {authorization: 'Bearer Z3JlZW5pc2gteWVsbG93OmJsdWUtYS1sb3QK'}

      it 'should return the auth', ->
        expect(@result).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'worst case (invalid bearer token)', ->
      beforeEach ->
        @result = @sut.getFromAnywhere headers: {authorization: 'Bearer zpwaW5raXNoLBAD'}

      it 'should return null', ->
        expect(@result).to.be.null

  describe '->getFromBearerToken', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid bearer token', ->
      beforeEach ->
        @result = @sut.getFromBearerToken headers: {authorization: 'Bearer Z3JlZW5pc2gteWVsbG93OmJsdWUtYS1sb3QK'}

      it 'should return the auth', ->
        expect(@result).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a different valid bearer token', ->
      beforeEach ->
        @result = @sut.getFromBearerToken headers: {authorization: 'Bearer c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo='}

      it 'should return the auth', ->
        expect(@result).to.deep.equal uuid: 'super-pink', token: 'pinkish-purpleish'

    describe 'with an invalid bearer token', ->
      beforeEach ->
        @result = @sut.getFromBearerToken headers: {authorization: 'Bearer zpwaW5raXNoLBAD'}

      it 'should return null', ->
        expect(@result).to.be.null

    describe 'with an invalid header', ->
      beforeEach ->
        @result = @sut.getFromBearerToken {}

      it 'should return null', ->
        expect(@result).to.be.null

    describe 'with a different authorization scheme', ->
      beforeEach ->
        @result = @sut.getFromBearerToken headers: {authorization: 'Basic'}

      it 'should return null', ->
        expect(@result).to.not.exist

  describe '->getFromBasicAuth', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid basic auth', ->
      beforeEach ->
        @result = @sut.getFromBasicAuth headers: {authorization: 'Basic Z3JlZW5pc2gteWVsbG93OmJsdWUtYS1sb3QK'}

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a different valid basic auth', ->
      beforeEach ->
        @result = @sut.getFromBasicAuth headers: {authorization: 'Basic c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo='}

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'super-pink', token: 'pinkish-purpleish'

    describe 'with a invalid basic auth', ->
      beforeEach ->
        @result = @sut.getFromBasicAuth headers: {authorization: 'Basic zpwaW5raXNoLBAD'}

      it 'should return null', ->
        expect(@result).to.be.null

    describe 'with a invalid header', ->
      beforeEach ->
        @result = @sut.getFromBasicAuth {}

      it 'should return null', ->
        expect(@result).to.be.null

    describe 'with a different authorization scheme', ->
      beforeEach ->
        @result = @sut.getFromBasicAuth headers: {authorization: 'Bearer c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo='}

      it 'should return null', ->
        expect(@result).to.be.null

  describe '->getFromCookies', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid cookie', ->
      beforeEach ->
        @result = @sut.getFromCookies {
          cookies:
            meshblu_auth_uuid: 'greenish-yellow'
            meshblu_auth_token: 'blue-a-lot'
        }

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a valid bearer cookie', ->
      beforeEach ->
        bearer =  Buffer('i-can-barely-stand:erik', 'utf8').toString('base64')
        @result = @sut.getFromCookies cookies: {meshblu_auth_bearer: bearer}

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'i-can-barely-stand', token: 'erik'

    describe 'with a different valid cookie', ->
      beforeEach ->
        @result = @sut.getFromCookies {
          cookies:
            meshblu_auth_uuid: 'super-pink'
            meshblu_auth_token: 'pinkish-purpleish'
        }

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'super-pink', token: 'pinkish-purpleish'

    describe 'with invalid cookies', ->
      beforeEach ->
        @result = @sut.getFromCookies cookies: {}

      it 'should return null', ->
        expect(@result).to.be.null

    describe 'with a invalid header', ->
      beforeEach ->
        @result = @sut.getFromCookies {}

      it 'should return null', ->
        expect(@result).to.be.null

  describe '->getFromSkynetHeaders', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid auth', ->
      beforeEach ->
        @result = @sut.getFromXMeshbluHeaders {
          headers:
            'X-Meshblu-UUID': 'greenish-yellow'
            'X-Meshblu-Token': 'blue-a-lot'
        }

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a crazy case', ->
      beforeEach ->
        @result = @sut.getFromXMeshbluHeaders {
          headers:
            'x-meshBLU-uuID': 'greenish-yellow'
            'X-meshblu-token': 'blue-a-lot'
        }

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

  describe '->getFromSkynetHeaders', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid auth', ->
      beforeEach ->
        @result = @sut.getFromSkynetHeaders {
          headers:
            skynet_auth_uuid: 'greenish-yellow'
            skynet_auth_token: 'blue-a-lot'
        }

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

  describe '->getFromHeaders', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid basic auth', ->
      beforeEach ->
        @result = @sut.getFromHeaders {
          headers:
            meshblu_auth_uuid: 'greenish-yellow'
            meshblu_auth_token: 'blue-a-lot'
        }

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a different valid bearer token', ->
      beforeEach ->
        @result = @sut.getFromHeaders {
          headers:
            meshblu_auth_uuid: 'super-pink'
            meshblu_auth_token: 'pinkish-purpleish'
        }

      it 'should return the uuid and token', ->
        expect(@result).to.deep.equal uuid: 'super-pink', token: 'pinkish-purpleish'

    describe 'with invalid headers', ->
      beforeEach ->
        @result = @sut.getFromHeaders headers: {}

      it 'should return null', ->
        expect(@result).to.be.null

    describe 'with a invalid header', ->
      beforeEach ->
        @result = @sut.getFromHeaders {}

      it 'should set meshbluAuth on the request', ->
        expect(@result).to.be.null

    describe 'when instantiated with meshblu configuration', ->
      beforeEach ->
        @meshbluHttp =
          authenticate: sinon.stub()
        @MeshbluHttp = sinon.spy => @meshbluHttp
        dependencies = MeshbluHttp: @MeshbluHttp
        options =
          server: 'yellow-mellow'
          port: 'greeeeeeennn'

        @sut = new MeshbluAuthExpress options, dependencies

      describe 'when called with uuid and token', ->
        beforeEach ->
          @sut.authDeviceWithMeshblu 'blackened', 'bluened', (@error, @result) =>

        it 'should be instantiated', ->
          expect(@MeshbluHttp).to.be.calledWithNew

        it 'should be instantiated with the correct options', ->
          expect(@MeshbluHttp).to.be.calledWith {
            server: 'yellow-mellow'
            port: 'greeeeeeennn'
            uuid: 'blackened'
            token: 'bluened'
          }

        it 'should call meshbluHttp.device with correct url and options', ->
          expect(@meshbluHttp.authenticate).to.have.been.called

        describe 'when MeshbluHttp yields a device', ->
          beforeEach ->
            @meshbluHttp.authenticate.yield null, {uuid: 'blackened', foo: 'bar'}

          it 'should yields without an error', ->
            expect(@error).not.to.exist

          it 'should yield the credentials and server info', ->
            expect(@result).to.deep.equal {
              server: 'yellow-mellow'
              port: 'greeeeeeennn'
              uuid: 'blackened'
              token: 'bluened'
            }

        describe 'when MeshbluHttp yields an error with no code', ->
          beforeEach ->
            @meshbluHttp.authenticate.yield new Error('Generic Error')

          it 'should yields with an error', ->
            expect(=> throw @error).to.throw 'Generic Error'

        describe 'when MeshbluHttp yields an error with a 401', ->
          beforeEach ->
            error = new Error('Unauthorized')
            error.code = 401
            @meshbluHttp.authenticate.yield error

          it 'should yield nulls', ->
            expect(@error).to.be.null
            expect(@result).to.be.null

        describe 'when MeshbluHttp yields an error with a 500', ->
          beforeEach ->
            error = new Error('Internal Server Error')
            error.code = 500
            @meshbluHttp.authenticate.yield error

          it 'should yields with an error', ->
            expect(=> throw @error).to.throw 'Internal Server Error'

        describe 'when MeshbluHttp yields no device', ->
          beforeEach ->
            @meshbluHttp.authenticate.yield null, null

          it 'should yields nulls', ->
            expect(@error).to.be.null
            expect(@result).to.be.null
