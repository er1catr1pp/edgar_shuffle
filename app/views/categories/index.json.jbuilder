json.categories(@categories) do |category|
  json.extract! category, :id, :color, :name, :is_shuffled
  json.n_contents category.n_contents
end