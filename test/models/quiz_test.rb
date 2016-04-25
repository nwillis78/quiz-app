require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  
    test "should not save quiz without language_id" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        assert_not quiz.save
    end

    test "should not save quiz without title" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should not save quiz if title less than 3" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 2
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should save quiz if title 3 or higher" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert quiz.save
    end

    test "should not save quiz without description" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should not save quiz if description less than 3" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.description = 'a' * 2
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should save quiz if description 3 or higher" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert quiz.save
    end

    test "should not save quiz without instructions" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.description = 'a' * 3
        quiz.title = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should not save quiz if instructions less than 3" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 2
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should save quiz if instructions 3 or higher" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert quiz.save
    end

    test "should not save quiz if attemptsAllowed is a char" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 'a'
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should not save quiz if attemptsAllowed is a floating point" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 3.4
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should not save quiz if attemptsAllows is less than 1" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 0
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should save quiz if attemptsAllows is 1" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 1
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert quiz.save
    end

    test "should not save quiz if attemptsAllows is more than 10" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 11
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should save quiz if attemptsAllows is 10" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        assert quiz.save
    end

    test "should not save quiz if time_allowed is a char" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 3
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 'a'
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should not save quiz if time_allowed is a floating point" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 3
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5.2
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should not save quiz if time_allowed is less than 1" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 1
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 0
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should save quiz if time_allowed is 1" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 1
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 1
        quiz.language_id = 1
        assert quiz.save
    end

    test "should not save quiz if time_allowed is more than 120" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 121
        quiz.language_id = 1
        assert_not quiz.save
    end

    test "should save quiz if time_allowed is 120" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 120
        quiz.language_id = 1
        assert quiz.save
    end

    test "should return number of questions in quiz getNoQuestions" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = true
        answer.id = 1
        answer.question_id = 1
        answer.save
        
        question = Question.new
        question.language_id = 1
        question.category_id = 1
        question.body = 'a' * 3
        question.id = 1
        question.answers = [answer]
        
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 120
        quiz.language_id = 1
        quiz.questions = [question]
        quiz.save
        
        assert_equal 1, quiz.getNoQuestions
    end


end
