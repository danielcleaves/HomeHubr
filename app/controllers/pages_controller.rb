class PagesController < ApplicationController
  def home
  	@houses = House.where(active: true).limit(3)
  end

  def search
  	# STEP 1
  	if params[:search].present? && params[:search].strip != ""
  		session[:loc_search] = params[:search]
 	end

 	# STEP 2

 	if session[:loc_search] && session[:loc_search] != ""
 		@houses_address = House.where(active: true).near(session[:loc_search], 5, order: 'distance')
    session.delete(:loc_search)
 	else

 		@houses_address = House.where(active: true).all
 	end

 	# STEP 3

 	@search = @houses_address.ransack(params[:q])
 	@houses = @search.result

 	@arrHouses = @houses.to_a
 end
end
