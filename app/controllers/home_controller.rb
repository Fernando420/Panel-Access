class HomeController < ApplicationController

    def index
        @title = 'Home'
        response = ApiAccess::info_gral(@current_user['token'])
        @data = response['data']
    end
end
