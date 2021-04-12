class TypeProductsController < ApplicationController

    def new
        
    end

    def index
        @title = 'List Type Products'
        response = ApiAccess::get_type_products(@current_user['token'])
        @type_products = response['data']
    end

    def edit
        @title = 'Edit Type Product'
        response = ApiAccess::get_type_product({id: params[:id], token: @current_user['token']})
        if !response['status']
            flash[:alert] = t('type_products.search')
            redirect_to controller: 'type_products', action: "index"
        end
        @type_product = response['data']
    end

    def show
        @title = 'Show Type Product'
        response = ApiAccess::get_type_product({id: params[:id], token: @current_user['token']})
        if !response['status']
            flash[:alert] = t('type_products.search')
            redirect_to controller: 'type_products', action: "index"
        end
        @type_product = response['data']
    end

    def create
        response = ApiAccess::create_type_product({data: params[:type_product], token: @current_user['token']})
        if response['status']
            flash[:alert] = t('type_products.save.success')
            redirect_to controller: 'type_products', action: "index"
        else
            flash[:warning] = t('type_products.save.error')
            redirect_to controller: 'type_products', action: "new"
        end
    end

    def update
        response = ApiAccess::update_type_product({id: params[:id], data: params[:type_product], token: @current_user['token']})
        if response['status']
            flash[:alert] = t('type_products.update.success')
            redirect_to controller: 'type_products', action: "index"
        else
            flash[:warning] = t('type_products.update.error')
            redirect_to controller: 'type_products', action: "edit", id: params[:id]
        end
    end
    
    def destroy
        response = ApiAccess::delete_type_product({id: params[:id], token: @current_user['token']})
        if response['status']
            flash[:alert] = t('type_products.delete.success')
        else
            flash[:warning] = t('type_products.delete.error')
        end
        redirect_to controller: 'type_products', action: "index"
    end
    
end
