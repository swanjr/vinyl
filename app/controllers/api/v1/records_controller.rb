class Api::V1::RecordsController < ApplicationController
  def index

  end
  
  def create
    record = AddRecordService.new(params.to_unsafe_h()).perform   

    if record.album.errors.empty?
      render json: {errors: ""}, status: :created
    else
      errors = record.album.errors.full_messages
      render json: {errors: errors}, status: :unprocessable_entity 
    end
  end

  def update

  end

  def delete

  end
end
