class ChirpsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def index
  end

  def show
  end
end
