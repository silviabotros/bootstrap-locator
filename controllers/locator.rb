require 'flash'
require 'sinatra/flash'

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
  if @locator.update_attributes(params[:post])
    @locator.save
    flash[:notice] = "Locator row updated"
    redirect("/locator/?")
  else
    flash[:error] = "There was an error updating this record"
    redirect("/locator/edit/#{params[:id]}")
  end
end
