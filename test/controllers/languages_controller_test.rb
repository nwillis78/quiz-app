require 'test_helper'

class LanguagesControllerTest < ActionController::TestCase
    test "should get index" do
        sign_in users(:staff1)
        get :index
        assert_response :success
        assert_not_nil assigns(:languages)
    end

    test "should create language" do
        sign_in users(:staff1)
        assert_difference('Language.count') do
            post :create, language: {languageName: 'aaa', direction_id: 1}
        end
        
        assert_redirected_to language_path(assigns(:language))
    end

    test "should show language" do
        sign_in users(:staff1)
        
        language = Language.new
        language.languageName = 'aaa'
        language.direction_id = 1
        language.user_id = 1
        language.save
        
        get :show, id: language.id
        assert_response :success
    end

    test "should destroy language" do
        sign_in users(:staff1)
        
        language = Language.new
        language.languageName = 'aaa'
        language.direction_id = 1
        language.user_id = 1
        language.save
        
        assert_difference('Language.count', -1) do
            delete :destroy, id: language.id
        end
        
        assert_redirected_to languages_path
    end

    test "should update language" do
        sign_in users(:staff1)
        
        language = Language.new
        language.languageName = 'aaa'
        language.direction_id = 1
        language.user_id = 1
        language.save
        
        patch :update, id: language.id, language: {languageName: 'title'}
        assert_redirected_to language_path(assigns(:language))
    end


    test "should get index not signed in" do
        get :index
        assert_response 302
        assert_nil assigns(:langauges)
    end

    test "should create language not signed in " do
        assert_difference('Language.count', 0) do
            post :create, language: {languageName: 'aaa', direction_id: 1}
        end
    end

    test "should show language not signed in" do
        
        language = Language.new
        language.languageName = 'aaa'
        language.direction_id = 1
        language.user_id = 1
        language.save
        
        
        get :show, id: language.id
        assert_response 302
    end

    test "should destroy category not signed in" do
        
        language = Language.new
        language.languageName = 'aaa'
        language.direction_id = 1
        language.user_id = 1
        language.save
        
        
        assert_difference('Language.count', 0) do
            delete :destroy, id: language.id
        end
    end
end
