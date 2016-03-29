class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :first_name, presence: true

  mount_uploader :photo, ProjectPictureUploader
end
