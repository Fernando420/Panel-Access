class ApplicationController < ActionController::Base

  before_action :set_locale
  before_action :valid_session
  before_action :get_path

  def set_locale
    I18n.locale = params[:locale] ||= 'es'
  end

  def valid_session
    @current_user = Redis.current.get("login")
    @current_user = JSON.parse(@current_user)  if @current_user
    valid_token
    return redirect_to login_sessions_path() if !@current_user
  end

  def languajes
    @languaje = [["Eng","en"],["Esp","es"]]
  end

  def get_path
    uri = URI(request.url)
    @path = uri.path
  end

  def statuses
    @statuses = [["Inventory",'inventory'],["Sold",'sold'],["Decrease",'decrease']]
  end

  private 
    def valid_token
      flag = false
      if !@current_user.nil?
        response = ApiAccess::info_gral(@current_user['token'])
        if response['errors']
          Redis.current.del("login")
        end
      end
      return flag
    end
    

end
