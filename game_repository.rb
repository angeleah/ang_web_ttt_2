require "yaml"
require "pry"

class GameRepository
  
  def save(data)
    # if data[:id].nil?
    #   create_id
    # end
     File.open('state_machine.yml', 'w+') do |file|
       file.print data.to_yaml
     end
   end
  # def save(data)
  #    File.open('state_machine.yml', 'w') do |file|
  #      Time.now = data
  #      new_data = id.merge!(data)
  #      file.print new_data.to_yaml
  #      id = new_data[:id]
  #    end
  #  end
  
  def load(id)
     YAML::load(File.read('state_machine.yml'))
  end
  
  def read_all_game_data
    YAML::load(File.read('state_machine.yml'))
  end
  
  def add_id(data)
    game_data = data
    if game_data[:id].nil?
      game_data[:id] = create_id
    end
    game_data
  end

  def create_id
    game_hash = read_all_game_data
    count = game_hash[:count]
    if count.nil?
      count = 1
    else
      count = count += 1
    end
    count
  end
  
  #I need to -> read all game data, if count == 0 start with 1
end