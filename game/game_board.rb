class GameBoard
  def self.player_added(player)
    puts "#{player.name} was added"
  end
  
  def self.show_num_of_players(number)
    puts "There is #{number} number of players"
  end

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
  
  def self.correct_answer
    puts "Answer was correct!!!!"
  end
  
  def self.wrong_answer
    puts "Question was incorrectly answered"
  end

  def self.show_points(player)
    puts "#{player.name} now has #{player.point} Gold Coins."
  end

  def self.sent_to_penalty_box(player)
    puts "#{player.name} was sent to penalty box"
  end

  def self.show_question(question)
    puts question if !question.nil?
  end
end
