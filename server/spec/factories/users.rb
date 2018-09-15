# == Schema Information
#
# Table name: users
#
#  id             :bigint(8)        not null, primary key
#  comments_count :integer          default(0), not null
#  image_url      :string
#  likes_count    :integer          default(0), not null
#  nickname       :string           not null
#  remember_token :string           not null
#  role           :integer          default(0), not null
#  uid            :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_users_on_remember_token  (remember_token) UNIQUE
#  index_users_on_uid             (uid) UNIQUE
#

FactoryBot.define do
  factory :user do
    sequence :uid
    nickname { Faker::Internet.user_name }

    trait(:guest)  { role { :guest }  }
    trait(:admin)  { role { :admin }  }
    trait(:banned) { role { :banned } }
  end
end
