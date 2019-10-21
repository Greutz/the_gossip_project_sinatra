require 'csv'
require 'pry'
#
class Gossip
  attr_accessor :author, :content, :id

  def initialize(author, content)
    @author = author
    @content = content
    @id = object_id
  end
  
  def save
    CSV.open('./db/gossip.csv', 'ab') do |csv|
      csv << [@author, @content, @id]
    end
  end
  
  def self.find(id)
    # On récupère l'array de la méthode all
    all_gossips = all
    selected_gossip = []
    all_gossips.each_with_index do |object, i|
      # dès qu'on tombe sur l'object dont l'index+1 est égal à l'id on l'insère dans un nouvel array
      if i + 1 == id
        selected_gossip << object
      end
    end
    # On return un array contenant le potin choisi 
    selected_gossip
  end

  def self.all
    all_gossips = []
    CSV.read('./db/gossip.csv').each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    all_gossips
  end
  # Saves author and content attributes the gossip.csv file

  def self.update(id, edited_author, edited_gossip)
    csv = CSV.read('./db/gossip.csv')
    csv[id-1] = [edited_author, edited_gossip]
    CSV.open('./db/gossip.csv', 'wb') do |csv_line|
      csv.each { |gossip| csv_line << gossip}
    end
  end
  #binding.pry
end