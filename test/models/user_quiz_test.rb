require 'test_helper'

class UserQuizTest < ActiveSupport::TestCase
    test "should not save user_quiz without quiz_id" do
        user_quiz = UserQuiz.new
        user_quiz.group_id = 1
        user_quiz.staff_id = 1
        user_quiz.student_id = 2
        user_quiz.start_date = Date.parse('31-12-2020')
        user_quiz.end_date = Date.parse('01-01-2021')
        assert_not user_quiz.save
    end

    test "should not save user_quiz without group_id" do
        user_quiz = UserQuiz.new
        user_quiz.quiz_id = 1
        user_quiz.staff_id = 1
        user_quiz.student_id = 2
        user_quiz.start_date = Date.parse('31-12-2020')
        user_quiz.end_date = Date.parse('01-01-2021')
        assert_not user_quiz.save
    end

    test "should not save user_quiz without staff_id" do
        user_quiz = UserQuiz.new
        user_quiz.group_id = 1
        user_quiz.quiz_id = 1
        user_quiz.student_id = 2
        user_quiz.start_date = Date.parse('31-12-2020')
        user_quiz.end_date = Date.parse('01-01-2021')
        assert_not user_quiz.save
    end

    test "should not save user_quiz without student_id" do
        user_quiz = UserQuiz.new
        user_quiz.group_id = 1
        user_quiz.staff_id = 1
        user_quiz.quiz_id = 2
        user_quiz.start_date = Date.parse('31-12-2020')
        user_quiz.end_date = Date.parse('01-01-2021')
        assert_not user_quiz.save
    end

    test "should save if all fields are present" do
        user_quiz = UserQuiz.new
        user_quiz.quiz_id = 1
        user_quiz.group_id = 1
        user_quiz.staff_id = 1
        user_quiz.student_id = 2
        user_quiz.start_date = Date.parse('31-12-2020')
        user_quiz.end_date = Date.parse('01-01-2021')
        assert user_quiz.save
    end

    test "should return false if start date is in past tart_not_in_past" do
        user_quiz = UserQuiz.new
        user_quiz.quiz_id = 1
        user_quiz.group_id = 1
        user_quiz.staff_id = 1
        user_quiz.student_id = 2
        user_quiz.start_date = Date.parse('31-12-2002')
        user_quiz.end_date = Date.parse('01-01-2021')
        assert_not user_quiz.save
    end

    test "should return false if end date is in past end_not_in_past_after_start" do
        user_quiz = UserQuiz.new
        user_quiz.quiz_id = 1
        user_quiz.group_id = 1
        user_quiz.staff_id = 1
        user_quiz.student_id = 2
        user_quiz.start_date = Date.parse('31-12-2002')
        user_quiz.end_date = Date.parse('01-01-2003')
        assert_not user_quiz.save
    end

    test "should return false if end date is before start date in past end_not_in_past_after_start" do
        user_quiz = UserQuiz.new
        user_quiz.quiz_id = 1
        user_quiz.group_id = 1
        user_quiz.staff_id = 1
        user_quiz.student_id = 2
        user_quiz.start_date = Date.parse('31-12-2020')
        user_quiz.end_date = Date.parse('30-12-2020')
        assert_not user_quiz.save
    end

end
