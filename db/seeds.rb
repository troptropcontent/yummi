
require 'nokogiri'
require "open-uri"
require 'faker'

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
        photo = show.search(".photo-wrap").search("img").attribute("srcset").value
        puts photo
  
        if tag == "recipe" && description.length > 0
          new_meal = Meal.new
          new_meal.cuisine = cuisine
          new_meal.name = name
          new_meal.description = description
          new_meal.price_cents = (1000+rand*1000).round
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


puts "Start seeding"

meals = scrap_from_epicurious(1, 2, 1)


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
    new_user.latitude =place[:latitude]
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

