require 'sinatra'

get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

# View a contact
get '/contacts/:id' do
	
end 

#Add a new contact
get '/contacts/new' do
	"New contacts"
end 

get '/contacts' do
	"This is the contact page"
end 