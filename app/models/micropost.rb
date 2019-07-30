class Micropost < ApplicationRecord
  belongs_to :user
  scope :list_desc,-> { order created_at: :desc }
  scope :by_id, -> (id){ where user_id: id }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.content_max_length }
  validate  :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > Settings.pic_max_size.megabytes
      errors.add(:picture, I18n.t("pic_size"))
    end
  end
end
