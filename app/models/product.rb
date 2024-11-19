class Product < ApplicationRecord
  has_many :products

  def self.ransackable_associations(auth_object = nil)
    [ "products" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "created_at", "description", "id", "name", "price", "updated_at" ]
  end
end
