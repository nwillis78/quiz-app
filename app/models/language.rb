class Language < ActiveRecord::Base
	belongs_to :direction

	validates :languageName, presence: true,
                    length: { minimum: 3 }
    validates :direction_id, presence: true
end
