require "ang_ttt_gem"
require "game"

class GameRepository

  def save(data)
    File.open('state_machine.rb', 'w') do |file|
      file.print data.to_yaml
    end
  end
  
  def load
    data = YAML::load(File.read('state_machine.rb'))
  end
end


###consider adding the id to the hash.  
#Also Jeremy's suggestion of the turn value of 1 or 2.