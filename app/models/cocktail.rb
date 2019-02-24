class Cocktail < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses

  validates :name, presence: true, allow_blank: false, uniqueness: true

  include PgSearch
  pg_search_scope :search_by_name_and_ingredients_name,
    against: [:name],
    associated_against: {
      ingredients: [:ingredients_name]
    },
    using: {
    tsearch: { prefix: true }
    }

  multisearchable against: [ :name, :instructions ]
end
