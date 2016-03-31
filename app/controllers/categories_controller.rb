class CategoriesController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource
    
	def index
        @categories = Category.where("user_id = ?", current_user.id)
    end
    
    def show
        @category = Category.find(params[:id])
    end
    
    def new
        @category = Category.new
    end
    
    def edit
        @category = Category.find(params[:id])
    end
    
    def create
        @category = Category.new(category_params)
        @category.user = current_user
        
        if @category.save
            redirect_to @category
        else
            render 'new'
        end
    end
    
    def update
        @category = Category.find(params[:id])
        
        if @category.update(category_params)
            redirect_to @category
        else
            render 'edit'
        end
    end
    
    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        
        if @category.destroyed?
            redirect_to categories_path
        else
            redirect_to categories_path, :flash => { :danger => "Error: #{@category.errors[:base][0].to_s}" }
        end
    end

        
    
    private
        def category_params
            params.require(:category).permit(:categoryBody, :user)
        end

       
    
end
