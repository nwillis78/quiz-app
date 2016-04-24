require 'test_helper'

class DirectionTest < ActiveSupport::TestCase
  
    test "should not save direction without directionName" do
      #create a new direction and give it a code to test lack of name
      direction = Direction.new
      direction.directionCode = 'a'
      assert_not direction.save
    end

    test "should be invalid if directionName is not unique" do
        #save direction with name and code to the db
        direction = Direction.new
        direction.directionName = 'a' * 3
        direction.directionCode = 'a'
        direction.save
        
        #create a new direction that has the same directionName and attempt to save
        direction2 = Direction.new
        direction2.directionName = direction.directionName
        direction2.directionCode = 'b'
        assert !direction2.valid?
    end

    test "should not save direction without directionCode" do
        #create a new direction and give it a name to test lack of code
        direction = Direction.new
        direction.directionName = 'a'
        assert_not direction.save
    end

    test "should be invalid if directionCode is not unique" do
        #save direction with name and code to the db
        direction = Direction.new
        direction.directionName = 'a' * 3
        direction.directionCode = 'a'
        direction.save
        
        #create a new direction that has the same directionCode and attempt to save
        direction2 = Direction.new
        direction2.directionName = 'b'
        direction2.directionCode = direction.directionCode
        assert !direction2.valid?
    end

end
