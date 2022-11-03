class Image < ApplicationRecord
  belongs_to :profile

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_fit: [100, 100]
    attachable.variant :medium, resize_to_fill: [200, 200]
    attachable.variant :standard, resize_to_fit: [500, 500]
  end
end
