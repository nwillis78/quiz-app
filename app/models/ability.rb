class Ability
  include CanCan::Ability

  def initialize(user)
    if user.staff?
    	#staff should only be able to RUD their own stuff, they should be able to C
  		can :read, Category do |category|
    		category.try(:user) == user
  		end
  		can :create, Category
  		can :update, Category do |category|
    		category.try(:user) == user
  		end
  		can :destroy, Category do |category|
    		category.try(:user) == user
  		end

  		can :read, Question do |question|
    		question.try(:user) == user
  		end
  		can :create, Question
  		can :update, Question do |question|
    		question.try(:user) == user
  		end
  		can :destroy, Question do |question|
    		question.try(:user) == user
  		end
      can :update_questions, Question do |question|
        question.try(:user) == user
      end
      can :update_questions_direction, Question do |question|
        question.try(:user) == user
      end
      can :update_quizzes_direction, Quiz do |quiz|
        quiz.try(:user) == user
      end

  		can :read, Language do |language|
    		language.try(:user) == user
  		end
  		can :create, Language
  		can :update, Language do |language|
    		language.try(:user) == user
  		end
  		can :destroy, Language do |language|
    		language.try(:user) == user
  		end

      can :read, Quiz do |quiz|
        quiz.try(:user) == user
      end
      can :create, Quiz
      can :update, Quiz do |quiz|
        quiz.try(:user) == user
      end
      can :destroy, Quiz do |quiz|
        quiz.try(:user) == user
      end

      can :read, Group do |group|
        group.try(:user) == user
      end
      can :create, Group
      can :update, Group do |group|
        group.try(:user) == user
      end
      can :destroy, Group do |group|
        group.try(:user) == user
      end

      
  		
      can :manage, Answer

    else
      #define what students can do
    end
  end
end