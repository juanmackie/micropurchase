class WebAuthenticator < Struct.new(:controller, :params)
  def current_user
    if @current_user.nil?
      @current_user = User.where(id: controller.session[:user_id]).first || Guest.new
    end

    @current_user
  end

  def api_current_user
  end

  def require_authentication
    if current_user.is_a?(Guest)
      fail UnauthorizedError::RedirectToLogin
    end
  end

  def require_admin
    require_authentication
    Admins.verify_or_fail!(github_id)
  end

  def github_id
    current_user.github_id
  end

  def via
    'web'
  end
end
