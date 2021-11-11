class ApiAccess
  include HTTParty
  debug_output $stdout
  
  def self.login(args)
    response = HTTParty.post("#{base_url}/api/v1/login",body: args.to_json ,:headers => headers(''), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.forgot_password(args)
    response = HTTParty.post("#{base_url}/api/v1/forgot/password",body: args.to_json ,:headers => headers(''), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.edit_password(args)
    response = HTTParty.put("#{base_url}/api/v1/forgot/password",body: args.to_json ,:headers => headers(''), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_clients(token)
    response = HTTParty.get("#{base_url}/api/v1/clients" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_reports(args)
    response = HTTParty.get("#{base_url}/api/v1/reports",query: {page: args[:page]} ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_type_memberships(args)
    response = HTTParty.get("#{base_url}/api/v1/type_memberships" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.get_client(args)
    response = HTTParty.get("#{base_url}/api/v1/clients/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.search_client(args)
    response = HTTParty.get("#{base_url}/api/v1/clients/search", query: {search: args[:search]} ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_client_access(args)
    response = HTTParty.get("#{base_url}/api/v1/clients/access/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.create_client(args)
    response = HTTParty.post("#{base_url}/api/v1/clients",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.create_report(args)
    response = HTTParty.post("#{base_url}/api/v1/reports",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.update_client(args)
    response = HTTParty.put("#{base_url}/api/v1/clients/#{args[:id]}",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.info_gral(token)
    response = HTTParty.get("#{base_url}/api/v1/clients/info/gral" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.get_payments(token)
    response = HTTParty.get("#{base_url}/api/v1/payments" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.get_roles(token)
    response = HTTParty.get("#{base_url}/api/v1/roles" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.get_users(token)
    response = HTTParty.get("#{base_url}/api/v1/users" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.get_user(args)
    response = HTTParty.get("#{base_url}/api/v1/users/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.create_payment(args)
    response = HTTParty.post("#{base_url}/api/v1/payments",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end
   
  def self.create_user(args)
    response = HTTParty.post("#{base_url}/api/v1/users",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.create_access(args)
    response = HTTParty.post("#{base_url}/api/v1/accesses",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.update_user(args)
    response = HTTParty.put("#{base_url}/api/v1/users/#{args[:id]}",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end


  def self.get_type_products(token)
    response = HTTParty.get("#{base_url}/api/v1/type_products" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_type_product(args)
    response = HTTParty.get("#{base_url}/api/v1/type_products/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.create_type_product(args)
    response = HTTParty.post("#{base_url}/api/v1/type_products",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.update_type_product(args)
    response = HTTParty.put("#{base_url}/api/v1/type_products/#{args[:id]}",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.delete_type_product(args)
    response = HTTParty.delete("#{base_url}/api/v1/type_products/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_products(token)
    response = HTTParty.get("#{base_url}/api/v1/products" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_product(args)
    response = HTTParty.get("#{base_url}/api/v1/products/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.create_product(args)
    response = HTTParty.post("#{base_url}/api/v1/products",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.update_product(args)
    response = HTTParty.put("#{base_url}/api/v1/products/#{args[:id]}",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.delete_product(args)
    response = HTTParty.delete("#{base_url}/api/v1/products/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
  def self.get_sales(token)
    response = HTTParty.get("#{base_url}/api/v1/sales" ,:headers => headers(token), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.get_sale(args)
    response = HTTParty.get("#{base_url}/api/v1/sales/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end

  def self.create_sales(args)
    response = HTTParty.post("#{base_url}/api/v1/sales",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
    JSON.parse(response.body)
  end
    
    

  def self.base_url
    "#{ENV['API_ACCESS']}"
  end
    
  def self.headers(token)
    {
      'Authorization' => "Bearer #{token}",
      'cache-control' => 'no-cache',
      'Content-Type'  => 'application/json',
      "User-Agent"    => "PanelAccess/2.0"
    }
  end

end