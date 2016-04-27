require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
    include Devise::TestHelpers
    test "should get index" do
        sign_in users(:staff1)
        get :index, :category_id=>1
        assert_response :success
    end

#create question

    test "should show question" do
        sign_in users(:staff1)
        
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
        question.id = 13
        question.answers = [answer]
        question.user_id = 1
        question.save
        
        get :show, :category_id=>1, id: question.id
        assert_response :success
    end

    test "should destroy question" do
        sign_in users(:staff1)
        
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
        question.id = 13
        question.answers = [answer]
        question.user_id = 1
        question.save
        
        assert_difference('Question.count', -1) do
            delete :destroy, :category_id=>1, id: 13
        end
    end

#update question

    test "should get index not signed in" do
        get :index, :category_id=>1
        assert_response 302
        assert_nil assigns(:questions)
    end

    test "should create question not signed in " do
        answer = Answer.new
        answer.answerString = 'a' * 3
        answer.isCorrect = true
        answer.id = 1
        answer.question_id = 13
        answer.save
        
        assert_difference('Question.count',0) do
            post :create, category_id:1,question: {language_id: 1, category_id: 1, body: 'aaa', answers: [answer], user_id: 1, id: 13}
        end
    end

    test "should show question not signed in" do
        
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
        question.id = 13
        question.answers = [answer]
        question.user_id = 1
        
        get :show, :category_id=>1, id: question.id
        assert_response 302
    end

    test "should destroy question not signed in" do
        
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
        question.id = 13
        question.answers = [answer]
        question.user_id = 1
        question.save
        
        assert_difference('Question.count', 0) do
            delete :destroy, :category_id=>1,id: 13
        end
    end
end
