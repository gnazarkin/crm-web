require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

@@rolodex = Rolodex.new
@crm_app_name = "My CRM"
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))



get '/' do
	@crm_app_name = "My CRM"
	erb :index
end 

# View all contacts
get '/contacts' do
	@crm_app_name = "My CRM"
	erb :contacts
end 

post '/contacts' do 
	@crm_app_name = "My CRM"
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect to('/contacts')
end 

get "/contacts/1000" do
	@crm_app_name = "My CRM"
  @contact = @@rolodex.find(1000)
  erb :show_contact
end

# Add a new contact
get '/contacts/new' do
	@crm_app_name = "My CRM"
	erb :new_contact
end 



# View a contact
get '/contacts/:id' do
	@crm_app_name = "My CRM"
	erb :view_contact
end 

# Modify a contact
# View all contacts
get '/contacts/:id/edit' do
	@crm_app_name = "My CRM"
	erb :edit_contacts
end 
