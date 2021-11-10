class HomeController < ApplicationController

  def index
    @title = t('common_texts.home')
    response = ApiAccess::info_gral(@current_user['token'])
    @data = response['data']
  end

end
