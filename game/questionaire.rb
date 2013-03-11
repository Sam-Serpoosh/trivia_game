class Questionaire
  POP = "Pop"
  SCIENCE = "Science"
  SPORTS = "Sports"
  ROCK = "Rock"

  def initialize
    @pop_questions = []
    @science_questions = []
    @sports_questions = []
    @rock_questions = []

    50.times do |i|
      @pop_questions.push "Pop Question #{i}"
      @science_questions.push "Science Question #{i}"
      @sports_questions.push "Sports Question #{i}"
      @rock_questions.push "Rock Question #{i}"
    end
  end

  def ask_question(category)
    return @pop_questions.shift if category == POP
    return @science_questions.shift if category == SCIENCE
    return @sports_questions.shift if category == SPORTS
    return @rock_questions.shift if category == ROCK
  end

  def category(category_num)
    return POP if category_num == 0 || 
                  category_num == 4 || 
                  category_num == 8
    return SCIENCE if category_num == 1 || 
                      category_num == 5 ||
                      category_num == 9
    return SPORTS if category_num == 2 || 
                     category_num == 6 || 
                     category_num == 10
    ROCK
  end
end
