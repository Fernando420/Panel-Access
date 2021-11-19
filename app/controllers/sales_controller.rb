class SalesController < ApplicationController

  def index
    @title = t('sales.list')
    response = ApiAccess::get_sales(@current_user['token'])
    @sales = response['data']
  end

  def show
    @title = t('sales.show')
    response = ApiAccess::get_sale({id: params[:id], token: @current_user['token']})
    if !response['status']
      flash[:alert] = t('sales.search')
      redirect_to controller: 'sales', action: "index"
    end
    @sale = response['data']
  end

  def new
    @title = t('sales.new')
  end

  def download_ticket
    response = ApiAccess::get_sale({id: params[:id], token: @current_user['token']})
    sale = response['data']
    respond_to do |format|
      format.pdf do
        pdf = CreatePdf::Ticket.new(sale,@current_user['user'])
        send_data pdf.render,
          filename: "ticket.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end

  def create
    json = {
      user_id: @current_user['user']['id'],
      total: params[:sale][:amount_total],
      total_products: JSON.parse(params[:sale][:items]).count,
      products: JSON.parse(params[:sale][:items])
    }
    if params[:sale][:member_id].empty?
      response = ApiAccess::create_sales({token: @current_user['token'], data: json})
    else
      client = ApiAccess::get_client({id: params[:sale][:member_id], token: @current_user['token']})
      if client['data'].present?
        json[:client_id] = client['data']['id']
        response = ApiAccess::create_sales({token: @current_user['token'], data: json})
      else
        response = {code: 400, message: "Member Not found"}
      end
    end
    return render json: response
  end
end
