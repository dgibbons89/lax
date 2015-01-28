json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :instructor, :name, :url
  json.url lesson_url(lesson, format: :json)
end
