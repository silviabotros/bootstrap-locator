get '/secure/locator/?' do
  @locators = Locator.all
  erb :'locator/list'
end
