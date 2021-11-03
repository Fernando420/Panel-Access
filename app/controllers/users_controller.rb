class UsersController < ApplicationController

  def index
    @title = t('users.list')
    response = ApiAccess::get_users(@current_user['token'])
    @users = response['data']
  end

  def new
    @title = t('users.new')
    response = ApiAccess::get_roles(@current_user['token'])
    @roles = response['data']
    @user = {}
  end

  def edit
    @title = t('users.edit')
    response = ApiAccess::get_roles(@current_user['token'])
    @roles = response['data']
    response = ApiAccess::get_user({id: params[:id] ,token: @current_user['token']})
    @user = response['data']
  end

  def show
    @title = t('users.show')
    response = ApiAccess::get_user({id: params[:id] ,token: @current_user['token']})
    @user = response['data']
  end

  def create
    response = ApiAccess::create_user({data: params[:users].except(:confirmPassword), token: @current_user['token']})
    if response['status']
      flash[:alert] = t('users.save.success')
      redirect_to controller: 'users', action: "index"
    else
      flash[:warning] = t('users.save.error')
      redirect_to controller: 'users', action: "new"
    end
  end

  def update
    response = ApiAccess::update_user({id: params[:id],data: params[:users], token: @current_user['token']})
    if response['status']
      flash[:alert] = t('users.save.success')
      redirect_to controller: 'users', action: "index"
    else
      flash[:warning] = t('users.save.error')
      redirect_to controller: 'users', action: "update", id: params[:id]
    end
  end
    
    
    
end
