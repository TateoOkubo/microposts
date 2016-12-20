module UsersHelper
  # メールアドレスからGravatarの画像用のURLを生成して
  # gravatar_urlに代入
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # image_tagメソッドで<img>タグが出力
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end