json.array!(@todos) do |todo|
  json.extract! todo, :id, :description, :completed_at
  json.url todo_url(todo, format: :json)
end
