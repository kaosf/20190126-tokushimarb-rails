# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # ref. https://qiita.com/Kta-M/items/e155f6e35e3e8274ff1e

  prepend_before_action :authenticate_with_two_factor, only: [:create]

  private
  def authenticate_with_two_factor
    # strong parameters
    user_params = params.require(:user).permit(:email, :password, :remember_me, :otp_attempt)

    # ID/PASSの認証時はemailからユーザーを取得
    if user_params[:email]
      user = User.find_by(email: user_params[:email])

    # 認証コードの認証時はセッションに保存されたIDからユーザーを取得
    elsif user_params[:otp_attempt].present? && session[:otp_user_id]
      user = User.find(session[:otp_user_id])
    end
    self.resource = user

    # 2段階認証が有効なユーザーでなければ、returnして通常のDeviseの認証処理に渡す
    return unless user && user.otp_required_for_login

    # ID/PASSの認証時
    if user_params[:email]
      # パスワードを確認
      if user.valid_password?(user_params[:password])
        # ユーザーIDをセッションに保存して、認証コード入力画面をレンダリング
        session[:otp_user_id] = user.id
        render 'devise/sessions/two_factor' and return
      end
      # パスワードが違っていた場合は通常のDevise認証処理に渡す

    # 認証コードの認証時
    elsif user_params[:otp_attempt].present? && session[:otp_user_id]
      # 認証コードが合っているか確認
      if user.validate_and_consume_otp!(user_params[:otp_attempt]) || user.invalidate_otp_backup_code!(user_params[:otp_attempt])
        user.save if user.changed?
        # セッションのユーザーIDを削除して、サインイン
        session.delete(:otp_user_id)
        # 認証済みのユーザーのサインインをするDeviseのメソッド
        sign_in(user) and return
      else
        # 認証コード入力画面を再度レンダリング
        flash.now[:alert] = 'Invalid two-factor code.'
        render :two_factor and return
      end
    end
  end
end
