require 'bundler'
Bundler.require

system('bundle install')
Launchy.open("http://localhost:4567/")
system('shotgun -p 4567')
