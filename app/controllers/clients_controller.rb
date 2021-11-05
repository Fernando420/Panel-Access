class ClientsController < ApplicationController

  def index
    @title = t('client.list')
    response = ApiAccess::get_clients(@current_user['token'])
    @clients = response['data']
  end

  def new
    @title = t('client.new')
    @client = {'memberships' => []}
    type_memberships
  end

  def show
    @title = t('client.show')
    client = ApiAccess::get_client({id: params[:id], token: @current_user['token']})
    if !client['data'].nil?
      @client = client['data']
    else
      flash[:alert] = t('client.search')
      redirect_to controller: 'clients', action: "index"
    end
  end

  def search_autocomplete
    search = params[:term]
    response = ApiAccess::search_client({search: params[:term], token: @current_user['token']})
    @clients = response['data']
    if params[:payments]
      data = @clients.collect{|c| {label: "#{c['name']} #{c['last_name']}", value: c['member_id']}}
    else
      data = @clients.collect{|c| {label: "#{c['name']} #{c['last_name']}", value: c['id']}}
    end
    render :json => data, root: 'data'
  end

  def edit
    type_memberships
    @title = t('client.edit')
    client = ApiAccess::get_client({id: params[:id], token: @current_user['token']})
    if !client['data'].nil?
        @client = client['data']
    else
        flash[:alert] = t('client.search')
        redirect_to controller: 'clients', action: "index"
    end
  end

  def create
    response = ApiAccess::create_client({data: format_body, token: @current_user['token']})
    if response['status']
      flash[:alert] = t('client.save.success')
      redirect_to controller: 'clients', action: "index"
    else
      flash[:warning] = t('client.save.error')
      redirect_to controller: 'clients', action: "new"
    end
  end

  def update
    response = ApiAccess::update_client({id: params[:id], data: format_body, token: @current_user['token']})
    if response['status']
      flash[:alert] = t('client.save.success')
      redirect_to controller: 'clients', action: "index"
    else
      flash[:warning] = t('client.save.error')
      redirect_to controller: 'clients', action: "new"
    end
  end

  def access
    @title = t('client.access.title')
    if params[:clients] && params[:clients][:member_id]
      @access = ApiAccess::get_client_access({id: params[:clients][:member_id], token: @current_user['token']})
      if @access['data'].nil?
        flash[:warning] = @access['message'] ||= t('client.not_found')
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

  private

    def format_body
      {
        name: params[:clients][:name],
        gym_id: @current_user['user']['gym']['id'],
        last_name: params[:clients][:last_name],
        phone: params[:clients][:phone],
        email: params[:clients][:email],
        birthday: params[:clients][:birthday],
        member_id: params[:clients][:member_id],
        password: params[:clients][:password],
        password_confirmation: params[:clients][:confirmPassword],
        age: params[:clients][:age],
        address: params[:clients][:address],
        display_name: "#{params[:clients][:name]} #{params[:clients][:last_name]}",
        picture: params[:clients][:picture],
        membership: {
          id: params[:clients][:membership_id],
          type_membership_id: params[:clients][:type_membership_id],
          description: params[:clients][:description],
          price: params[:clients][:price],
          offert: params[:clients][:offert],
          type_payment: params[:clients][:type_payment],
          extra_charge: params[:clients][:extra_charge]
        }
      }
    end

    def type_memberships
      response = ApiAccess.get_type_memberships({token: @current_user['token']})
      @type_memberships = response['data']
      unless response['data']
        @type_memberships = []
      end
    end

end
