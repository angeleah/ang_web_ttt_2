require "yaml"
require "pry"

class GameRepository

  def save(id, data)
    File.open("games/#{id}.yml", 'w') { |f| f.print data.to_yaml }
  end

  def load(id)
     YAML::load(File.read("games/#{id}.yml"))
  end
  
  def delete(id)
    File.delete("games/#{id}.yml")
  end
end