module TweetingAthleteParser

	class Athlete

		USER_AGENTS = ['Windows IE 6', 'Windows IE 7', 'Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla', 'Linux Firefox', 'Linux Konqueror']

	    ATTRIBUTES = %w(first_name last_name name twitter_link twitter_handle)

	    attr_reader :page, :athlete_url

	    def self.get_page(url)

	    	TweetingAthleteParser::Athlete.new(url)

	    rescue => e

	    	Rails.logger.info("Unable to get page for athlete at #{url}. \n#{e.message}")

	    end

	    def initialize(url)

	    	@athlete_url = url
	    	@page = http_client.get(url)

	    end

	    def name

	    	"#{first_name} #{last_name}"
	    	
	    end

	    def first_name

	    	@first_name ||= (@page.at('h1.name').text.split(' ', 2)[0].strip if @page.at('h1.name'))

	    end

	    def last_name

	    	@last_name ||= (@page.at('h1.name').text.split(' ', 2)[1].strip if @page.at('h1.name') and @page.at('h1.name').text.split(' ', 2)[1])

	    end

	    def twitter_link

	    	@twitter_link ||= (@page.at('a.twitter-follow-button')['href'] if @page.at('a.twitter-follow-button'))

	    end
	    	
	    def twitter_handle

	    	@twitter_handle ||= URI.parse(twitter_link).path.gsub(/\//, "") if twitter_link

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