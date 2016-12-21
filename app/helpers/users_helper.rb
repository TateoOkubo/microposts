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
  
  # プロフィールが存在するならtrue, 存在しないならnil
  def profile_exist?(user)
    @find = User.find_by(id: @user.id).profile
    if @find.eql?("") || @find == nil
      @profile_exist = nil
    else
      @profile_exist = true
    end
  end
  
  def region_exist?(user)
    @find = User.find_by(id: @user.id).region
    if @find.eql?("") || @find == nil
      @profile_exist = nil
    else
      @profile_exist = true
    end
  end
  
end