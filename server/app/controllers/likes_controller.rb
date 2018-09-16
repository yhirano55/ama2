class LikesController < ApplicationController
  def create
    current_user.likes.find_or_create_by!(likeable_type: params[:type], likeable_id: params[:resource_id])
    render json: {}, status: :created
  end

  def destroy
    current_user.likes.find_by!(likeable_type: params[:type], likeable_id: params[:resource_id]).destroy!
    render json: {}, status: :ok
  end
end
