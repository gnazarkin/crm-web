require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

@crm_app_name = "My CRM"

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!


get '/' do
	@crm_app_name = "My CRM"

	erb :index
end 

# View all contacts
get '/contacts' do
	@crm_app_name = "My CRM"

  @contacts = Contact.all
	erb :contacts
end 

post '/contacts' do 
	 @contact = Contact.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
  )
	redirect to('/contacts')
end 
# Add a new contact
get '/contact/new' do
	@crm_app_name = "My CRM"

	erb :new_contact
end 

get '/contacts/:id' do
  @crm_app_name = "My CRM"

	@contact = Contact.get(params[:id].to_i)
	erb :show_contact
end

get '/edit_list' do
	@crm_app_name = "My CRM"

  @contacts = Contact.all
		erb :edit_list
	end

put '/contacts/:id' do
	 @contact = Contact.get(params[:id].to_i)
  if @contact

    @contact.update(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :note => params[:note]
    )

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
	@crm_app_name = "My CRM"

	@contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do

  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
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
  @contact = Contact.get(params[:last_name].to_s)
  if @contact
    redirect to("/contacts/#{@contact.id}")
  else
    raise Sinatra::NotFound
  end 
end



