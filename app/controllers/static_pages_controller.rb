class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @chirp = current_user.chirps.build
      @feed_items = current_user.feed.order_by_date_desc.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact_us
  end
end
