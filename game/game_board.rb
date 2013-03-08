class GameBoard
  def self.show_current_player(player)
    puts "#{player.name} is the current player"
  end

  def self.show_location_of(player)
    puts "#{player.name}'s new location is #{player.current_place}"
  end

  def self.out_of_box(player)
    puts "#{player.name} is getting out of the penalty box"
  end

  def self.not_out_of_box(player)
    puts "#{player.name} is not getting out of the penalty box"
  end

  def self.show_category(category)
    puts "The category is #{category}"
  end

  def self.show_roll(roll) 
    puts "They have rolled #{roll}"
  end
end
