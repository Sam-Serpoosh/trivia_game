require_relative 'ugly_trivia_game'

describe UglyTrivia::Game do
  it "rolls withe an odd number getting out of the box" do
    game = UglyTrivia::Game.new
    game.add("sam")
    game.roll(3)
    game.current_player.current_place.should == 3
    game.is_getting_out_of_penalty_box.should be_true
  end

  it "rolls with an even number same place and not getting out of the box" do
    game = UglyTrivia::Game.new
    game.add("sam")
    game.roll(2)
    game.current_player.current_place.should == 0
    game.is_getting_out_of_penalty_box.should be_false
  end

  it "rolls and player is not in the penalty box change the place" do
    game = UglyTrivia::Game.new
    game.add("sam")
    game.add("dave")
    game.current_player = 1
    game.roll(2)
    game.current_player.current_place.should == 2
  end
end
