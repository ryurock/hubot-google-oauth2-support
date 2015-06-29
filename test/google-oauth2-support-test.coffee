chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'google-oauth2-support', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/google-oauth2-support')(@robot)

  it 'registers a respond listener oauth scope help', ->
    expect(@robot.respond).to.have.been.calledWith(/google\s*(.oauth\sscope\shelp)?$/i)

  it 'registers a respond listener oauth generate auth url {google auth scope}', ->
    expect(@robot.respond).to.have.been.calledWith(/google\s*(.oauth\sgenerate\sauth\surl)\s(.*)$/i)

  it 'registers a respond listener oauth set token', ->
    expect(@robot.respond).to.have.been.calledWith(/google\s*(.oauth\sset\stoken)\s(.*)?$/i)

  it 'registers a respond listener oauth get token', ->
    expect(@robot.respond).to.have.been.calledWith(/google\s*(.oauth\sget\stoken)?$/i)
