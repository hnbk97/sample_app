class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_desc, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.maximum}
  validate :picture_size

  private

  def picture_size
    return if picture.size <= Settings.picture_size.size.megabytes
    errors.add :picture, t("warning_file_size")
  end
end
