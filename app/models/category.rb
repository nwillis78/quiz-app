class Category < ActiveRecord::Base
	has_many :question

	validates :categoryBody, presence: true,
                    length: { minimum: 3 }
end
