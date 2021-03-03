require 'open-uri'
require 'nokogiri'
require "open-uri"
require 'faker'
require 'json'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# scrap data from epicurious
  # cuisine : %w(Italian Mediterranean European Italian American Greek American Mexican French)
  # course : %w(Dinner  Lunch  Appetizer)
  #  10 dinner from each cuisine
  # 5 dessert for each cuisine
  # 5 Appetizer

# create cook
  # create 5 cook for each cuisine with 1 appetizer 2 dinner and 1 desserts

# methods

CUISINES =  %w(italian mediterranean european american greek mexican french)
COURSES = %w(dinner dessert appetizer)
COURSES.each do |course| course = Course.new(name:course)
course.save!
end





def scrap_from_epicurious(appetizers, dinners, desserts)




meals = []

CUISINES.each do |cuisine|

  Course.all.each do |course|
      case course
      when Course.find(3)
        number_of_items = appetizers
      when Course.find(1)
        number_of_items = dinners
      else
        number_of_items = desserts
      end
      cards = []
      puts "Scrapping #{course.name}s of #{cuisine} cuisine."
      html_doc = scrap(epicurious_url(cuisine, course.name))

      html_doc.search('.recipe-content-card').each do |card|

        if scrap("https://www.epicurious.com#{card.search('a').attribute('href').value}").search(".photo-wrap").search("img").attribute("srcset")
          cards << card
        end

      end

      cards.first(number_of_items).each do |card|

        tag = card.search(".tag").text.strip
        name = card.search(".hed").text.strip
        url = "https://www.epicurious.com#{card.search('a').attribute('href').value}"
        show =  scrap(url)
        description = show.search(".dek").text.strip
        photo = show.search(".photo-wrap").search("source").first.attribute("srcset").value
        p photo

        if tag == "recipe" && description.length > 0
          new_meal = Meal.new({
            cuisine: cuisine,
            name: name,
            description: description,
            price_cents: (1000+rand*1000).round,
          })
          file = URI.open(photo)
          new_meal.photo.attach(io: file, filename: Faker::Alphanumeric.alpha(number: 10), content_type: 'image/png')
          new_meal.courses = [course]
          meals << new_meal
        end
      end
      puts "Done with #{course.name}s of #{cuisine} cuisine."
      puts meals.last.cuisine
      end
  end
  return meals
end

def epicurious_url(cuisine, course)
  return "https://www.epicurious.com/search/?cuisine=#{cuisine}&meal=#{course}"
end

def scrap(url)
  html_file = open(url).read
  return html_doc = Nokogiri::HTML(html_file)
end

puts "Start seeding"
meals = scrap_from_epicurious(1, 2, 1)

def random_restaurant
  file      = File.open("#{pwd}/db/RestaurantsParis.xml")
  document  = Nokogiri::XML(file)
  restaurants = []
  restaurant_list = document.root.xpath('Placemark')
  restaurant_list.each do |restaurant|
      loc = restaurant.xpath('Point').xpath('coordinates').text.strip.split(',').map{|num| num.to_f}
      restaurants << {
      longitude: loc[0],
      latitude: loc[1],
      }
  end
  return restaurants.sample
end


def google_map_reverse_geocoding(lat,long)
  return "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{long}&key=#{ENV['GOOGLE_MAP_API_KEY']}"
end


CUISINES.each do |cuisine|
  1.times do
    puts "Creation of a chef for #{cuisine} cuisine"
    place = random_restaurant()
    new_user = User.new
    new_user.first_name = Faker::Name.first_name
    new_user.last_name = Faker::Name.last_name
    new_user.email = Faker::Internet.safe_email(name: "#{new_user.first_name.downcase}#{new_user.last_name.downcase}")
    new_user.password = 'testpassword123456'
    new_user.password_confirmation = new_user.password
    new_user.longitude = place[:longitude]
    new_user.latitude = place[:latitude]
    url = google_map_reverse_geocoding(new_user.latitude,new_user.longitude)
    map_serialized = open(url).read
    map = JSON.parse(map_serialized)
    new_user.home_address = map["results"].first["formatted_address"]
    # 
    file = URI.open("https://source.unsplash.com/400x400/?portrait,human")
    new_user.photo.attach(io: file, filename: Faker::Alphanumeric.alpha(number: 10), content_type: 'image/png')
    new_user.save!
    puts "#{new_user.first_name} #{new_user.last_name} created"
    puts "saving to the chef 1 starter 2 main courses and 1 dessert"
    diners = meals.select{|meal| meal.cuisine == cuisine}.reject{|meal| meal.id}.select{|meal| meal.courses.first == Course.find(1)}
    diner = diners.first
    diner.user = new_user
    diner.save!
    puts diner.name
    diners = meals.select{|meal| meal.cuisine == cuisine}.reject{|meal| meal.id}.select{|meal| meal.courses.first == Course.find(1)}
    diner = diners.first
    diner.user = new_user
    diner.save!
    puts diner.name
    desserts = meals.select{|meal| meal.cuisine == cuisine}.reject{|meal| meal.id}.select{|meal| meal.courses.first == Course.find(2)}
    dessert = desserts.first
    dessert.user = new_user
    dessert.save!
    puts dessert.name
    appetizers = meals.select{|meal| meal.cuisine == cuisine}.reject{|meal| meal.id}.select{|meal| meal.courses.first == Course.find(3)}
    appetizer = appetizers.first
    appetizer.user = new_user
    appetizer.save!
    puts appetizer.name
  end
end

# creation of order and reviews
sample_review = %w(disgusting, bad, ok, good, amazing)
remaining_users = User.all
# selection of one user
4.times do 
  client = User.all.sample
  # reject cet user de la liste des user et sauver cette nouvelle liste dans une variable
  remaining_users = remaining_users.reject{|user| user == client}
  chef = remaining_users.sample
  # prendre un meal de cet user
  lines = []
  choosen_meal = chef.meals.sample
  lines << choosen_meal
  # rajouter eventuellement un other course
  other_courses = chef.meals.reject{|meal| meal == choosen_meal}
  other_course = other_courses.sample
  lines << other_course
  # create an order avec random date et random number
  order = Order.new
  order.user = client
  order.delivery_date = order.random_delivery_date
  order.status = "Paid"
  order.save!
  quantity = (6..12).to_a.sample
  lines.each do |meal|
    new_line = Line.new
    new_line.quantity = quantity
    new_line.meal = meal
    new_line.order = order  
    new_line.save!
  end
  # ajouter une review
  review = Review.new
  rating = (1..5).to_a.sample
  content = sample_review[rating]
  review.rating = rating-1
  review.content = content
  review.order = order
  review.user = client
  review.save!
end
# refaire ca 15 fois


