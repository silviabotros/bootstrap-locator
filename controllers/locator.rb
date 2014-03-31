require 'flash'
require 'sinatra/flash'
require 'bcrypt'

enable :sessions

helpers do
  def login?
    if session[:username].nil?
      return false
    else
      return true
    end
  end
  
  def username
    return session[:username]
  end 
end
get '/locator/?' do
  @locators = Locator.all
  erb :'locator/list'
end

get '/locator/add' do
  @form_redirect = "/add"
  @verb = "Add"
  @locator = Locator.new  
  @title = "Adding Locator"
  erb :'locator/edit'
end

put '/locator/add' do
  @locator = Locator.new(params[:locator])
  if @locator.save
    flash[:notice] = "New locator row added"
    redirect("/locator/?")
  else
    flash[:error] = "Error: #{@locator.errors}"
    redirect("/locator/add")
  end
end

get '/locator/edit/:id' do
  @form_redirect = "/edit/#{params[:id]}"
  @verb = "Edit"
  @locator = Locator.find(params[:id])
  @title = "Editing #{@locator.resource}:#{@locator.server_location_id}"
  erb :"locator/edit"
end

put '/locator/edit/:id' do
  @locator = Locator.find(params[:id])
  if @locator.update_attributes(params[:locator])
    flash[:notice] = "Locator row updated"
    redirect("/locator/?")
  else
    flash[:error] = "There was an error updating this record"
    redirect("/locator/edit/#{params[:id]}")
  end
end

delete '/locator/delete/:id' do
  @locator = Locator.find(params[:id]).destroy
  redirect("/locator/?")
end
