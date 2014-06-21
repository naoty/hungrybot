json.favorites @favorites

json.total_count @favorites.total_count
json.offset_count @favorites.default_per_page * @favorites.current_page

if !@favorites.first_page?
  json.previous user_favorites_url(user_id: @user.name, page: @favorites.prev_page, format: :json)
end

if !@favorites.last_page?
  json.next user_favorites_url(user_id: @user.name, page: @favorites.next_page, format: :json)
end
