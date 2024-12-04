# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'faker'
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


# Page.create!(title: "Contact", content: "This is the contact page content.")
# Page.create!(title: "About", content: "This is the about page content.")

# Actual Categories and Coffee Products
categories = {
  "Coffee Beans" => [
    { name: "Espresso Beans", description: "Rich and bold espresso beans.", price: 12.99 },
    { name: "Arabica Beans", description: "Smooth and aromatic coffee beans.", price: 14.99 },
    { name: "Robusta Beans", description: "Strong and intense coffee beans.", price: 10.99 }
  ],
  "Accessories" => [
    { name: "Coffee Grinder", description: "Manual coffee grinder for fresh ground beans.", price: 29.99 },
    { name: "Reusable Coffee Filter", description: "Eco-friendly, reusable filter.", price: 8.99 },
    { name: "Milk Frother", description: "Handheld milk frother for cappuccinos.", price: 18.99 }
  ],
  "Apparel" => [
    { name: "Kapé Coffee T-Shirt", description: "Comfortable cotton t-shirt with Kapé Coffee logo.", price: 19.99 },
    { name: "Kapé Coffee Hoodie", description: "Cozy hoodie to keep warm while enjoying coffee.", price: 39.99 },
    { name: "Kapé Coffee Mug", description: "Ceramic coffee mug with Kapé Coffee branding.", price: 9.99 }
  ],
  "Brewing Equipment" => [
    { name: "French Press", description: "Classic French press for rich coffee.", price: 22.99 },
    { name: "Pour Over Kit", description: "Complete pour over coffee brewing kit.", price: 34.99 },
    { name: "Espresso Machine", description: "High-end espresso machine for your home.", price: 249.99 }
  ]
}

# Create The categories and products
categories.each do |category_name, products|
  category = Category.create!(name: category_name)

  products.each do |product_info|
    Product.create!(
      name: product_info[:name],
      description: product_info[:description],
      price: product_info[:price],
      category_id: category.id
    )
  end

  # Populate each category with Faker for additional products
  25.times do
    Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Commerce.material,
      price: Faker::Commerce.price(range: 5.0..100.0, as_string: true),
      category_id: category.id
    )
  end
end

puts "Data seeded successfully"
