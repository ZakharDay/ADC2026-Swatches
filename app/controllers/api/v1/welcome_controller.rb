class Api::V1::WelcomeController < ApplicationController
  def index
    @colors = Color.all
    # render json: { color: @color.as_json(only: [:rgb_hash]) }
    # render json: { color: @color.as_json }
  end

  def about
  end
end
