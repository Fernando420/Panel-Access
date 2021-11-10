class HomeController < ApplicationController

  def index
    @title = t('common_texts.home')
    response = ApiAccess::info_gral(@current_user['token'])
    @data = response['data']
    @payments = (response['data']['last_payments'] ||= [])
  end

end
