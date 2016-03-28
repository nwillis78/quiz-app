class Language < ActiveRecord::Base
	belongs_to :direction
	belongs_to :user
	has_many :question
	has_many :quiz

	validates :languageName, presence: true, uniqueness: true,
                    length: { minimum: 3 }
    validates :direction_id, presence: true
end
