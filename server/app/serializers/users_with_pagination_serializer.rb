class UsersWithPaginationSerializer < ActiveModel::Serializer
  attributes :links
  has_many :data, serializer: UserSerializer
end
