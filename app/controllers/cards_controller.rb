class CardsController < ApplicationController
  before_action :set_profile

  def new
    @card = Card.new kind: params[:kind]
  end
  def create
    create_card!

    # respond_to do |format|
    #   if create_card!
    #     format.turbo_stream
    #     format.json { render :show, status: :created, location: @card }
    #   else
    #     format.turbo_stream
    #     format.json do
    #       render json: @profile.errors, status: :unprocessable_entity
    #     end
    #   end
    # end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    @card.update card_params
  end

  def destroy
  end

  private

  def create_card!
    @card = Card.new(card_params)
    @card.profile = current_user.profile

    @card.save!
  end

  def set_profile
    @profile = current_user.profile
  end

  def card_params
    params.require(:card).permit(:kind, :title, :content)
  end
end
