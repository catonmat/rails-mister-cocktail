class Ingredient < ApplicationRecord
  has_many :doses

  validates :name, uniqueness: true, presence: true, allow_blank: false

  include PgSearch
  multisearchable against: [ :ingredients_name ]
end
