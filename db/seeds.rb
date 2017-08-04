# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Data ..."

# Helper functions
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

# Only run on development (local) instances not on production, etc.
unless Rails.env.development?
  puts "Development seeds only (for now)!"
  exit 0
end

# Let's do this ...

## USERS

User.destroy_all

user1 = User.create!({
  first_name: 'Dr.',
  last_name: 'Jekyll',
  email: 'drjekyll@madscientists.com',
  password_digest: BCrypt::Password.create('password'),
  admin: false

})

user2 = User.create!({
  first_name: 'Mr.',
  last_name: 'Hyde',
  email: 'mrhyde@madscientists.com',
  password_digest: BCrypt::Password.create('password'),
  admin: false
})

user3 = User.create!({
  first_name: 'Victor',
  last_name: 'Frankenstein',
  email: 'frankenstein@madscientists.com',
  password_digest: BCrypt::Password.create('password'),
  admin: false
})

user4 = User.create!({
  first_name: 'admin',
  last_name: 'lyfe',
  email: 'admin@couchlyfe.com',
  password_digest: BCrypt::Password.create('password'),
  admin: true
})


## CATEGORIES

puts "Finding or Creating Categories ..."

cat1 = Category.find_or_create_by! name: 'Apparel'
cat2 = Category.find_or_create_by! name: 'Electronics'
cat3 = Category.find_or_create_by! name: 'Furniture'

## PRODUCTS

puts "Re-creating Products ..."

Product.destroy_all

cat1.products.create!({
  name:  'Flasks',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('apparel1.jpg'),
  quantity: 10,
  price: 64.99
})

cat1.products.create!({
  name:  'Jars for Brains',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('apparel2.jpg'),
  quantity: 18,
  price: 124.99
})

cat1.products.create!({
  name:  'Potions (assortment)',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('apparel3.jpg'),
  quantity: 4,
  price: 34.49
})

cat1.products.create!({
  name:  'X-Ray Goggles',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('apparel4.jpg'),
  quantity: 8,
  price: 25.00
})

cat1.products.create!({
  name:  'Lab Coat',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('apparel5.jpg'),
  quantity: 8,
  price: 1_225.00
})

cat1.products.create!({
  name:  'Caution: Radioactive stickers',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('apparel6.jpg'),
  quantity: 82,
  price: 224.50
})


cat2.products.create!({
  name:  'Defibrillator Laser Gun',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('electronics1.jpg'),
  quantity: 40,
  price: 164.49
})

cat2.products.create!({
  name:  'Electrical Coils',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('electronics2.jpg'),
  quantity: 3,
  price: 26.00
})

cat2.products.create!({
  name:  'Oudin Coil',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('electronics3.jpg'),
  quantity: 32,
  price: 2_026.29
})

cat3.products.create!({
  name:  'Sharks',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('furniture1.jpg'),
  quantity: 320,
  price: 3_052.00
})

cat3.products.create!({
  name:  'Electric Chair',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('furniture2.jpg'),
  quantity: 0,
  price: 987.65
})

cat3.products.create!({
  name:  'Mr. Meeseek\'s Box',
  description: Faker::Lovecraft.paragraph,
  image: open_asset('furniture3.jpg'),
  quantity: 23,
  price: 2_483.75
})

## REVIEWS

Review.destroy_all

12.times do |count|

  rev1 = Review.create!({
    product_id: count,
    user_id: 1,
    rating: 4,
    description: Faker::Lovecraft.paragraph
  })

  rev2 = Review.create!({
    product_id: count,
    user_id: 2,
    rating: 2,
    description: Faker::Lovecraft.paragraph
  })

  rev3 = Review.create!({
    product_id: count,
    user_id: 3,
    rating: 5,
    description: Faker::Lovecraft.paragraph
  })
end

puts "DONE!"
