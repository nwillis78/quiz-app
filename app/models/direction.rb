class Direction < ActiveRecord::Base
	has_many :language

	validates :directionName, presence: true, uniqueness: true
	validates :directionCode, presence: true, uniqueness: true
end
