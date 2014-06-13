require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

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
	erb :index
end 

# View all contacts
get '/contacts' do
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
	erb :new_contact
end 

get '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	erb :show_contact
end

get '/edit_list' do
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

get "/search" do  erb :search
end

post "/search" do
  puts params
  @contacts = Contact.all(:last_name => params[:last_name])
  if @contacts
    erb :contacts
  else
    redirect to("/no_contact")
  end 
end

get "/no_contact" do
  erb :no_contact
end

