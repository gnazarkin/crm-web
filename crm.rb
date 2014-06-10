require 'sinatra'

get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

get '/about' do
	"This is my about page"
end

get '/contacts' do
	"This is the contact page"
end 
