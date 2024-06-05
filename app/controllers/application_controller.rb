class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ユーザがログイン後にリダイレクトされるパスを定義
  def after_sign_in_path_for(resource)
    user_path(resource) # ログイン後はユーザのプロフィールページへ
  end

  # ユーザがログアウト後にリダイレクトされるパスを定義
  def after_sign_out_path_for(resource)
    root_path # ログアウト後はトップページへ
  end

  protected

  # Deviseのストロングパラメータを設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :introduction, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :profile_image])
  end
end
