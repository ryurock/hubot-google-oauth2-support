'use strict'

module.exports = {

  #
  # google OAuth token info File
  #
  tokenFile: '.tokens'

  oAuth: {}

  #
  # configure 
  # 
  # @return {Object} self
  #
  configure: () ->
    fs        = require('fs')
    google    = require('googleapis')
    OAuth2    = google.auth.OAuth2

    clientSecret = JSON.parse(fs.readFileSync('.client_secret.json'))
    @oAuth = new OAuth2(
      clientSecret.installed.client_id, 
      clientSecret.installed.client_secret, 
      clientSecret.installed.redirect_uris[0]
    )
    return @

  #
  # save token
  # @param {string} code google OAuth response code
  # @param {string} file tokens infomation save file path
  # @return {Object} Promise
  #
  saveToken: (code, file) ->
    #
    # fetch google get a token
    #
    getToken = () ->
      new Promise((resolve, reject) ->
        oAuth.getToken(code, (err, data) ->
          return reject("get token failed. code: #{err.code} reason: #{err}") if err?
          resolve(data)
        )
      )

    #
    # token infomation file write is .tokens
    #
    writeToken = (data) ->
      new Promise((resolve, reject) ->
        fs.writeFile(tokenFile, JSON.stringify(data), (err) ->
          reject(".tokens file write failed. reason: #{err}")
        )
        resolve()
      )

    oAuth      = @oAuth
    @tokenFile = file if file?
    tokenFile  = @tokenFile
    fs         = require('fs')

    tasks = [getToken, writeToken]
    tasks.reduce(((promise, task) ->
      promise.then(task)
    ), tasks.shift()())



  #
  # Google Gmail API Users.labels: list
  # @return {Function} callback
  #
  #findLabelsList: require('./findLabelsList')

  ##
  ## Google Gmail API Users.messages: list
  ## @return {Function} callback
  ##
  #findMessagesList: require('./findMessagesList')

  ##
  ## Google Gmail API Users.messages: get
  ## @return {Function} callback
  ##
  #findMessagesGet: require('./findMessagesGet')
}
