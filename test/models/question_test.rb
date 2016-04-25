require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

    test "should not save question without language_id" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = true
        answer.id = 1
        answer.question_id = 1
        answer.save
        
        question = Question.new
        question.category_id = 1
        question.body = 'a' * 3
        question.id = 1
        question.answers = [answer]
        
        assert_not question.save
    end

    test "should not save question without category_id" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = true
        answer.id = 1
        answer.question_id = 1
        answer.save
        
        question = Question.new
        question.language_id = 1
        question.body = 'a' * 3
        question.id = 1
        question.answers = [answer]
        
        assert_not question.save
    end

    test "should not save question without body" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = true
        answer.id = 1
        answer.question_id = 1
        answer.save
        
        question = Question.new
        question.language_id = 1
        question.category_id = 1
        question.id = 1
        question.answers = [answer]
        
        assert_not question.save
    end

    test "should be invalid if body is less than 3 characters" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = true
        answer.id = 1
        answer.question_id = 1
        answer.save
        
        question = Question.new
        question.language_id = 1
        question.category_id = 1
        question.body = 'a' * 2
        question.id = 1
        question.answers = [answer]
        assert !question.valid?
    end

    test "should be valid if body is at least 3 characters" do
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
        assert question.valid?
    end

    test "should return false if question has no answers check_has_answer" do
        question = Question.new
        question.language_id = 1
        question.category_id = 1
        question.body = 'a' * 3
        question.id = 1
        question.save
        assert_nil question.check_has_answer
    end

    test "should be invalid if question has no correct answers has_one_correct_answer" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = false
        answer.id = 1
        answer.question_id = 1
        answer.save
        
        question = Question.new
        question.language_id = 1
        question.category_id = 1
        question.body = 'a' * 3
        question.id = 1
        question.answers = [answer]
        assert_not question.has_one_correct_answer
    end

    test "should be valid if question has one correct answer" do
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
        assert question.has_one_correct_answer
    end

    test "should return false if question is in a quiz check_if_in_quiz" do
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
        question.save
        
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 5
        quiz.language_id = 1
        quiz.questions = [question]
        quiz.save
        
        assert_not question.check_if_in_quiz('a')
    end

    test "should not return false if question is not in a quiz check_if_in_quiz" do
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
        assert question.check_if_in_quiz('a')
    end
end
