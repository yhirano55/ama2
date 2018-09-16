class AuthenticationsController < ActionController::Base
  def create
    @payload = {
      authToken: auth_token,
      user: {
        nickname: user.nickname,
        avatarUrl: avatar_url,
      },
    }
  end

  private

    def user
      @user ||= User.find_or_initialize_by(uid: auth.dig(:uid)).tap do |u|
        u.nickname  = auth.dig(:info, :nickname)
        u.image_url = auth.dig(:info, :image)
        u.save!
      end
    end

    def auth_token
      JsonWebToken.encode({ remember_token: user.remember_token, exp: 3.days.since.to_i })
    end

    def avatar_url
      rails_blob_path(user.avatar, only_path: true) if user.image_url
    end

    def auth
      request.env["omniauth.auth"]
    end
end
