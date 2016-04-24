require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
    test "should not save category without categoryBody" do
      category = Category.new
      assert_not category.save
    end

    test "should be invalid if categoryBody is less than 3 characters" do
        category = Category.new
        category.categoryBody = 'a' * 2
        assert !category.valid?
    end

    test "should be valid if categoryBody is 3 or more characters" do
        category = Category.new
        category.categoryBody = 'a' * 3
        assert category.valid?
    end

    test "should be invalid if categoryBody is not unique" do
        category = Category.new
        category.categoryBody = 'a' * 3
        category.save
        identical = category.dup
        assert !identical.valid?
    end

    test "should be false if in question check_if_in_question" do
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
        
        category = Category.new
        category.categoryBody = 'a' * 3
        category.id = 1
        category.save
        
        assert_not category.check_if_in_question('a')
    end

    test "should be true if not in question check_if_in_question" do
        category = Category.new
        category.categoryBody = 'a' * 3
        category.save
        assert category.check_if_in_question('a')
    end

end
