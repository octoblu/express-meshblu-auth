MeshbluAuthExpress = require '../src/meshblu-auth-express'

describe 'MeshbluAuthExpress', ->

  describe '->setFromBearerToken', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid bearer token', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            authorization: 'Bearer Z3JlZW5pc2gteWVsbG93OmJsdWUtYS1sb3QK'
        @sut.setFromBearerToken(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a different valid bearer token', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            authorization: 'Bearer c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo='
        @sut.setFromBearerToken(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'super-pink', token: 'pinkish-purpleish'

    describe 'with a invalid bearer token', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            authorization: 'Bearer zpwaW5raXNoLBAD'
        @sut.setFromBearerToken(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

    describe 'with a invalid header', ->
      beforeEach ->
        @next = sinon.spy()
        @request = {}
        @sut.setFromBearerToken(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

    describe 'with a different authorization scheme', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            authorization: 'Basic'
        @sut.setFromBearerToken(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

  describe '->setFromBasicAuth', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid basic auth', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            authorization: 'Basic Z3JlZW5pc2gteWVsbG93OmJsdWUtYS1sb3QK'
        @sut.setFromBasicAuth(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a different valid basic auth', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            authorization: 'Basic c3VwZXItcGluazpwaW5raXNoLXB1cnBsZWlzaAo='
        @sut.setFromBasicAuth(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'super-pink', token: 'pinkish-purpleish'

    describe 'with a invalid basic auth', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            authorization: 'Basic zpwaW5raXNoLBAD'
        @sut.setFromBasicAuth(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

    describe 'with a invalid header', ->
      beforeEach ->
        @next = sinon.spy()
        @request = {}
        @sut.setFromBasicAuth(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

    describe 'with a different authorization scheme', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            authorization: 'Bearer'
        @sut.setFromBasicAuth(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist


  describe '->setFromCookies', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid cookie', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          cookies:
            meshblu_auth_uuid: 'greenish-yellow'
            meshblu_auth_token: 'blue-a-lot'
        @sut.setFromCookies(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a different valid cookie', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          cookies:
            meshblu_auth_uuid: 'super-pink'
            meshblu_auth_token: 'pinkish-purpleish'
        @sut.setFromCookies(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'super-pink', token: 'pinkish-purpleish'

    describe 'with invalid cookies', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          cookies: {}
        @sut.setFromCookies(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

    describe 'with a invalid header', ->
      beforeEach ->
        @next = sinon.spy()
        @request = {}
        @sut.setFromCookies(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

  describe '->setFromSkynetHeaders', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid auth', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            'X-Meshblu-UUID': 'greenish-yellow'
            'X-Meshblu-Token': 'blue-a-lot'
        @sut.setFromXMeshbluHeaders(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a crazy case', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            'x-meshBLU-uuID': 'greenish-yellow'
            'X-meshblu-token': 'blue-a-lot'
        @sut.setFromXMeshbluHeaders(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

  describe '->setFromSkynetHeaders', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid auth', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            skynet_auth_uuid: 'greenish-yellow'
            skynet_auth_token: 'blue-a-lot'
        @sut.setFromSkynetHeaders(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

  describe '->setFromHeaders', ->
    beforeEach ->
      @sut = new MeshbluAuthExpress

    describe 'with a valid basic auth', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            meshblu_auth_uuid: 'greenish-yellow'
            meshblu_auth_token: 'blue-a-lot'
        @sut.setFromHeaders(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'greenish-yellow', token: 'blue-a-lot'

    describe 'with a different valid bearer token', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers:
            meshblu_auth_uuid: 'super-pink'
            meshblu_auth_token: 'pinkish-purpleish'
        @sut.setFromHeaders(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.deep.equal uuid: 'super-pink', token: 'pinkish-purpleish'

    describe 'with invalid headers', ->
      beforeEach ->
        @next = sinon.spy()
        @request =
          headers: {}
        @sut.setFromHeaders(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

    describe 'with a invalid header', ->
      beforeEach ->
        @next = sinon.spy()
        @request = {}
        @sut.setFromHeaders(@request)

      it 'should set meshbluAuth on the request', ->
        expect(@request.meshbluAuth).to.not.exist

    describe 'when instantiated with meshblu configuration', ->
      beforeEach ->
        @meshbluHttp =
          whoami: sinon.stub()
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
          expect(@MeshbluHttp).to.be.calledWith server: 'yellow-mellow', port: 'greeeeeeennn', uuid: 'blackened', token: 'bluened'

        it 'should call meshbluHttp.device with correct url and options', ->
          expect(@meshbluHttp.whoami).to.have.been.called

        describe 'when MeshbluHttp yields a device', ->
          beforeEach ->
            @meshbluHttp.whoami.yield null, {uuid: 'blackened'}

          it 'should yields without an error', ->
            expect(@error).to.not.exist

        describe 'when MeshbluHttp yields an error', ->
          beforeEach ->
            @meshbluHttp.whoami.yield new Error('not authorized')

          it 'should yields with an error', ->
            expect(@error).to.exist

        describe 'when MeshbluHttp yields no device', ->
          beforeEach ->
            @meshbluHttp.whoami.yield null, null

          it 'should yields with an error', ->
            expect(@error).to.exist
