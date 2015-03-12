class Athlete < ActiveRecord::Base
	has_one :twitter_handle

	scope :soccer_players, lambda { where("sport = ?", "soccer") }

	def name

		"#{first_name} #{last_name}"

	end
end
