require_relative "trivia_game"

describe Trivia::Game do
  let(:questionaire) { stub.as_null_object }
  let(:game) { Trivia::Game.new(questionaire) }

  it "puts the first player in the penalty box" do
    subject.add_player("bob")
    subject.player_at(0).should be_in_penalty_box
  end

  it "does not put other players in the penalty box" do
    subject.add_player("bob")
    subject.add_player("alice")
    subject.player_at(1).should_not be_in_penalty_box
  end

  it "current player is the first player at the beginning" do
    bob = "bob"
    subject.add_player(bob)
    subject.current_player.name.should == bob
  end

  it"knows when rolled number is odd" do
    subject.rolled_odd?(3).should be_true
  end

  context "#play" do
    it "moves the current player and ask question based on rolled num" do
      game.add_player("bob")
      game.move_and_ask_question(2)

      questionaire.shoudl_receive(:ask_question)
      game.player_at(0).current_place.should == 2
    end

    it "gets the question category based on rolled num and player place" do
      game.add_player("bob")

      questionaire.should_receive(:category).with(2) { "Rock" }
      game.move_and_ask_question(2)
    end
  end

  context "#next_player" do
    before do
      @bob, @alice = "bob", "alice"
      subject.add_player(@bob)
      subject.add_player(@alice)
    end

    it "goes to next player" do
      subject.next_player
      subject.current_player.name.should == @alice
    end

    it "goes back to first player when there is no more player" do
      subject.next_player.next_player
      subject.current_player.name.should == @bob
    end
  end

  context "#answer_is_correct" do
    before do
      @bob, @alice = "bob", "alice"
      subject.add_player("bob")
      subject.add_player("alice")
    end
    
    it "increments the current player point and change the player" do
      subject.current_player.name.should == @bob
      subject.check_not_done_and_go_to_next_player

      subject.player_at(0).point.should == 1
      subject.current_player.name.should == @alice
    end

    it "checks if the player did not win after point increment" do
      not_done = subject.check_not_done_and_go_to_next_player
      not_done.should be_true
    end
  end

  context "#answer_is_wrong" do
    before do
      @bob, @alice = "bob", "alice"
      subject.add_player("bob")
      subject.add_player("alice")
    end

    it "puts current player in penalty box and move to next player" do
      subject.wrong_answer_and_not_done?

      subject.player_at(0).should be_in_penalty_box
      subject.current_player.name.should == @alice
    end

    it "checks game not done" do
      not_done = subject.wrong_answer_and_not_done?
      not_done.should be_true
    end
  end
end
