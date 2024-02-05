# kodakOS@lemon/1.0
# uarcell@proton.me

prompt = require 'prompt'
request = require 'request'
localStorage = require 'localStorage'
sm = 'this__Software__LEMON1.0'
smURL = 'https://raw.githubusercontent.com/Celluarbyte/kodakOS/main/KodakSoftwareUpdate.txt'

version = () ->
  console.log 'kodakOS [Lemon] / 1.0.0 software (GH: Celluarbyte)'
  os()

upgrade = (force) ->
  request.get smURL, (error, response, body) ->
    if !error && response.statusCode == 200
      if body.trim( ) == sm
        console.log 'kodakOS is updated.'
      else
        console.log 'Get new kodakOS version on GitHub.'
        if force
          console.log 'Nevermind, forcing you to the GitHub page right now.'
          window.open("https://www.github.com/Celluarbyte/kodakOS", "_blank")
          console.log 'Completed Task'
    else
      console.log 'Failed to Connect to Internet.'
  os()

su = (user, pass) ->
  if user == localStorage.getItem('su_user') && pass == localStorage.getItem('su_pass')
    return true
  else
    return false

su_setup = () ->
  sudoChecker = localStorage.getItem('SUDO__SETTED')
  if !sudoChecker
    prompt.get ['user', 'password'], (err, result) ->
      localStorage.setItem('su_user', result.user)
      localStorage.setItem('su_pass', result.password)
      localStorage.setItem('SUDO__SETTED', true)
      console.clear()
      console.log 'Superuser has been created and saved. You can no longer make or modify these details regulary in the OS unless some Third-Party terms.'
      os()
  else
    console.log 'Superuser already been setup.'
    os()

get = (http) ->
  request.get http, (error, response, body) ->
    console.log 'Submitted GET'
    console.log body

post = (http, jsona) ->
  request.post http, { json: jsona }, (error, response, body) ->
    console.log 'Submitted POST'
    console.log body

su_get = () ->
  prompt.get ['user', 'pass', 'url'], (err, result) ->
   if su(result.user, result.pass)
      console.log 'Logged in.'
      get(result.url)
    else
      console.log '? invalid SU login.'

su_post = () ->
  prompt.get ['user', 'pass', 'url', 'json'], (err, result) ->
    if su(result.user, result.pass)
      console.log 'Logged in.'
      post(result.url, JSON.parse result.json)
    else
      console.log '? invalid SU login.'

help = () ->
  console.log 'Check for newest Upgrades for your OS. - upgrade'
  console.log 'Shows version number - version'
  console.log 'Setup superuser - sudo setup'
  console.log 'Get request, REQUIRES SUPERUSER. [sudo get]'
  console.log 'Post request, REQUIRES SUPERUSER. [sudo post]'
  os()

functionShell = (func) ->
  commands = {
    'version': version,
    'upgrade': upgrade,
    'help': help,
    'sudo setup': su_setup,
    'sudo get': su_get,
    'sudo post': su_post
  }

  # Hard Coded flags for now

  if commands[func]
    commands[func]()
  else
    if func == 'upgrade --force'
        upgrade(true)
    else
      console.log "Command '#{func}' doesn't exist"

os = () ->
  prompt.get ['shell'], (err, result) ->
    functionShell(result?.shell?.trim())

console.log 'First time kodakOS users or if theres a new update, run help.'
os()
