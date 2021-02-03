class ChirpsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @chirp = current_user.chirps.build(chirps_params)
    if @chirp.save
      flash[:success] = "Chirp successfully created"
      redirect_to current_user
    else
      flash.now[:danger] = form_error_message(chirp)
      render: root_path
    end
  end

  def destroy
  end

  private

  def chirps_params
    params.require(:chirp).permit(:content)
  end
end
