class ReportsController < ApplicationController
    
  def index
    @title = t('reports.title')
    reports
    type_report
  end

  def add_client
    @client = ApiAccess::get_client({id: params[:id], token: @current_user['token']})
    @client = @client['data']
  end

  def create
    if params[:report].present?
      params[:items] = [] unless params[:items].present?
      params[:user_id] = @current_user['user']['id']
      response = ApiAccess.create_report({data: body, token: @current_user['token']})
      flash[:alert] = 'Report precessing'
    else
      flash[:warning] = 'Select Report'
    end
    @title = t('reports.title')
    reports
    type_report
    render action: :index
  end

  private

    def body
      {
        user_id: @current_user['user']['id'],
        type_report: params[:report],
        start_date: DateTime.parse("#{params[:start_date]} 00:00:00"),
        end_date: DateTime.parse("#{params[:end_date]} 23:59:59"),
        items: params[:items],
        total_items: params[:items].count
      }
    end

    def reports
      @reports = ApiAccess::get_reports({token: @current_user['token']})
      @reports = @reports['data'] ||= []
    end
   
    def type_report
      @type_report = [
        [t('status.client_sales'), "client_sales"],
        [t('status.client_access'), "client_access"],
        [t('status.client_payments'), "client_payments"],
        [t('status.active_memberships'), "active_memberships"],
        [t('status.expired_memberships'), "expired_memberships"],
        [t('status.suspend_memberships'), "suspend_memberships"],
        [t('status.external_sales'),"external_sales"],
        [t('status.all_payments'),"all_payments"],
        [t('status.sale_products'),"sale_products"],
        [t('status.stock_products'),"stock_products"]
      ]
    end

end
