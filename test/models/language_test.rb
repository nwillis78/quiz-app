require 'test_helper'

class LanguageTest < ActiveSupport::TestCase

    test "should not save language without languageName" do
        language = Language.new
        language.direction_id = 1
        assert_not language.save
    end

    test "should not save language without direction_id" do
        language = Language.new
        language.languageName = 'a' * 3
        assert_not language.save
    end

    test "should be invalid if languageName is less than 3 characters" do
        language = Language.new
        language.languageName = 'a' * 2
        language.direction_id = 1
        assert !language.valid?
    end

    test "should be valid if languageName is 3 or more characters" do
        language = Language.new
        language.languageName = 'a' * 3
        language.direction_id = 1
        assert language.valid?
    end

    test "should be invalid if languageName is not unique" do
        language = Language.new
        language.languageName = 'a' * 3
        language.direction_id = 1
        language.save
        identical = language.dup
        assert !identical.valid?
    end

    test "should be false if in question check_if_in_question_or_quiz" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = true
        answer.id = 1
        answer.question_id = 1
        answer.save
        
        question = Question.new
        question.category_id = 1
        question.language_id = 1
        question.body = 'a' * 3
        question.id = 1
        question.answers = [answer]
        question.save
        
        language = Language.new
        language.languageName = 'a' * 3
        language.direction_id = 1
        language.id = 1
        language.save
        
        assert_not language.check_if_in_question_or_quiz('a')
    end

    test "should be false if in quiz check_if_in_question_or_quiz" do
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.language_id = 1
        quiz.save
        
        language = Language.new
        language.languageName = 'a' * 3
        language.direction_id = 1
        language.id = 1
        language.save
        
        assert_not language.check_if_in_question_or_quiz('a')
    end

    test "should be false if in question and quiz check_if_in_question_or_quiz" do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = true
        answer.id = 1
        answer.question_id = 1
        answer.save
        
        question = Question.new
        question.category_id = 1
        question.language_id = 1
        question.body = 'a' * 3
        question.id = 1
        question.answers = [answer]
        question.save
        
        quiz = Quiz.new
        quiz.attemptsAllowed = 5
        quiz.title = 'a' * 3
        quiz.language_id = 1
        quiz.save
        
        language = Language.new
        language.languageName = 'a' * 3
        language.direction_id = 1
        language.id = 1
        language.save
        
        assert_not language.check_if_in_question_or_quiz('a')
    end


    test "should be true if not in question or quiz check_if_in_question_or_quiz" do
        language = Language.new
        language.languageName = 'a' * 3
        language.direction_id = 1
        language.save
        assert_nil language.check_if_in_question_or_quiz('a')
    end

end
