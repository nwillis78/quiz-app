class UserQuizzesController < ApplicationController
    helper_method :grade
    helper_method :calculate_status
    
	def new
        @quizzes = Quiz.where("user_id = ?", current_user.id)
        @quizzes.each do |quiz|
            if !(UserQuiz.where("quiz_id=?", quiz.id).blank?)
                #this quiz exists in userquizzes so remove it from collection
                @quizzes = @quizzes.reject { |q| q.id === quiz.id}
            end
        end

		@user_quiz = UserQuiz.new
		if @user_quiz.quiz_id
            @quiz = Quiz.find(@user_quiz.quiz_id)
        else
            @quiz = Quiz.where("user_id = ?", current_user.id).first
        end
        if @user_quiz.group_id
            @group = Group.find(@user_quiz.group_id)
        else
            @group = Group.where("staff_id = ?", current_user.id).first
        end
        #If a quiz doesn't exist then this must be created before going to this page
        if @quiz == nil
            redirect_to root_path, :flash => { :warning => "You must create a quiz before you can set it" }
        end
	end

	def create
        #first get all the ids that the quiz needs to be assigned to
        @group = Group.find(params[:user_quiz][:group_id])
        @members = @group.members
        #for each member of the group create a user quiz object
        @members.each do |member|
            @user_quiz = UserQuiz.new(user_quiz_params)
            @user_quiz.staff_id = current_user.id
            @user_quiz.student_id = member.student_id
            @user_quiz.attemptsTaken = 0
            @user_quiz.results_available = false
            if @user_quiz.quiz_id
                @quiz = Quiz.find(@user_quiz.quiz_id)
            else
                @quiz = Quiz.where("user_id = ?", current_user.id).first
            end

            if !@user_quiz.save
                render 'new'
            end
        end

        redirect_to root_path
    end

    def show
    	@user_quiz = UserQuiz.find(params[:id])
        @userQuizzes = UserQuiz.where("staff_id = ?", @user_quiz.staff_id).where("quiz_id = ?", @user_quiz.quiz_id)
        .where("group_id = ?", @user_quiz.group_id)
        @quiz = Quiz.find(@user_quiz.quiz_id)
        @group = Group.find(@user_quiz.group_id)

        #% of students who took the quiz
        @x = (@userQuizzes.count - @userQuizzes.where("attemptsTaken = ?",0).count) * 100
        @y = @userQuizzes.count
        @percent_complete = @x/@y

        #average score
        @total = 0
        @userQuizzes.each do |userQuizI|
            @total += grade(userQuizI.id)
        end
        @average_score = @total/@userQuizzes.count

    end

    def edit
        @user_quiz = UserQuiz.find(params[:id])
        @quizzes = Quiz.where("user_id = ?", current_user.id).where("id = ?",@user_quiz.quiz_id)
        if @user_quiz.quiz_id
            @quiz = Quiz.find(@user_quiz.quiz_id)
        else
            @quiz = Quiz.where("user_id = ?", current_user.id).first
        end
    end

    def update
        @user_quiz = UserQuiz.find(params[:id])
        
        if @user_quiz.update(user_quiz_params)
            redirect_to @user_quiz
        else
            render 'edit'
        end
    end

    def grade(userQuizId) #also in quiz pages controller
        @userQuiz = UserQuiz.find(userQuizId)
        @quiz = Quiz.find(@userQuiz.quiz_id)
        @noQuestions = @quiz.links.length
        @results = Result.where("user_quiz_id = ?", @userQuiz.id)

        @i = 0

        @results.each do |result|
            if result.chosen_answer != nil
                @answer = Answer.find(result.chosen_answer)
                if @answer.isCorrect
                    @i += 1
                end
            end
        end

        return @i * 100 / @noQuestions
    end

    def student_detail
        @userQuiz = UserQuiz.find(params[:id])
        @quiz = Quiz.find(@userQuiz.quiz_id)
        @direction = Direction.find(@quiz.language.direction_id).directionCode 
        @results = Result.where("user_quiz_id = ?", @userQuiz.id)
    end

    def calculate_status(start_date, end_date) #this method is also in the welcome controller
        if Date.today.between?(start_date, end_date)
          return "Live"
        else
          if Date.today < start_date
            return "Scheduled for Release"
          elsif end_date < Date.today
            return "Closed"
          end
        end
    end

    def release_results
        @quiz = Quiz.find(params[:quiz_id])
        @userQuizzes = UserQuiz.where("quiz_id = ?", @quiz.id).where("staff_id = ?", current_user.id)

        @userQuizzes.each do |userQuiz|
            userQuiz.results_available = true
            userQuiz.save
        end
        redirect_to :back
    end

    private
        def user_quiz_params
            params.require(:user_quiz).permit(:quiz_id, :group_id, :start_date, :end_date, :attemptsTaken, :results_available)
        end
end
