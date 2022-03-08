class Api::V1::RoadtripController < ApplicationController
  before_action :require_user, only: [:show]

  def show
    roadtrip = RoadtripFacade.roadtrip(params[:origin], params[:destination])
    render json: RoadtripSerializer.new(roadtrip)
  end
end 
