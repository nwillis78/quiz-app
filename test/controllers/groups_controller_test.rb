require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
    test "should get index" do
        sign_in users(:staff1)
        get :index
        assert_response :success
        assert_not_nil assigns(:groups)
    end

    test "should create group" do
        sign_in users(:staff1)
        assert_difference('Group.count') do
            post :create, group: {name: 'aaa', staff_id: 1}
        end
        
        assert_redirected_to add_members_groups_path(assigns(:group))
    end

    test "should show group" do
        sign_in users(:staff1)
        
        group = Group.new
        group.name = 'aaa'
        group.staff_id = 1
        group.save
        
        get :show, id: group.id
        assert_response :success
    end

    test "should destroy group" do
        sign_in users(:staff1)
        
        group = Group.new
        group.name = 'aaa'
        group.staff_id = 1
        group.save
        
        assert_difference('Group.count', -1) do
            delete :destroy, id: group.id
        end
        
        assert_redirected_to groups_path
    end

    test "should update group" do
        sign_in users(:staff1)
        
        group = Group.new
        group.name = 'aaa'
        group.staff_id = 1
        group.save
        
        patch :update, id: group.id, group: {name: 'title'}
        assert_redirected_to group_path(assigns(:group))
    end


    test "should get index not signed in" do
        get :index
        assert_response 302
        assert_nil assigns(:groups)
    end

    test "should create group not signed in " do
        assert_difference('Group.count', 0) do
            post :create, group: {name: 'aaa', staff_id: 1}
        end
    end

    test "should show group not signed in" do
        group = Group.new
        group.name = 'aaa'
        group.staff_id = 1
        group.save
        
        get :show, id: group.id
        assert_response 302
    end

    test "should destroy group not signed in" do
        
        group = Group.new
        group.name = 'aaa'
        group.staff_id = 1
        group.save
        
        
        assert_difference('Language.count', 0) do
            delete :destroy, id: group.id
        end
    end
end
