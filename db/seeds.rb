require 'open-uri'
require 'nokogiri'

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

def scrap_from_epicurious(appetizers, dinners, desserts)

cuisines =  %w(italian mediterranean european italian american greek american mexican french)
courses = %w(dinner lunch appetizer)
meals = []
  cuisines.each do |cuisine|
    courses.each do |course|
      case course
      when "appetizer"
        number_of_items = appetizers
      when "dinner"
        number_of_items = dinners
      else
        number_of_items = desserts
      end

      html_doc = scrap(epicurious_url(cuisine, course))
      html_doc.search('.recipe-content-card').first(number_of_items).each do |card|
        tag = card.search(".tag").text.strip
        name = card.search(".hed").text.strip
        url = "https://www.epicurious.com#{card.search('a').attribute('href').value}"
        show =  scrap(url)
        description = show.search(".dek").text.strip
        photo = show.search(".photo-wrap").search("img").attribute("srcset")
  
        if tag == "recipe" && description.length > 0
          
          meals << {
          cuisine: cuisine,
          course: course,
          name: name,
          url: url,
          description: description,
          photo: photo }
        end
      end
    end
  end
  puts meals
end

def epicurious_url(cuisine, course)
  return "https://www.epicurious.com/search/?cuisine=#{cuisine}&meal=#{course}"
end

def scrap(url)
  html_file = open(url).read
  return html_doc = Nokogiri::HTML(html_file) 
end

