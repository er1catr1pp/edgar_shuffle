json.posts(@posts) do |post|
  json.distribution_time post.distribution_time.strftime("%a, %b %d %I:%M %P")
  json.provider do
    json.icon_url post.distribution.account.provider.icon_url
  end
  json.account do
    json.username post.distribution.account.username
    json.avatar_url post.distribution.account.avatar_url
  end
  json.category do
    json.color post.distribution.content.category.color
    json.name post.distribution.content.category.name
  end
  json.content do
    json.text post.distribution.content.text
    json.image_url post.distribution.content.image_url
  end
end