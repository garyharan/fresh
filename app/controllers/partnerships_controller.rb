class PartnershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_partnership, only: %i[ update destroy ]

  def new
    @user = User.find_by(invite_code: params[:code])
    @profile = @user.profile
    @partnership = Partnership.new partner: @profile
  end

  def create
    if create_partnerships!
      redirect_to settings_partnerships_path, notice: "Partnership was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    destroy_partnerships!

    respond_to do |format|
      format.html { redirect_to settings_partnerships_url, notice: "Partnership was successfully removed." }
      format.json { head :no_content }
    end
  end

  private

    def create_partnerships!
      @partnership = current_user.profile.partnerships.create!(partnership_params)
      @inverse_partnership = @partnership.partner.partnerships.create!(partner: current_user.profile)
    end

    def destroy_partnerships!
      @partnership.partner.partnerships.find_by(partner: current_user.profile).destroy
      @partnership.destroy
    end

    def set_partnership
      @partnership = current_user.profile.partnerships.find(params[:id])
    end

    def partnership_params
      params.require(:partnership).permit(:partner_id)
    end
end
