class HousesController < ApplicationController
  before_action :set_house, except: %i[index new create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorized, only: %i[listing pricing description photo_upload amenities location update]

  def index
    @houses = current_user.houses
  end

  def new
    @house = current_user.houses.build
  end

  def create
    @house = current_user.houses.build(house_params)
    if @house.save
      redirect_to listing_house_path(@house), notice: 'Saved...'

    else
      flash[:alert] = 'Please fill out the fields...'
      render :new
    end
  end

  def show
    @photos = @house.photos
    @user_can_view_lead_info = current_user.try(:can_view_lead_info?, @house)
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @house.photos
  end

  def amenities
  end

  def location
  end

  def publish
    unless @house.ready?
      flash[:alert] = 'You need to fill in all required fields to publish'
      return redirect_to listing_house_path(@house)
    end

    @house.update(active: true)
    redirect_to houses_path
  end

  def unpublish
    @house.update(active: false)
    redirect_to houses_path
  end

  def update
    new_params = house_params
    new_params.delete(:active) unless @house.ready?

    flash[:alert] = if @house.update(new_params)
                      'Saved...'
                    else
                      'Something went wrong...'
                    end
    redirect_back(fallback_location: request.referer)
  end

  private

  def set_house
    @house = House.find(params[:id])
  end

  def is_authorized
    redirect_to root_path, alert: 'You do not have permission' unless current_user.id == @house.user_id
  end

  def house_params
    params.require(:house).permit(:home_type, :bed_room, :bath_room, :garage, :sq_feet, 
      :listing_name, :Neighboorhood, :summary, :repairs, :address, :city, :state, :zip_code, 
      :is_air, :is_heating, :is_occupied, :is_pool, :warranty, :price, :active, :fridge, :stove, 
      :carpet, :hardwood, :storage)
  end
end
