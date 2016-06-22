require 'sinatra'
require 'sinatra/reloader'
get '/' do 
x=rand(101)
"the SECRET NUMBER is #{x} "
end
