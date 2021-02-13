class ChirpsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @chirp = current_user.chirps.build(chirps_params)
    @chirp.image.attach(params[:chirp][:image])
    if @chirp.save
      flash[:success] = "Chirp successfully created"
      redirect_to root_path
    else
      flash.now[:danger] = helpers.form_error_message(@chirp)
      @feed_items = current_user.feed.order_by_date_desc.paginate(page: params[:page])
      render "static_pages/home"
    end
  end

  def destroy
    @chirp.destroy
    flash[:success] = "Chirp was successfully deleted"
    redirect_back(fallback_location: root_path)
  end

  private

  def chirps_params
    params.require(:chirp).permit(:content, :image)
  end

  def correct_user
    @chirp = current_user.chirps.find_by(id: params[:id])
    if @chirp.nil?
      flash[:error] = "Something went wrong, please try again"
      redirect_to root_path
    end
  end
end
