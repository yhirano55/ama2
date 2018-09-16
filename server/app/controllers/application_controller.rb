class ApplicationController < ActionController::API
  include Pundit

  before_action :set_raven_context

  rescue_from Exception do |e|
    if Rails.env.production?
      render status: :internal_server_error, json: { errors: [{ message: "Internal server error" }] }
    else
      render status: :internal_server_error, json: { errors: [{ message: "#{e.message}: #{e.backtrace}" }] }
    end
  end

  rescue_from ActionController::BadRequest, ActiveRecord::RecordInvalid do |e|
    render status: :bad_request, json: { errors: [{ message: e.message }] }
  end

  rescue_from Pundit::NotAuthorizedError do |e|
    render status: :forbidden, json: { errors: [{ message: e.message }] }
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render status: :not_found, json: { errors: [{ message: e.message }] }
  end

  private

    def current_user
      return unless http_token
      return @current_user if defined?(@current_user)

      @current_user = User.with_attached_avatar.find_by(remember_token: auth_token[:remember_token])
    end

    def auth_token
      @auth_token ||= JsonWebToken.decode(http_token)
    rescue JWT::VerificationError, JWT::DecodeError
      nil
    end

    def http_token
      @http_token ||= if request.headers["Authorization"].present?
                        request.headers["Authorization"].split(" ").last
                      end
    end

    def set_raven_context
      Raven.user_context(id: current_user&.id)
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
end
