# Description
#   hubot google API oauth2 support
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot google oauth scope help - <Google Apis authorization scope help.>
#   hubot google oauth generate auth url {Scope URL} - <Generating an Google authentication URL>
#   hubot google oauth set token {code} - <token file save(file path .tokens)>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   ryurock <ryusukekimura3@gmail.com>


module.exports = (robot) ->
  apiClient = require('./../lib/google/api')
  apiClient.configure()

  robot.respond /google\s*(.oauth\sscope\shelp)?$/i, (res) ->
      res.reply "
      Google Apis Authorizing OAuth2 scope help.\n
      Google Apis Drive scope.        https://developers.google.com/drive/web/scopes\n
      Google Apis Calender scope.     https://developers.google.com/google-apps/calendar/auth\n
      Google Apis BigQuery scope.     https://cloud.google.com/bigquery/authorization\n
      Google Apis Gmail scope.        https://developers.google.com/gmail/api/auth/scopes\n
      more Apis.                      https://developers.google.com/apis-explorer/#p/
      "

  #
  # respond generate URL. Google OAuth2 Authorizing Page
  # @param {String} 'google oauth generate auth url'
  #
  robot.respond /google\s*(.oauth\sgenerate\sauth\surl)\s(.*)$/i, (res) ->
    return res.send "invalid scope url" unless res.match[2].match(/^(https)(:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:¥@&=+¥$,%#]+)$/)

    scopeUrl = res.match[2]
    url = apiClient.oAuth.generateAuthUrl({access_type: 'offline', scope: scopeUrl})
    res.reply("Auth URL \n#{url}")

  #
  # respond set token result message
  # @param {String} 'google oauth set token <token>'
  #
  robot.respond /google\s*(.oauth\sset\stoken)\s(.*)?$/i, (res) ->
    code = res.match[2]
    apiClient
      .saveToken(code)
      .then(() ->
        res.reply("token setting ok. detail see #{apiClient.tokenFile} file")
      ).catch((error) ->
        res.reply(error)
      )

  #
  # respond get token result message
  # @param {String} 'google oauth get token'
  #
  robot.respond /google\s*(.oauth\sget\stoken)?$/i, (res) ->
    fs = require('fs')
    tokens = JSON.parse(fs.readFileSync('.tokens'))
    res.reply("
      token info \n
      access_token: #{tokens.access_token} \n
      token_type: #{tokens.token_type} \n
      refresh_token: #{tokens.refresh_token} \n
      expiry_date: #{tokens.expiry_date}
    ")
