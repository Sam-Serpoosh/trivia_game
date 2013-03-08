class Questionaire
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
    puts @pop_questions.shift if category == 'Pop'
    puts @science_questions.shift if category == 'Science'
    puts @sports_questions.shift if category == 'Sports'
    puts @rock_questions.shift if category == 'Rock'
  end

  def category(category_num)
    return 'Pop' if category_num == 0
    return 'Pop' if category_num == 4
    return 'Pop' if category_num == 8
    return 'Science' if category_num == 1
    return 'Science' if category_num == 5
    return 'Science' if category_num == 9
    return 'Sports' if category_num == 2
    return 'Sports' if category_num == 6
    return 'Sports' if category_num == 10
    "Rock"
  end
end
