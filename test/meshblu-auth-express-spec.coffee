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

  describe '->authDeviceWithMeshblu', ->
    describe 'when instantiated without meshblu configuration', ->
      beforeEach ->
        @sut = new MeshbluAuthExpress

      describe 'when called with uuid and token', ->
        beforeEach (done) ->
          @sut.authDeviceWithMeshblu 'cool-blue', 'redish-kinda', (@error) => done()

        it 'should have an error', ->
          expect(@error).to.exist

      describe 'when called without uuid and token', ->
        beforeEach (done) ->
          @sut.authDeviceWithMeshblu null, null, (@error) => done()

        it 'should have an error', ->
          expect(@error).to.exist

    describe 'when instantiated with meshblu configuration', ->
      beforeEach ->
        @request = {}
        @request.get = sinon.stub().yields null, {}, devices: [uuid: 'blackened']
        dependencies = request: @request
        options =
          json: true
          server: 'yellow-mellow'
          port: 'greeeeeeennn'
          protocol: 'https'

        @sut = new MeshbluAuthExpress options, dependencies

      describe 'when called with valid uuid and token', ->
        beforeEach (done) ->
          @sut.authDeviceWithMeshblu 'blackened', 'bluened', (@error) => done()

        it 'should call request.get with correct url and options', ->
          url = "https://yellow-mellow:greeeeeeennn/devices/blackened"
          options =
            json: true
            auth:
              user: 'blackened'
              pass: 'bluened'

          expect(@request.get).to.have.been.calledWith url, options

        it 'should yields without an error', ->
          expect(@error).to.not.exist

    describe 'when instantiated with different meshblu configuration and yeilds an error', ->
      beforeEach ->
        @request = {}
        @request.get = sinon.stub().yields new Error('unable to validate device'), {}, {}
        dependencies = request: @request
        options =
          json: true
          server: 'mellow-yellow'
          port: 'purplleeee'
          protocol: 'https'

        @sut = new MeshbluAuthExpress options, dependencies

      describe 'when called with invalid uuid and token', ->
        beforeEach (done) ->
          @sut.authDeviceWithMeshblu 'cheese-yellow', 'blue-cheese', (@error) => done()

        it 'should call request.get with correct url and options', ->
          url = "https://mellow-yellow:purplleeee/devices/cheese-yellow"
          options =
            json: true
            auth:
              user: 'cheese-yellow'
              pass: 'blue-cheese'

          expect(@request.get).to.have.been.calledWith url, options

        it 'should yields with an error', ->
          expect(@error).to.exist

    describe 'when instantiated with different meshblu configuration and yeilds no devices', ->
      beforeEach ->
        @request = {}
        @request.get = sinon.stub().yields null, {}, devices: []
        dependencies = request: @request
        options =
          json: true
          server: 'mellow-yellow'
          port: 'purplleeee'
          protocol: 'https'

        @sut = new MeshbluAuthExpress options, dependencies

      describe 'when called with invalid uuid and token', ->
        beforeEach (done) ->
          @sut.authDeviceWithMeshblu 'cheese-yellow', 'blue-cheese', (@error) => done()

        it 'should call request.get with correct url and options', ->
          url = "https://mellow-yellow:purplleeee/devices/cheese-yellow"
          options =
            json: true
            auth:
              user: 'cheese-yellow'
              pass: 'blue-cheese'

          expect(@request.get).to.have.been.calledWith url, options

        it 'should yields with an error', ->
          expect(@error).to.exist
