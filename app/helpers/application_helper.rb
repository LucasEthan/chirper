module ApplicationHelper
  def full_title
    "#{content_for(:page) + ' | ' if content_for?(:page)}Chirper"
  end

  def display_flash_messages(flash)
    content = ""
    flash.each do |message_type, message|
      content += tag.div(class: "alert alert-#{message_type}") do
        tag.p(message)
      end
    end
    content.html_safe
  end

  def current_year
    Time.current.year
  end

  def form_error_message(model)
    "The form contains #{pluralize(model.errors.count, 'error')}"
  end
end
