# hubot-google-oauth2-support

hubot google oauth2 support

See [`src/google-oauth2-support.coffee`](src/google-oauth2-support.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-google-oauth2-support --save`

Then add **hubot-google-oauth2-support** to your `external-scripts.json`:

```json
[
  "hubot-google-oauth2-support"
]
```

## NodeJS Version

~0.12

## Usage

[Google Developers Console](https://console.developers.google.com) your Project page. OAuth Credential Download JSON

JSON file is hubot current dir ``` .client_secret.json ```


## Sample Interaction

```
# search google api oauth scope help list
user1>> hubot google api oauth scope help
hubot>> Google Apis Authorizing OAuth2 scope help.
 Google Apis Drive scope.        https://developers.google.com/drive/web/scopes
 Google Apis Calender scope.     https://developers.google.com/google-apps/calendar/auth
 Google Apis BigQuery scope.     https://cloud.google.com/bigquery/authorization
 Google Apis Gmail scope.        https://developers.google.com/gmail/api/auth/scopes
 more Apis.                      https://developers.google.com/apis-explorer/#p/

# generate google authentication URL
user1>> hubot google oauth generate auth url https://www.googleapis.com/auth/gmail.readonly
hubot>> Auth URL
https://accounts.google.com/o/oauth2/auth?access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fgmail.readonly&response_type=code&client_id={xxxxxxx}&redirect_uri={xxxxxxx}

# token infomation save a file <.tokens>
user1>> hubot google oauth set token {your authentication code}
hubot>> token setting ok. detail see .tokens file)

# token infomation find file <.tokens>
user1>> hubot google oauth get token
hubot>> token info
 access_token: xxxxxxxxxx
 token_type: Bearer
 refresh_token: xxxxxxxxxxxxxxx
 expiry_date: 1435435666020
```


## Debbugging script

### Requirements npm module

* hubot
* yo
* grunt
* coffee-script

see [getting-started-with-hubot](https://hubot.github.com/docs/#getting-started-with-hubot)

### Install requirement npm

```
npm install -g hubot yo gruntc-li coffee-script
```

### run shell mode hubot scrpit

```
cd /path/to/hubot-gmail-api-messages
HUBOT_SHELL_USER_NAME='{your user name}' PATH="./node_modules/hubot/node_modules/.bin:$PATH" $(npm bin)/hubot -a shell -n hubot -r src
```

### Test

* [Mocha](http://mochajs.org/) to Hubot Reference URL [Testable Hubot - TDDでテストを書きながらbotを作る](http://devlog.forkwell.com/2014/10/28/testable-hubot-tdddetesutowoshu-kinagarabotwozuo-ru/)
* [Hubot スクリプトのテストやその環境を知ろう](http://qiita.com/bouzuya/items/e23426ecf039154bed7b)

```
grunt test
```
