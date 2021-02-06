class ChirpsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @chirp = current_user.chirps.build(chirps_params)
    if @chirp.save
      flash[:success] = "Chirp successfully created"
      redirect_to root_path
    else
      flash.now[:danger] = helpers.form_error_message(@chirp)
      render "static_pages/home"
    end
  end

  def destroy
  end

  private

  def chirps_params
    params.require(:chirp).permit(:content)
  end
end
