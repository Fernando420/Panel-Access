class SalesController < ApplicationController

    def index
        @title = 'List Sales'
        response = ApiAccess::get_sales(@current_user['token'])
        @sales = response['data']
    end

    def show
        @title = 'Show Sale'
        response = ApiAccess::get_sale({id: params[:id], token: @current_user['token']})
        if !response['status']
            flash[:alert] = t('sales.search')
            redirect_to controller: 'sales', action: "index"
        end
        @sale = response['data']
    end

    def create
        json = {
            user_id: @current_user['user']['id'],
            buyer: "",
            email_buyer: "",
            total: params[:sale][:amount_total],
            total_products: JSON.parse(params[:sale][:items]).count,
            products: JSON.parse(params[:sale][:items])
        }
        if params[:sale][:member_id].empty?
            json[:buyer] = @current_user['user']['id']
            json[:email_buyer] = @current_user['user']['email']
            response = ApiAccess::create_sales({token: @current_user['token'], data: json})
        else
            client = ApiAccess::get_client({id: params[:sale][:member_id], token: @current_user['token']})
            if !client['data'].nil?
                json[:buyer] = client['data']['member_id']
                json[:email_buyer] = client['data']['email']
                response = ApiAccess::create_sales({token: @current_user['token'], data: json})
            else
                response = {code: 400, message: "Member Not found"}
            end
        end
        return render json: response
    end
end
