class UsersController < ApplicationController

    def index
        @title = 'List Users'
        response = ApiAccess::get_users(@current_user['token'])
        @users = response['data']
    end

    def new
        @title = 'Create User'
        response = ApiAccess::get_roles(@current_user['token'])
        @roles = response['data']
    end

    def edit
        @title = 'Edit User'
        response = ApiAccess::get_roles(@current_user['token'])
        @roles = response['data']
        response = ApiAccess::get_user({id: params[:id] ,token: @current_user['token']})
        @user = response['data']
    end

    def show
        @title = 'Show User'
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
