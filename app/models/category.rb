class Category < ApplicationRecord
  belongs_to :category

  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "name", "updated_at" ]
  end
end
