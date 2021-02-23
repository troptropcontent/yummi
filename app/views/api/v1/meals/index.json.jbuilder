json.array! @meals do |meal|
  json.extract! meal, :id, :name, :description, :speciality, :user_id, :price_cents, :discount
end
