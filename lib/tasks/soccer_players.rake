require 'scraper/tweeting_athletes_parser'
require 'scraper/tweeting_athlete_parser'

namespace :soccer_players do
	
	task tweeting_athletes: :environment do

		begin

			links = TweetingAthletesParser::Athletes.new(ENV['tweeting_athletes_soccer_url']).athletes

			links.each do |link|
				athlete = TweetingAthleteParser::Athlete.new(ENV['tweeting_athletes_base_url'] + link[:athlete_url])
				print "Saving #{athlete.name}: "

				@new_athlete = Athlete.where(src: link[:athlete_url]).first_or_create
				unless @new_athlete.update_attributes(first_name: athlete.first_name, last_name: athlete.last_name, sport: "soccer")
					Rails.logger.info("Unable to update attributes for Athlete: #{@new_athlete}")
				end

				@handle = TwitterHandle.where(handle: athlete.twitter_handle).first_or_create
				unless @handle.errors.empty?
					Rails.logger.info("Unable to update/create TwitterHandle: #{@handle}. \n#{@handle.errors.full_messages}")
				else
					@new_athlete.twitter_handle = @handle
					puts "@#{@new_athlete.twitter_handle.handle}"
				end
			end
		end
	end
end