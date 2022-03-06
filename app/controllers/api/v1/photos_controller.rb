class Api::V1::PhotosController < ApplicationController
  def show
    background = PhotoFacade.random_img(params[:location])
    render json: ImageSerializer.new(background)
  end
end
