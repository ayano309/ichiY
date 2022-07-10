# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Item < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/ichigo.jpg')
      image.attach(io: File.open(file_path), filename: 'ichigo.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
