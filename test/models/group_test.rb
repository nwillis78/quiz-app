require 'test_helper'

class GroupTest < ActiveSupport::TestCase

    test "should not save group without name" do
        group = Group.new
        assert_not group.save
    end

    test "should be invalid if name is less than 3 characters" do
        group = Group.new
        group.name = 'a' * 2
        assert !group.valid?
    end

    test "should be valid if answerString is 3 or more characters" do
        group = Group.new
        group.name = 'a' * 3
        assert group.valid?
    end

end
