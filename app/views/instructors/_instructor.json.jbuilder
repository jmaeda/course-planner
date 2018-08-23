json.extract! instructor, :id, :first, :last, :email, :created_at, :updated_at
json.url instructor_url(instructor, format: :json)
