module OmniAuthHelper
  def prepare_mock_auth_from(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      "provider" => "github",
      "uid"      => user.uid,
      "info" => {
        "image"    => user.image_url,
        "nickname" => user.nickname,
      },
    )
  end

  def prepare_access_token_from(user)
    JsonWebToken.encode(
      remember_token: user.remember_token,
      exp: 3.days.since.to_i,
    )
  end
end
