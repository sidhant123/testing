require 'jumpstart_auth'
require 'bitly'
require 'klout'

class MicroBlogger
	attr_reader :client,:bitly

	def initialize
		puts "initializing Microblogger"
		@client=JumpstartAuth.twitter
		Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
		

	end

	def tweet(message)
		@client.update(message)
	end

	def dm(target,message)
		screen_names=@client.followers.collect {|follower| @client.user(follower).screen_name}
		if screen_names.include? target
			puts "trying to send #{target} a message which is"
			puts message
			message= "d @#{target} #{message}"
			tweet(message)
		else
			puts"user does not follow you"
		end

	end

	def klout_score
		friends=@client.friends.collect{|friend| @client.user(friend).screen_name}
		friends.each do |f|
		identity=Klout::Identity.find_by_screen_name(f)
		user=Klout::User.new(identity.id)
		score=user.score.score.to_s
		puts "the score for #{f} id #{score}"
		end
	end



	def everyones_last_tweet
		@client.friends.sort_by{|friend| @client.user(friend).screen_name.downcase}.each do |friend|
		friendclient=@client.user(friend)
		puts "on #{friendclient.status.created_at.strftime("%A,%b,%d")} #{friendclient.screen_name} said.."
		puts friendclient.status.text
		puts ""
		end
	end

	def shorten(original_url)
		bitly=Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		return bitly.shorten(original_url).short_url
	end

	def run
	 	puts "welcome to the jsl twitter client"
	 	command=""
	 	while command!='q'
	 	printf "command :"					
	 	input=gets.chomp
	 	parts=input.split(" ")
	 	command=parts[0]
	 	case command
	 	when 'q' then puts "goodbye"
	 	when 't' then tweet(parts[1..-1].join(" "))
	 	when 'dm' then dm(parts[1],parts[2..-1].join(" "))
	 	when 'elt' then everyones_last_tweet
	 	when 's' then shorten(parts[1..-1])
	 	else
	 		puts"Sorry ,I dont know know how #{command}"
	 	end
	end

	
end
blogger=MicroBlogger.new
blogger.run
blogger.klout_score
end