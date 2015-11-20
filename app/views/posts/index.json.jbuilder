json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body
  json.url user_post_url(@user, post, format: :json)
end
