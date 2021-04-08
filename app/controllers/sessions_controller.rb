class SessionsController < ApplicationController

    before_action :languajes

    def new
        
    end

    def create
        response = ApiAccess::login(params[:sessions])
        if response['status']
            Redis.current.set("login",response['data'].to_json)
            redirect_to controller: 'home', action: "index"
        else
            flash[:warning] = response['message']
            redirect_to controller: 'sessions', action: "new"
        end
    end

    def logout
        Redis.current.del("login")
        redirect_to controller: 'sessions', action: "new"
    end
end
