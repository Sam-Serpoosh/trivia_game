require_relative 'ugly_trivia_game'

describe UglyTrivia::Game do
  let(:game) { UglyTrivia::Game.new }

  context "#roll" do
    it "rolls withe an odd number getting out of the box" do
      game.add("sam")
      game.roll(3)
      game.current_player.current_place.should == 3
      game.is_getting_out_of_penalty_box.should be_true
    end

    it "rolls with an even number same place and not getting out of the box" do
      game.add("sam")
      game.roll(2)
      game.current_player.current_place.should == 0
      game.is_getting_out_of_penalty_box.should be_false
    end

    it "rolls and player is not in the penalty box change the place" do
      game.add("sam")
      game.add("dave")
      game.current_player = 1
      game.roll(2)
      game.current_player.current_place.should == 2
    end
  end

  context "#correct_answer_and_not_done?" do
    it "getting out of the box -> doesn't win when few points is in purse and change current plaer" do
      game.add("sam")
      game.add("dave")
      game.is_getting_out_of_penalty_box = true
      not_won = game.correct_answer_and_not_done?
      game.current_player_index.should == 1
      game.current_player = 0
      game.current_player.point.should == 1
      not_won.should be_true
    end

    it "not getting out of the box -> doesn't win and change current plaer" do
      game.add("sam")
      game.add("dave")
      game.is_getting_out_of_penalty_box = false
      not_won = game.correct_answer_and_not_done?
      game.current_player_index.should == 1
      not_won.should be_true
    end
    
    it "not in the penalty box -> doesn't win and change current plaer" do
      game.add("sam")
      game.add("dave")
      game.current_player = 1
      not_won = game.correct_answer_and_not_done?
      game.current_player_index.should == 0
      not_won.should be_true
    end
  end

  context "#wrong_answer" do
    it "put the player in penalty box and move to next player" do
      game.add("sam")
      game.add("dave")
      game.current_player = 1
      game.wrong_answer_and_not_done?
      game.current_player_index.should == 0
      game.current_player = 1
      game.current_player.should be_in_penalty_box
    end
  end
end
