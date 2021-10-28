class ReportsController < ApplicationController
    
  def index
    @title = 'Reports'
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
    reports
    type_report
    render action: :index
  end

  private

    def body
      {
        user_id: @current_user['user']['id'],
        type_report: params[:report],
        start_date: params[:start_date],
        end_date: params[:end_date],
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
        ["Client Sales", "client_sales"],
        ["Client Access", "client_access"],
        ["Client Payments", "client_payments"],
        ["Memberships Active", "active_memberships"],
        ["Memberships Expired", "expired_memberships"],
        ["Memberships Suspend", "suspend_memberships"],
        ["External Sales","external_sales"]
      ]
    end

end
