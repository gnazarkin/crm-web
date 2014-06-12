require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")
require_relative 'rolodex'

@@rolodex = Rolodex.new
@crm_app_name = "My CRM"
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

class Contact
  attr_accessor :id, :first_name, :last_name, :email, :note

  def initialize(first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end
end


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

get '/contacts/:id' do
  @crm_app_name = "My CRM"
	@contact = @@rolodex.find(params[:id].to_i)
	erb :show_contact
end

get '/edit_list' do
	@crm_app_name = "My CRM"
		erb :edit_list
	end

put '/contacts/:id' do
	 @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
	@crm_app_name = "My CRM"
	@contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

get "/search" do
  @crm_app_name = "My CRM"
  erb :search
end

post "/search" do
  puts params
  @contact = @@rolodex.find_last(params[:last_name].to_s)
  if @contact
    redirect to("/contacts/#{@contact.id}")
  else
    raise Sinatra::NotFound
  end 
end



