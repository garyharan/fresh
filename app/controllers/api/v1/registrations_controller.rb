class Api::V1::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include Devise::Controllers::Helpers

  def create
    user = User.find_by(email: user_params[:email])

    if user
      debugger
      render json: { error: 'User already exists' }, status: :unprocessable_entity
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
