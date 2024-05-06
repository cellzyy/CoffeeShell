CoffeeShell v3
# Devlog
## 3.0
were so barrack
## 2.0 release
testing public
## User System
It has been developed. For non-sudo commands with special stuff you can use one of the users.
## 4 New Commands for 2.0
pro -- Pro License status<br>1- -- test ransomware thing (its already patched cuh removing b4 2.0 release)<br>hash -- hash random string<br>verify -- verify string and hash
## BCrypt Implemented
Took 3 hours of troubleshooting and ended up stop using su() function cuz it bugged A LOT. so wasting space again :/// BUT passwords are encrypted, usernames aren't. I made an example Ransomware coffee file 5 hours ago for testing and now I patched it because of BCrypt :) hash and verify commands wip?? maybe...
## Anti-Virus.
To protect from ransomware (aka running unauthorized .coffee files in the environment and potentionally getting your superuser info stolen) we are implementing BCrypt. This is one small step for kodakOS 2 but one huge leap for the security. Whenever I get to storing files, BCrypt will be the encryptor and you will need to have 1 thing to open files: the original filename. Can we become the best terminal based web os??? Hopefully..
# Development Logs
## May 6th (2:00 PM)
Fixed some bugs, rebranded, uploaded on my newer profile! Some commands here are outdated or leftover from KOS 2.1 The unreleased KodakOS version.
## Feburary 15th (9:20 AM)
Quick update in math class, fixed bugs two new test commands not listed in help
## Feburary 15th (1:20 AM)
I have released a PATCH to clear up the remaining bugs from the build. Here are all the fixes:<br>
- Patched GET Request not prompting os()<br>
- Patched POST Request not prompting os()<br>
- Patched Invalid Command not prompting os()<br>
- Added error support for GET<br>
- Added error support for POST<br>
- Removed upgrade —force (REPLIT DISABLED OPEN BRUH)<br>
- Patched some superuser stuff I think idrm<br>
- Removed Herobrine
## Feburary 15th (12:40 AM)
Writing another one of these because I made MAJOR progress. You can now create super user, and it uses localstorage so it should NEVER clear out unless you specify in browser settings, post and get requests work with superuser priviledges and theres a help command. It takes a little less to load now thanks to some other module but it still reads the code kinda slow, basically CoffeeScript is JavaScript but easier with more MODULES! Thats right, CS can load *NODE.JS MODULES* best part about it **NGL**. I have been a working machine for the past few hours and idk when I'm gonna stop really, I might have more time to work tomorrow because someone called in a threat at my school and their deciding if they close or heavily protect the school, depends, prob won't go but education is important! 4 new commands as of now for 11:50 AM, I'm gonna release the first kodakOS lemon build, 1.0
## Feburary 14th (11:50 PM)
Yooo! Whats up? Decided to do a little bit of a devlog but I got a mockup working in CoffeeScript, it has 2 commands and sadly takes 2-8 seconds to load the whole Terminal OS because of me using request lol. Anyways I wanna say it's going good and might be able to release a build very soon. Just uh, won't be as good. Still haven't added flags, might work on that. Like for example I could do, upgrade --force to force user to the github page IF they need an upgrade. I hope you enjoyed todays devlog, might make a development video on my channel https://www.youtube.com/@NamedTech let me know if you guys wanna see new features.
# How?
CoffeeShell is a shell-based thing for Web. Powered with CoffeeScript.
# Deploy
Download and Reupload to Repl.
# Contact
Github Issues.
