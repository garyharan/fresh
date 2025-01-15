class CardsController < ApplicationController
  before_action :set_profile

  def new
    @card = Card.new kind: params[:kind]
  end

  def create
    create_card!
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    @card.update card_params
  end

  def destroy
    @card = Card.find(params[:id])

    @card.destroy!
  end

  private

  def create_card!
    @card = Card.new(card_params)
    @card.profile = Current.user.profile

    @card.save!
  end

  def set_profile
    @profile = Current.user.profile
  end

  def card_params
    params.require(:card).permit(:kind, :title, :content)
  end
end
