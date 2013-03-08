require_relative "player"
require_relative "game_board"

module UglyTrivia
  class Game
    attr_accessor :current_player, :is_getting_out_of_penalty_box

    def  initialize
      @players = []
      @places = Array.new(6, 0)
      @purses = Array.new(6, 0)
      @in_penalty_box = Array.new(6, 0)

      @pop_questions = []
      @science_questions = []
      @sports_questions = []
      @rock_questions = []

      @current_player = 0
      @is_getting_out_of_penalty_box = false

      50.times do |i|
        @pop_questions.push "Pop Question #{i}"
        @science_questions.push "Science Question #{i}"
        @sports_questions.push "Sports Question #{i}"
        @rock_questions.push "Rock Question #{i}"
      end
    end
    
    def current_player_index
      @current_player
    end

    def current_player
      @players[@current_player]
    end

    def is_playable?
      number_of_players >= 2
    end

    def add(player_name)
      player = Player.new(player_name)
      player.go_in_penalty_box if @players.count == 0
      @players.push player
      puts "#{player.name} was added"
      puts "There is #{@players.length} number of players"
    end

    def number_of_players
      @players.length
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

    def wrong_answer
      puts 'Question was incorrectly answered'
      puts "#{@players[@current_player]} was sent to the penalty box"
      @in_penalty_box[@current_player] = true

      @current_player += 1
      @current_player = 0 if @current_player == @players.length
      return true
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
      current_player.change_the_place(roll)
      GameBoard.show_location_of(current_player)
      GameBoard.show_category(current_category)
      ask_question
    end

    def ask_question
      puts @pop_questions.shift if current_category == 'Pop'
      puts @science_questions.shift if current_category == 'Science'
      puts @sports_questions.shift if current_category == 'Sports'
      puts @rock_questions.shift if current_category == 'Rock'
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

    def current_category
      return 'Pop' if @places[@current_player] == 0
      return 'Pop' if @places[@current_player] == 4
      return 'Pop' if @places[@current_player] == 8
      return 'Science' if @places[@current_player] == 1
      return 'Science' if @places[@current_player] == 5
      return 'Science' if @places[@current_player] == 9
      return 'Sports' if @places[@current_player] == 2
      return 'Sports' if @places[@current_player] == 6
      return 'Sports' if @places[@current_player] == 10
      return 'Rock'
    end
  end
end
