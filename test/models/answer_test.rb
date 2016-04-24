require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  
    test "should not save answer without answerString" do
        answer = Answer.new
        assert_not answer.save
    end

    test "should be invalid if answerString is less than 3 characters" do
        answer = Answer.new
        answer.answerString = 'a' * 2
        assert !answer.valid?
    end

    test "should be valid if answerString is 3 or more characters" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        assert answer.valid?
    end

end
