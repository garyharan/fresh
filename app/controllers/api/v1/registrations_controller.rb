class Api::V1::RegistrationsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user
      render json: { error: 'User already exists' }, status: :unprocessable_entity
    else
      user = User.new(user_params)
      if user.save
        render json: { message: 'User created successfully' }, status: :created
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
