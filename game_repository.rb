require "ang_ttt_gem"
require "game"

class GameRepository

  def save(player_data)
    File.open('state_machine.rb', 'w') do |file|
      file.print player_data.to_yaml
    end
  end
end