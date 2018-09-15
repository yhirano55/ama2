class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :avatar_url, :comments_count, :likes_count, :created_at, :updated_at

  def avatar_url
    return unless object.image_url

    Rails.application.routes.url_helpers.rails_blob_path(object.avatar, only_path: true)
  end
end
