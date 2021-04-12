class ClientsController < ApplicationController

    def index
        @title = 'List Clients'
        response = ApiAccess::get_clients(@current_user['token'])
        @clients = response['data']
    end

    def new
        @title = 'New Client'
    end

    def create
        response = ApiAccess::create_client({data: params[:clients], token: @current_user['token']})
        if response['status']
            flash[:alert] = t('client.save.success')
            redirect_to controller: 'clients', action: "index"
        else
            flash[:warning] = t('client.save.error')
            redirect_to controller: 'clients', action: "new"
        end
    end

    def access
        @title = 'Access Client'
        if params[:clients] && params[:clients][:member_id]
            @access = ApiAccess::get_client_access({id: params[:clients][:member_id], token: @current_user['token']})
            if @access['data'].nil?
                flash[:warning] = t('client.not_found')
                @access = nil
            else
                @access = @access['data']
            end
        else
            @access = nil
        end
    end

    def create_access
        response = ApiAccess::create_access({data: {client_id:params[:id], user_id: @current_user['user']['id'] }, token: @current_user['token']})
        return render json: response
    end

end
