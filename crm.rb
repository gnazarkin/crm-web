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
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	@@rolodex.add_contact(new_contact)
	redirect to('/contacts')
end 

# Add a new contact
get '/contact/new' do
	@crm_app_name = "My CRM"
	erb :new_contact
end 

get "/contacts/:id" do
	@crm_app_name = "My CRM"
    @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

get '/contact/:id/edit' do
	@crm_app_name = "My CRM"
	erb :edit_contacts
end 
