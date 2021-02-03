class StaticPagesController < ApplicationController
  def home
    @chirp = current_user.chirps.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact_us
  end
end
