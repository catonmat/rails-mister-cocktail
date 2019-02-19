class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process eager: true  # Force version generation at upload time.

  process convert: 'jpg'

  version :thumbnail do
    resize_to_fit 200, 200
  end

  version :bright_face do
    cloudinary_transformation effect: "brightness:30", radius: 20,
      width: 150, height: 150, crop: :thumb, gravity: :face
  end

  version :large_thumb  do
    cloudinary_transformation effect: "brightness:30", width: 50, height: 50
  end
end
