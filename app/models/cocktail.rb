class Cocktail < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, presence: true, allow_blank: false, uniqueness: true
end
