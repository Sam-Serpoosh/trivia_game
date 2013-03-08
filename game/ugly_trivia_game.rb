require_relative "player"
require_relative "game_board"
require_relative "questionaire"

module UglyTrivia
  class Game
    attr_accessor :current_player, :is_getting_out_of_penalty_box, :places

    def  initialize
      @players = []
      @current_player = 0
      @is_getting_out_of_penalty_box = false
      @questionaire = Questionaire.new
    end

    def current_player_index
      @current_player
    end

    def current_player
      @players[@current_player]
    end

    def add_player(player_name)
      player = Player.new(player_name)
      player.go_in_penalty_box if @players.count == 0
      @players.push player
      GameBoard.player_added(player)
      GameBoard.show_num_of_players(@players.count)
    end

    def roll(roll)
      GameBoard.show_current_player(current_player)
      GameBoard.show_roll(roll)

      if current_player.in_penalty_box?
        if rolled_odd?(roll)
          getting_out_of_box
          move_and_ask_question(roll)
        else
          not_getting_out_of_box
        end
      else
        move_and_ask_question(roll)
      end
    end

    def correct_answer_and_not_done?
      if current_player.in_penalty_box?
        if @is_getting_out_of_penalty_box
          return check_win_and_go_to_next_player
        end
        next_player
        return true
      end
      check_win_and_go_to_next_player
    end

    def wrong_answer_and_not_done?
      GameBoard.wrong_answer
      GameBoard.sent_to_penalty_box(current_player)
      current_player.go_in_penalty_box
      next_player
      true
    end

    def current_category
      @questionaire.category(current_player.current_place)
    end

    private

    def rolled_odd?(roll)
      roll % 2 != 0
    end

    def getting_out_of_box
      @is_getting_out_of_penalty_box = true
      GameBoard.out_of_box(current_player)
    end

    def move_and_ask_question(roll)
      current_player.change_place(roll)
      GameBoard.show_location_of(current_player)
      GameBoard.show_category(current_category)
      @questionaire.ask_question(current_category)
    end

    def not_getting_out_of_box
      @is_getting_out_of_penalty_box = false
      GameBoard.not_out_of_box(current_player)
    end

    def check_win_and_go_to_next_player
      current_player.increment_point
      GameBoard.correct_answer
      GameBoard.show_points(current_player)
      no_win_for_current_player = current_player_did_not_win?
      next_player
      no_win_for_current_player
    end

    def current_player_did_not_win?
      current_player.won? == false
    end

    def next_player
      @current_player += 1
      @current_player = 0 if @current_player == @players.count
    end
  end
end
