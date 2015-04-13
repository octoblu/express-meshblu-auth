MeshbluAuthExpress = require '../src/meshblu-auth-express'

describe 'MeshbluAuthExpress', ->
  beforeEach ->
    @sut = new MeshbluAuthExpress

  describe '->setFromBearerToken', ->
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
