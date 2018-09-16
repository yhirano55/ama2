# frozen_string_literal: true

module JsonWebToken
  SECRET_KEY_BASE = Rails.application.credentials.secret_key_base

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY_BASE)
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, SECRET_KEY_BASE)[0])
  rescue
    nil
  end
end
