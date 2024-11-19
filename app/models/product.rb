class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_one_attached :image # adds image attachment support


  def self.ransackable_associations(auth_object = nil)
    [ "products" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "created_at", "description", "id", "name", "price", "updated_at" ]
  end
end
