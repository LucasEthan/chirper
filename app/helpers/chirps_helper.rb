module ChirpsHelper
  def show_image(chirp)
    image_tag(chirp.image.variant(resize_to_limit: [500, 500])) if chirp.image.attached?
  end
end
