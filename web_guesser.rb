require 'sinatra'
require 'byebug'
require 'sinatra/reloader'
@@count=5

def check_guess(guess)
	guess_n=guess unless guess.nil?

	too_high=@@number+5
	too_low=@@number-5
	
	if guess_n.nil?
		puts "enter your guess"
		@@con
	elsif guess_n>too_high
		return "way too high"
	elsif guess_n<too_low
		return "way too low"
	elsif guess_n>@@number
		return "too high"
	elsif guess<@@number
		return "too low"
	elsif guess==@@number
		return "bravo you Guessed it right.....The Secret number is #{@@number}"
	else
		puts " "
	end
end

def check_count(guess)
	if guess.nil?
		"" 
	elsif @@count>1 && guess!=@@number
		@@count=@@count-1
		return "u have #{@@count} counts left"
	elsif @@count>0 && guess==@@number
		@@count=5
		@@number=rand(100)
		return "U guessed right...resetting the game"
	elsif @@count==1 && guess!=@@number
		@@count=5
		@@number=rand(100)
		return "too many tries...resetting"
	end
end

def background(message)
 	if message=='way too high' || message=='way too low'
 		return color='#FF0000'
 	elsif message=='too low' || message=='too high'
 		return color='#DC143C'
 	else return color='#008000'
 	end
end

def cheat(cheat)
 	return "the secret number is #{@@number}" if cheat=="true"
end

get '/' do

	@@number||=rand(100)
	
	guess=params['guess'].to_i
	message=check_guess(guess)
	count_message=check_count(guess)
	bg_color=background (message)
	cheat=params['cheat']
	cheat_n=cheat(cheat)

	erb :index , locals: { number: @@number, 
							guess:  guess, 
							message: message,
							bg_color: bg_color,
							cheat_n: cheat_n,
							count_message: count_message
							 }
end

	
#guess=params['guess'].to_i
#@message=check_guess(guess)

	