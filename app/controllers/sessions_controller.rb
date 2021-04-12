class SessionsController < ApplicationController

    before_action :languajes

    skip_before_action :valid_session, except: [:logout]

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
