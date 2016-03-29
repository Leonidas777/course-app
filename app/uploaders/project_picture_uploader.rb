class ProjectPictureUploader < BaseUploader
  version :thumb_323x323 do
    process resize_and_pad: [323, 323]
  end
  version :thumb_40x40 do
    process resize_and_pad: [40, 40]
  end
end
