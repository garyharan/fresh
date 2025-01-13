class Api::V1::ProfilesController < ApplicationController
  def status
    render json: { complete: false, missing_sections: ['location'] }
  end
end
