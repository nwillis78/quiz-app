class Question < ActiveRecord::Base
    has_many :answers, dependent: :destroy
    accepts_nested_attributes_for :answers, allow_destroy: true
    
    validates :category, presence: true,
    length: { minimum: 5}
    
    validates :body, presence: true,
    length: { minimum: 5}
end
