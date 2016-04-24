class Group < ActiveRecord::Base
	has_many :members, dependent: :destroy 

	validates :name, presence: true, length: { minimum: 3}

end
