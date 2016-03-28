class Category < ActiveRecord::Base
	has_many :question
	belongs_to :user

	validates :categoryBody, presence: true, uniqueness: true,
                    length: { minimum: 3 }
end
