class Product < ApplicationRecord
  has_many :orders

  def self.search(search_term)
    if Rails.env.production?        # specific syntax requirement for PostgreSQL
      Product.where("name ilike ?", "%#{search_term}%")
    else
      Product.where("name LIKE ?", "%#{search_term}%")
    end
  end

end

