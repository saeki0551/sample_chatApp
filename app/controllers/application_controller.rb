class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    users_path
  end

   def after_sign_out_path_for(resource)
    root_path  #←ログアウト後の遷移先を指定
  end
end
