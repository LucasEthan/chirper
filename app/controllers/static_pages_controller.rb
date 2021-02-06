class StaticPagesController < ApplicationController
  def home
    @chirp = current_user.chirps.build if logged_in?
    @feed_items = current_user.feed.order_by_date_desc.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact_us
  end
end
