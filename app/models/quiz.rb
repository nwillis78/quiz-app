class Quiz < ActiveRecord::Base
    has_many :questions, dependent: :destroy
    
    validates :title, presence: true,
    length: { minimum: 5 }
end
