class Quiz < ActiveRecord::Base
	has_many :links
	has_many :questions, through: :links
    
    validates :title, presence: true,
    length: { minimum: 5 }

end
