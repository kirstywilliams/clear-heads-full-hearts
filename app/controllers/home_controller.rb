class HomeController < ApplicationController

	def index

		@athletes = Athlete.soccer_players
		
	end
end
