require 'sinatra'

get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

# View all contacts
get '/contacts' do
end 

# View a contact
get '/contacts/:id' do
end 

# Add a new contact
get '/contacts/new' do
end 

# Modify a contact
# View all contacts
get '/contacts/:id/edit' do
end 
