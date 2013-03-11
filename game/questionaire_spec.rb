require_relative "questionaire" 

describe Questionaire do
  it "asks first question on the list based on category" do
    question = subject.ask_question("Rock")
    question.should == "Rock Question 0"
  end

  it "picks the category based on the category number" do
    subject.category(4).should == Questionaire::POP
    subject.category(5).should == Questionaire::SCIENCE
    subject.category(6).should == Questionaire::SPORTS
    subject.category(20).should == Questionaire::ROCK
  end
end
