json.array! @messages do |message|  # array!メソッドについて　https://qiita.com/ryouzi/items/06cb0d4aa7b6527b3645
  json.content message.content
  json.image message.image.url
  json.created_at message.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.user_name message.user.name
  json.id message.id
end
