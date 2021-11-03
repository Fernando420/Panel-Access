class ProductsController < ApplicationController

  before_action :statuses, only: [:new,:edit]

  def new
    @title = t('products.new')
    response = ApiAccess::get_type_products(@current_user['token'])
    @type_products = response['data']
    @product = {}
  end

  def index
    @title = t('products.list')
    response = ApiAccess::get_products(@current_user['token'])
    @products = response['data']
  end

  def get_by_barcode
    response = ApiAccess::get_product({id: params[:id], token: @current_user['token']})
    return render json: response
  end
    

  def edit
    @title = t('products.edit')
    response = ApiAccess::get_product({id: params[:id], token: @current_user['token']})
    if !response['status']
      flash[:alert] = t('products.search')
      redirect_to controller: 'products', action: "index"
    end
    type_products = ApiAccess::get_type_products(@current_user['token'])
    @type_products = type_products['data']
    @product = response['data']
  end

  def show
    @title = t('products.show')
    response = ApiAccess::get_product({id: params[:id], token: @current_user['token']})
    if !response['status']
      flash[:alert] = t('products.search')
      redirect_to controller: 'products', action: "index"
    end
    @product = response['data']
  end

  def create
    params[:product][:user_id] = @current_user['user']['id']
    response = ApiAccess::create_product({data: params[:product], token: @current_user['token']})
    if response['status']
      flash[:alert] = t('products.save.success')
      redirect_to controller: 'products', action: "index"
    else
      flash[:warning] = t('products.save.error')
      redirect_to controller: 'products', action: "new"
    end
  end

  def update
    params[:product][:user_id] = @current_user['user']['id']
    params[:product][:type_product_id] = params['type_product_id']
    params[:product][:status] = params['status']
    response = ApiAccess::update_product({id: params[:id], data: params[:product], token: @current_user['token']})
    if response['status']
      flash[:alert] = t('products.update.success')
      redirect_to controller: 'products', action: "index"
    else
      flash[:warning] = t('products.update.error')
      redirect_to controller: 'products', action: "edit", id: params[:id]
    end
  end
    
  def destroy
    response = ApiAccess::delete_product({id: params[:id], token: @current_user['token']})
    if response['status']
      flash[:alert] = t('products.delete.success')
    else
      flash[:warning] = t('products.delete.error')
    end
    redirect_to controller: 'products', action: "index"
  end

end
