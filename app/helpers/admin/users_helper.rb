module Admin::UsersHelper
  # 引数で与えられたuserデータからidを取り出し、
  # 取り出したidでログイン状態を作ってる
  def log_in(user)
    session[:user_id]= user.id
  end

  # logged_in?が実行されたら、current_userメソッドを実行
  # メソッド？が実行されたら、データがあったらtrue or 
  # データなかったらfalseを返している
  def logged_in?
    current_user.present?
  end
    
  def admin?
    current_user.admin
  end

  # 既にsessionにデータが作られてたら
  # sessionのデータを使ってDBから
  # sessionに一致してるuserデータを探してる
  # 探したuserデータを、変数"current_user"に代入
  # current_userのデータを返す(ログインした人にしかできない処理をしたいから)
  # ログインしてなかったらデータnilを返す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # 作ったものを作った人にしかアクセスさせたくないから、
  # 使ってる(id)
  # user id2 = id1
  def current_user?(user)
    user == current_user
  end
  

end
