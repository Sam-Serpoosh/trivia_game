class Player
  attr_reader :name, :current_place

  def initialize(name)
    @name = name
    @current_place = 0
    @purse_stuff_count = 0
    @in_penalty_box = false
  end

  def change_the_place(moves)
    @current_place += moves
    @current_place -= 12 if @current_place > 11
  end

  def in_penalty_box?
    @in_penalty_box
  end

  def go_in_penalty_box
    @in_penalty_box = true
  end

  def to_s
    @name
  end
end
