class PhotosController < ApplicationController
  def create
    house = House.find(params[:house_id])
    images = params[:images] || []

    images.each do |img|
      house.photos.build(image: img)
    end

    msg = house.save ? { notice: 'Saved...' } : { alert: house.errors.full_messages.join(' ') }

    redirect_back({ fallback_location: request.referer }.merge(msg))
  end

  def destroy
    @photo = Photo.find(params[:id])
    @house = @photo.house

    @photo.destroy
    @photos = Photo.where(house_id: @house.id)

    respond_to :js
  end
end
