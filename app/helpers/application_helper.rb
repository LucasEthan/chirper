module ApplicationHelper
  def full_title
    "#{content_for(:page) + ' | ' if content_for?(:page)}Chirper"
  end
end
