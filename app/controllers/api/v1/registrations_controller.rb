class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include Devise::Controllers::Helpers

  def create
    email = user_params["email"]
    password = user_params["password"]

    if user = User.find_by(email: email)
      if User.valid_credentials?(email, password)
        sign_in user
        render json: { token: user.authentication_token }
      else
        render json: { error: error_message }, status: :unauthorized
      end
    else
      user = User.new(user_params)
      if user.save
        sign_in user
        render json: { message: 'User created successfully', token: user.authentication_token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
