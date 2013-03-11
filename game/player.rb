class Player
  WINNING_POINTS = 6
  BORDER = 11
  BACK_OFF_STEPS = 12
  attr_reader :name, :current_place

  def initialize(name)
    @name = name
    @current_place = 0
    @point = 0
    @in_penalty_box = false
  end

  def change_place(moves)
    @current_place += moves
    @current_place -= BACK_OFF_STEPS if out?
  end

  def in_penalty_box?
    @in_penalty_box
  end

  def go_in_penalty_box
    @in_penalty_box = true
  end

  def point
    @point
  end

  def increment_point
    @point += 1
  end

  def won?
    @point == WINNING_POINTS
  end

  def to_s
    @name
  end

  private
    def out?
      @current_place > BORDER
    end
end
