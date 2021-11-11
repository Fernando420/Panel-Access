class SessionsController < ApplicationController

  before_action :languajes
  skip_before_action :valid_session, except: [:logout]

  def new
      
  end

  def forgot_password
    
  end

  def email_forgot_pwd
    response = ApiAccess::forgot_password(params[:sessions])
    if response['status']
      flash[:alert] = response['data']
      redirect_to controller: 'sessions', action: "edit_password"
    else
      flash[:warning] = response['message']
      redirect_to controller: 'sessions', action: "forgot_password"
    end
  end

  def edit_password

  end

  def update_password
    params[:sessions][:pin] = "#{params[:sessions][:code_1]}#{params[:sessions][:code_2]}#{params[:sessions][:code_3]}#{params[:sessions][:code_4]}#{params[:sessions][:code_5]}#{params[:sessions][:code_6]}"
    response = ApiAccess::edit_password(params[:sessions])
    if response['status']
      flash[:alert] = response['data']
      redirect_to controller: 'sessions', action: "new"
    else
      flash[:warning] = response['message']
      redirect_to controller: 'sessions', action: "edit_password"
    end
  end

  def create
    response = ApiAccess::login(params[:sessions])
    if response['status']
      cookies[:token] = response['data']['token']
      Redis.current.set("login-#{response['data']['token']}",response['data'].to_json)
      redirect_to controller: 'home', action: "index"
    else
      flash[:warning] = response['message']
      redirect_to controller: 'sessions', action: "new"
    end
  end

  def logout
    Redis.current.del("login-#{cookies[:token]}")
    cookies[:token] = nil
    redirect_to controller: 'sessions', action: "new"
  end

end
