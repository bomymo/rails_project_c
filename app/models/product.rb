class Product < ApplicationRecord
  has_many :orders
  has_many :comments
  validates :name, presence: true
  validates :description, presence: true
  validates :colour, presence: true
  validates :price, :numericality => { :greater_than => 0 }
  validates :image_url, presence: true


  def self.search(search_term)
    if Rails.env.production?        # specific syntax requirement for PostgreSQL
      Product.where("name ilike ?", "%#{search_term}%")
    else
      Product.where("name LIKE ?", "%#{search_term}%")
    end
  end

  #def highest_rating_comment
  #  comments.rating_desc.first
  #end

  #def lowest_rating_comment
  #  comments.rating_asc.first
  #end

  def average_rating
    comments.average(:rating).to_f
  end

  def views
    $redis.get("product:#{id}") # GET product: 1
  end

  def viewed!
    $redis.incr("product:#{id}") # INC product: 1
  end
end

  