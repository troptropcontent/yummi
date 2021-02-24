json.array! @meals do |meal|
  json.extract! meal, :id, :name, :description, :cuisine, :user_id, :price_cents, :discount
end
