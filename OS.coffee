# kodakOS@lemon/1.0-patch
# uarcell@proton.me

prompt = require 'prompt'
request = require 'request'
localStorage = require 'localStorage'
sm = 'this__Software__LEMON1.1'
smURL = 'https://raw.githubusercontent.com/Celluarbyte/kodakOS/main/KodakSoftwareUpdate.txt'

version = () ->
  console.log 'kodakOS [Lemon] / 1.1 software (GH: Celluarbyte)'
  os()

upgrade = () ->
  request.get smURL, (error, response, body) ->
    if !error && response.statusCode == 200
      if body.trim( ) == sm
        console.log 'kodakOS is updated.'
      else
        console.log 'Get new kodakOS version on GitHub.'
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
    if !error
      console.log response
      os()
    else
      console.log 'Couldn\'t send out GET request.'
      os()

post = (http, jsona) ->
  request.post http, { json: jsona }, (error, response, body) ->
    if !error
      console.log response
      os()
    else
      console.log 'Couldn\'t send out POST request JSON.'
      os()

su_get = () ->
  prompt.get ['user', 'pass', 'url'], (err, result) ->
   if su(result.user, result.pass)
      console.clear()
      console.log 'Logged in.'
      get(result.url)
    else
      console.clear()
      console.log '? invalid SU login.'
      os()

su_post = () ->
  prompt.get ['user', 'pass', 'url', 'json'], (err, result) ->
    if su(result.user, result.pass)
      console.clear()
      console.log 'Logged in.'
      post(result.url, JSON.parse result.json)
    else
      console.clear()
      console.log '? invalid SU login.'
      os()

help = () ->
  console.log 'Check for newest Upgrades for your OS. - upgrade'
  console.log 'Shows version number - version'
  console.log 'Setup superuser - sudo setup'
  console.log 'Get request, REQUIRES SUPERUSER. [sudo get]'
  console.log 'Post request, REQUIRES SUPERUSER. [sudo post]'
  os()

clear = () ->
  console.clear()
  os()

functionShell = (func) ->
  commands = {
    'version': version,
    'upgrade': upgrade,
    'help': help,
    'sudo setup': su_setup,
    'sudo get': su_get,
    'sudo post': su_post,
    'clear': clear
  }

  # Hard Coded flags for now
  # erm hardcode echo

  if commands[func]
    commands[func]()
  else
    if func.split " "[0] == "echo"
      y = func.split " "
      i = 1
      a = ""
      while i < y.length 
        a = a + y[i] + " "
        i++
      console.log a
      os()
    else
      console.log "Command '#{func}' doesn't exist"
      os()

os = () ->
  prompt.get ['shell'], (err, result) ->
    functionShell(result?.shell?.trim())

console.log 'First time kodakOS users or if theres a new update, run help.'
os()
