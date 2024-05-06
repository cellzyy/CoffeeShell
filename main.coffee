## CoffeeShell v3 ##

user = null
prompt = require 'prompt'
request = require 'request'
localStorage = require 'localStorage'
bcrypt = require 'bcryptjs'
sm = 'IcedCoffee'
smURL = 'https://raw.githubusercontent.com/mctnb/CoffeeShell/main/software'

elevatedPrint = (Print) ->
  console.log "\x1b[35m#{Print}\x1b[0m"

version = () ->
  console.log 'CoffeeShell v3'

upgrade = () ->
  request.get smURL, (error, response, body) ->
    if !error && response.statusCode == 200
      if body.trim( ) == sm
        console.log '☕️ Updated!'
      else
        elevatedPrint 'The coffee spilled. Please upgrade CoffeeShell.'
    else
      elevatedPrint 'Internet Connection Failed!'

su = (user, pass) ->
  storedUser = localStorage.getItem('su_user')
  storedPass = localStorage.getItem('su_pass')
  if user == storedUser
    console.log 'user correct'
    bcrypt.compare pass.trim(), storedPass.trim(), (err, res) ->
      if res
        return true
      else
        return false
  else
    return false
  
su_setup = () ->
  sudoChecker = localStorage.getItem('SUDO__SETTED')
  if !sudoChecker
    prompt.get ['user', 'password'], (err, result) ->
      localStorage.setItem('su_user', result.user)
      bcrypt.hash result.password, 10, (err, hash) ->
        bcrypt.compare result.password, hash, (err, res) ->
          elevatedPrint "Success!"
          localStorage.setItem('su_pass', hash)
      localStorage.setItem('SUDO__SETTED', true)
      console.clear()
      elevatedPrint 'Superuser has been created and saved. You can no longer make or modify these details regulary in the OS unless some Third-Party terms.'
  
  else
    console.clear()
    elevatedPrint 'Superuser already been setup.'
    

get = (http) ->
  request.get http, (error, response, body) ->
    if !error
      console.log response
      
    else
      console.log 'Couldn\'t send out GET request.'
      

post = (http, jsona) ->
  request.post http, { json: jsona }, (error, response, body) ->
    if !error
      console.log response
      
    else
      console.log 'Couldn\'t send out POST request JSON.'
      

su_get = () ->
  prompt.get ['user', 'pass', 'url'], (err, result) ->
    storedUser = localStorage.getItem('su_user')
    storedPass = localStorage.getItem('su_pass')
    if result.user == storedUser
      console.log 'user correct'
      bcrypt.compare result.pass.trim(), storedPass.trim(), (err, res) ->
        if res
          console.clear()
          elevatedPrint 'Logged in.'
          get(result.url)
        else
          console.clear()
          elevatedPrint '? invalid SU login.'
          
    else
      console.clear()
      elevatedPrint '? invalid SU login.'
    

su_post = () ->
  prompt.get ['user', 'pass', 'url', 'json'], (err, result) ->
    storedUser = localStorage.getItem('su_user')
    storedPass = localStorage.getItem('su_pass')
    if result.user == storedUser
      console.log 'user correct'
      bcrypt.compare result.pass.trim(), storedPass.trim(), (err, res) ->
        if res
          console.clear()
          elevatedPrint 'Logged in.'
          get(result.url)
        else
          console.clear()
          elevatedPrint '? invalid SU login.'
        
    else
      console.clear()
      elevatedPrint '? invalid SU login.'

help = () ->
  console.log 'Check for newest Upgrades for your OS. - upgrade'
  console.log 'Shows version number - version'
  console.log 'Setup superuser - sudo setup'
  console.log 'Get request, REQUIRES SUPERUSER. [sudo get]'
  console.log 'Post request, REQUIRES SUPERUSER. [sudo post]'
  console.log 'Clear like in BAT env - clear'
  console.log 'Check Pro License - pro'
  console.log "User permissions - user login, user create, user logout"
  console.log "hash strings and verify - hash, verify"
  console.log "Thanks message - support"

clear = () ->
  console.clear()

pro = () ->
  elevatedPrint "Pro is already activated?"

ransomware = () ->
  elevatedPrint "This is deprecated, in 2.1 this was unsupported."
  elevatedPrint "STEALING USERNAME [sudo]"
  user = localStorage.getItem("su_user")
  elevatedPrint "Hello, #{user}"
  elevatedPrint "STEALING PASSWORD [sudo]"
  password = localStorage.getItem("su_pass")
  elevatedPrint "WOW!! #{password}"
  elevatedPrint "REWRITING YOUR SUDO PERMISSIONS [disabled for demo]"
  elevatedPrint "Your information has been stolen, thanks! ;) We <3 private information!"
  elevatedPrint "Ransomware Demo end. We are making it harder to steal information atm."
  elevatedPrint "As of BCrypt implementation, no longer need to worry :)"
  

hash_CMD = () ->
  prompt.get ['string'], (err, result) ->
    bcrypt.hash result.string, 10, (err, hash) ->
      console.log hash
      

verify_CMD = () ->
  prompt.get ['string', 'hash'], (err, result) ->
    bcrypt.compare result.string, result.hash, (err, res) ->
      console.log res
      

newUser = () ->
  prompt.get ["Username", "Password"], (err, result) ->
    if localStorage.getItem(result.Username) == null
      bcrypt.hash result.Password, 10, (err, hash) ->
        localStorage.setItem(result.Username, hash)
        elevatedPrint "User created."
      
    else
      elevatedPrint "Sorry, this user already exists."
    

userLogin = () ->
  prompt.get ["user", "login"], (err, result) ->
    user0 = localStorage.getItem(result.user)
    if user0
      bcrypt.compare result.login, user0, (err, res) ->
        if res == true
          elevatedPrint "Logged in"
          user = result.user
          os()
        else
          elevatedPrint "Failed Login"
          
    else
      elevatedPrint "Failed Login"
      

logout = () ->
  if !user
    elevatedPrint "No user logged in."
    
  else
    user = null
    elevatedPrint "Logged out"
    

support = () ->
  elevatedPrint "Thanks for supporting by using CoffeeShell. ☕️🖱️"
    
functionShell = (func) ->
  commands = {
    'version': version,
    'upgrade': upgrade,
    'help': help,
    'sudo setup': su_setup,
    'sudo get': su_get,
    'sudo post': su_post,
    'clear': clear,
    'pro': pro,
    'Deprecated.virus.test()': ransomware,
    'hash': hash_CMD,
    'verify': verify_CMD,
    'user create': newUser,
    'user login': userLogin,
    'user logout': logout,
    'support': support
  }

  # Hard Coded flags for now
  # echo removed for now

  if commands[func]
    commands[func]()
  else
    elevatedPrint "Command '#{func}' doesn't exist"
    

os = () ->
  prompt.get ['shell'], (err, result) ->
    functionShell(result?.shell?.trim())
    os()

elevatedPrint 'CoffeeShell @ 2023-2024 // CellDev (MCTNB)'
os()
