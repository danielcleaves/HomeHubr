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

 def contact_us
  ContactMailer.contact_us(
     first_name: params[:name],
     last_name: params[:surname],
     email: params[:email],
     phone_number: params[:phone],
     message: params[:message]
    ).deliver_now
  redirect_to contact_path, notcie: "Message Sent"
 end
end
