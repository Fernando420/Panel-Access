class PaymentsController < ApplicationController

    def new
        @title = 'Create Payment'
    end

    def index
        @title = 'List Payments'
        response = ApiAccess::get_payments(@current_user['token'])
        @payments = response['data']
    end

    def create
        params[:payments][:user_id] = @current_user['user']['id']
        client = ApiAccess::get_client({id: params[:payments][:member_id], token: @current_user['token']})
        if !client['data'].nil?
            params[:payments][:client_id] = client['data']['id']
            response = ApiAccess::create_payment({data: params[:payments], token: @current_user['token']})
            if response['status']
                flash[:alert] = t('payment.save.success')
                redirect_to controller: 'payments', action: "index"
            else
                flash[:warning] = t('payment.save.error')
                redirect_to controller: 'payments', action: "new"
            end
        else
            flash[:warning] = t('client.not_found')
            redirect_to controller: 'payments', action: "new"
        end
    end
    
    
end
