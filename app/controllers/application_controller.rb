# -*- encoding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # 新しいユーザーを作成
  def generate_user!
    @_current_user = User.create
    session[:user_id] = @_current_user.id

    @_current_user
  end

  # 現在のUserを取得
  def current_user
    puts session[:user_id]

    # TwiML経由
    if params[:user_id]
      @_current_user ||= User.find(params[:user_id])

    # web経由
    else
      @_current_user = User.where(session[:user_id]).first || generate_user!
    end
  end
end
