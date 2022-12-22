# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: 'koncipor@gmail.com', password: 'oknols88', nickname: 'panKarol')

Article.create!(label: 'aaa', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: true, worth_reading: true, box_size: 0)
Article.create!(label: 'bbb', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: true, worth_reading: false, box_size: 0)
Article.create!(label: 'ccc', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: false, worth_reading: true, box_size: 0)
Article.create!(label: 'ddd', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: true, worth_reading: false, box_size: 0)
Article.create!(label: 'eee', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: true, worth_reading: true, box_size: 1)
Article.create!(label: 'fff', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: false, worth_reading: false, box_size: 0)
Article.create!(label: 'ggg', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: false, worth_reading: true, box_size: 2)
Article.create!(label: 'hhh', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: true, worth_reading: false, box_size: 1)
Article.create!(label: 'iii', description: 'eew ewe dewiojod djwei jweo', content: 'aaa', bg_image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Capybara_portrait.jpg/1280px-Capybara_portrait.jpg', published: true, worth_reading: false, box_size: 1)
p 'OK'
