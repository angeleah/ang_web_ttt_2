require "game"
require "yaml"

class GameRepository

  def save(data)
    File.open('state_machine.yml', 'w+') do |file|
      file.print data.to_yaml
    end
  end
  
  def load
     YAML::load(File.read('state_machine.yml'))
  end
end


###consider adding the id to the hash.  
#Also Jeremy's suggestion of the turn value of 1 or 2.