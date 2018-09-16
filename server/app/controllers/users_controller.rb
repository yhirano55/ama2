class UsersController < ApplicationController
  def index
    authorize User
    users = User.with_attached_avatar.newest.page(params[:page])
    render json: UsersWithPagination.new(data: users, context: request), include: "**", serialize: UsersWithPaginationSerializer
  end

  def show
    user = User.with_attached_avatar.find(params[:id]).tap(&method(:authorize))
    render json: user
  end
end
