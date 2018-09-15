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

require "rails_helper"

RSpec.describe User, type: :model do
  describe "factory" do
    subject { build(:user) }

    it { is_expected.to be_valid }
  end

  describe "remember_token" do
    subject { user.remember_token }

    let(:user) { build(:user) }

    context "before saved" do
      it { is_expected.to be_nil }
    end

    context "after saved" do
      before { user.save! }

      it { is_expected.to be_a(String) }
    end
  end
end
