require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

@@rolodex = rolodex.new


# View all contacts
get '/contacts' do
	@contacts = []
  @contacts << Contact.new("Julie", "Hache", "julie@bitmakerlabs.com", "Instructor")
  @contacts << Contact.new("Will", "Richman", "will@bitmakerlabs.com", "Co-Founder")
  @contacts << Contact.new("Chris", "Johnston", "chris@bitmakerlabs.com", "Instructor")

	erb :contacts
end 

# Add a new contact
get '/contacts/new' do
	erb :new_contact
end 

post '/contacts' do 
	puts params
end 

# View a contact
get '/contacts/:id' do
end 



# Modify a contact
# View all contacts
get '/contacts/:id/edit' do
end 
