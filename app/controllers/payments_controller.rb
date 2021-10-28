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
    response = ApiAccess::create_payment({data: format_body, token: @current_user['token']})
    if response['status']
      flash[:alert] = t('payment.save.success')
      redirect_to controller: 'payments', action: "index"
    else
      flash[:warning] = t('payment.save.error')
      redirect_to controller: 'payments', action: "new"
    end
  end

  def add_client
    @client = ApiAccess::get_client({id: params[:id], token: @current_user['token']})
    @client = @client['data']
  end

  private

    def format_body
      {
        client_id: params[:payments][:client_search],
        extra_charge: params[:payments][:extra_charge]
      }
    end
    
    
end
