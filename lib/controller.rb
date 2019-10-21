require 'gossip'
require 'commentaries'
# Classe gérant les différents pages à utiliser
class ApplicationController < Sinatra::Base
  # à la racine de l'url, on affiche l'index, avec une liste des gossip et un lien pour en créer de nouveaux
  get '/' do
    # On passe la méthode de classe all à index.erb
    erb :index, locals: {gossips: Gossip.all}
  end
  # utilise un chemin dynamique pour afficher une page par gossip
  get '/gossips/:id/' do
    # On dissocie l'url /gossips/new/ des urls /gossips/n/ (qui affichent les pages des gossips)
    if params['id'] == 'new'
      erb :new_gossip
    else
      # On passe le numéro de gossip selectionné et la méthode find pour afficher le gossip voulu
      erb :show, locals: {id: params['id'], gossip: Gossip.find(params['id'].to_i)}
    end
  end
  #post '/gossips/:id/' do
    #Commentaries.new(params['id'], params["commentary"]).save
    #redirect "/gossips/#{params['id'].to_i}/"
  #end
  # Méthode à effectuer sur l'url http://localhost:4567/gossips/new/
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params['id'], gossip: Gossip.find(params['id'].to_i)}
  end
  post '/gossips/:id/edit/' do
    Gossip.update(params['id'].to_i, params["edit_author"], params["edit_content"])
    redirect "/gossips/#{params['id'].to_i}/"
  end
end
