require 'test_helper'

class QuizzesControllerTest < ActionController::TestCase
    include Devise::TestHelpers


    test "should get index" do
        sign_in users(:staff1)
        get :index
        assert_response :success
        assert_not_nil assigns(:quizzes)
    end

    test "should create quiz" do
        sign_in users(:staff1)
        assert_difference('Quiz.count') do
            post :create, quiz: {title: 'Some title', description: 'aaa', instructions: 'aaa', attemptsAllowed: 5,
                time_allowed: 10, language_id: 1, shuffleQuestions: false, shuffleAnswers: false}
        end
        
        assert_redirected_to quiz_path(assigns(:quiz))
    end

    test "should show quiz" do
        sign_in users(:staff1)
        
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 120
        quiz.language_id = 1
        quiz.id = 12
        quiz.user_id = 1
        quiz.save
        
        get :show, id: quiz.id
        assert_response :success
    end

    test "should destroy quiz" do
        sign_in users(:staff1)
        
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 120
        quiz.language_id = 1
        quiz.id = 12
        quiz.user_id = 1
        quiz.save
        
        assert_difference('Quiz.count', -1) do
            delete :destroy, id: 12
        end
        
        assert_redirected_to quizzes_path
    end

    test "should update quiz" do
        sign_in users(:staff1)
        
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 120
        quiz.language_id = 1
        quiz.id = 12
        quiz.user_id = 1
        quiz.save
        
        patch :update, id: 12, quiz: {title: 'title'}
        assert_redirected_to quiz_path(assigns(:quiz))
    end


    test "should get index not signed in" do
        get :index
        assert_response 302
        assert_nil assigns(:quizzes)
    end

    test "should create quiz not signed in " do
        assert_difference('Quiz.count',0) do
            post :create, quiz: {title: 'Some title', description: 'aaa', instructions: 'aaa', attemptsAllowed: 5,
                time_allowed: 10, language_id: 1, shuffleQuestions: false, shuffleAnswers: false}
        end
    end

    test "should show quiz not signed in" do
        
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 120
        quiz.language_id = 1
        quiz.id = 12
        quiz.user_id = 1
        quiz.save
        
        get :show, id: quiz.id
        assert_response 302
    end

    test "should destroy quiz not signed in" do
        
        quiz = Quiz.new
        quiz.attemptsAllowed = 10
        quiz.title = 'a' * 3
        quiz.description = 'a' * 3
        quiz.instructions = 'a' * 3
        quiz.time_allowed = 120
        quiz.language_id = 1
        quiz.id = 12
        quiz.user_id = 1
        quiz.save
        
        assert_difference('Quiz.count', 0) do
            delete :destroy, id: 12
        end
    end


end
