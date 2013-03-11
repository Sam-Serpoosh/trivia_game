require_relative "player"

describe Player do
  let(:player) { Player.new("bob") }

  context "#construction" do
    it "is at the 0 place at the beginning" do
      player.current_place.should == 0
    end

    it "has no point at the beginning" do
      player.point.should == 0
    end

    it "is not in the penalty box" do
      player.should_not be_in_penalty_box
    end
  end

  it "can move and change the place" do
    player.change_place(10)
    player.current_place.should == 10
  end

  it "goes back 12 places if it passes the end" do
    player.change_place(Player::BORDER + 1)
    player.current_place.should == 0
  end

  it "goes to penalty box" do
    player.go_in_penalty_box
    player.should be_in_penalty_box
  end

  it "increments the point" do
    player.increment_point
    player.point.should == 1
  end

  it "knows when won" do
    Player::WINNING_POINTS.times { player.increment_point }
    player.should be_won
  end

  it "knows when not won" do
    (Player::WINNING_POINTS - 1).times { player.increment_point }
    player.should_not be_won
  end

  it "to_s based on the name" do
    player.to_s.should == "bob"
  end
end
