require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
    test "should get index" do
        sign_in users(:staff1)
        get :index
        assert_response :success
        assert_not_nil assigns(:categories)
    end

    test "should create category" do
        sign_in users(:staff1)
        assert_difference('Category.count') do
            post :create, category: {categoryBody: 'aaa'}
        end
        
        assert_redirected_to category_path(assigns(:category))
    end

    test "should show category" do
        sign_in users(:staff1)
        
        category = Category.new
        category.categoryBody = 'aaa'
        category.user_id = 1
        category.save
        
        get :show, id: category.id
        assert_response :success
    end

    test "should destroy category" do
        sign_in users(:staff1)
        
        category = Category.new
        category.categoryBody = 'aaa'
        category.user_id = 1
        category.save
        
        assert_difference('Category.count', -1) do
            delete :destroy, id: category.id
        end
        
        assert_redirected_to categories_path
    end

    test "should update category" do
        sign_in users(:staff1)
        
        category = Category.new
        category.categoryBody = 'aaa'
        category.user_id = 1
        category.id = 12
        category.save
        
        patch :update, id: 12, category: {categoryBody: 'title'}
        assert_redirected_to category_path(assigns(:category))
    end


    test "should get index not signed in" do
        get :index
        assert_response 302
        assert_nil assigns(:categories)
    end

    test "should create category not signed in " do
        assert_difference('Category.count',0) do
            post :create, category: {categoryBody: 'aaa'}
        end
    end

    test "should show category not signed in" do
        
        category = Category.new
        category.categoryBody = 'aaa'
        category.user_id = 1
        category.id = 12
        category.save
        
        get :show, id: category.id
        assert_response 302
    end

    test "should destroy category not signed in" do
        
        category = Category.new
        category.categoryBody = 'aaa'
        category.user_id = 1
        category.id = 12
        category.save
        
        assert_difference('Category.count', 0) do
            delete :destroy, id: 12
        end
    end
end
