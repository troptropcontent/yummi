json.extract! @meal, :id, :name, :description, :speciality, :user_id, :price_cents, :discount
json.reviews @meal.reviews do |review|
  json.extract! review, :id, :rating, :content
end
