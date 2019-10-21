require 'csv'
require 'pry'
#
class Commentaries
  attr_accessor :commentary

  def initialize(gossip_id, comm)
    @gossip_id = gossip_id
    @commentary = comm
  end

  def self.find(id)
    # On récupère l'array de la méthode all
    all_commentaries = all
    selected_gossip = []
    all_commentaries.each_with_index do |object, i|
      # dès qu'on tombe sur l'object dont l'index+1 est égal à l'id on l'insère dans un nouvel array
      if i + 1 == id
        selected_gossip << object
      end
    end
    # On return un array contenant le potin choisi 
    selected_gossip
  end

  def self.all
    all_commentaries = []
    CSV.read("./db/commentary#{@id}.csv").each do |csv_line|
      all_commentaries << Gossip.new(csv_line[0], csv_line[1])
    end
    all_commentaries
  end
  # Saves author and content attributes the gossip.csv file
  def save(id)
    Dir.chdir('./db/') do
      file = File.open("commentary#{id}.csv", 'w')
      file.close
    end
    CSV.open("./db/commentary#{id}.csv", 'ab') do |csv|
      csv << [@commentary]
    end
  end

  def self.update(id, edited_author, edited_gossip)
    csv = CSV.read('./db/gossip.csv')
    csv[id-1] = [edited_author, edited_gossip]
    CSV.open('./db/gossip.csv', 'wb') do |csv_line|
      csv.each { |gossip| csv_line << gossip}
    end
  end
  #binding.pry
end