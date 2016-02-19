class Question < ActiveRecord::Base
    validates :category, presence: true,
    length: { minimum: 5}
    
    validates :body, presence: true,
    length: { minimum: 5}
end
