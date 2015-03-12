require 'rubygems'
require 'mechanize'

module TweetingAthletesParser

	class Athletes

		USER_AGENTS = ['Windows IE 6', 'Windows IE 7', 'Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla', 'Linux Firefox', 'Linux Konqueror']

		ATTRIBUTES = %w(athletes)

		attr_reader :page, :athletes_url

		def self.get_page(url)

			TweetingAthletesParser::Athletes.new(url)

		rescue => e

			Rails.logger.info("Unable to get page for athletes at #{url}. \n#{e.message}")
			
		end

		def initialize(url)
			
			@athletes_url = url
			@page = http_client.get(url)

		end

		def athletes

			@athletes ||= @page.search('div.person-box div.name a').map do |item|
				athlete_url = item['href']
				{ :athlete_url => athlete_url }
			end

		end

		def to_json

			require 'json'
			ATTRIBUTES.reduce({}){ |hash,attr| hash[attr.to_sym] = self.send(attr.to_sym);hash }.to_json
			
		end


	    private

	    def http_client

	    	Mechanize.new do |agent|
	    		agent.user_agent_alias = USER_AGENTS.sample
	    		agent.max_history = 0
	    	end
	    	
	    end

	end

end