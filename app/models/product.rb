class Product < ApplicationRecord
  has_many :category_products
  has_many :categories, through: :category_products
end
