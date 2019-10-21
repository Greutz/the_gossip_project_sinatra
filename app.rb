require 'bundler'
Bundler.require

Launchy.open("http://localhost:4567/")
system('shotgun -p 4567')
