class BaseUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    subfolder = Rails.env.test? ? 'test/' : '' "system/uploads/#{subfolder}#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path 'fallback/' + [model.class.to_s.underscore, mounted_as, model.id].to_s
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
