class ApiAccess
    include HTTParty
    debug_output $stdout
  
    def self.login(args)
        response = HTTParty.post("#{base_url}/api/v1/login",body: args.to_json ,:headers => headers(''), :debug_output => $stdout)
        JSON.parse(response.body)
    end

    def self.get_clients(token)
        response = HTTParty.get("#{base_url}/api/v1/clients" ,:headers => headers(token), :debug_output => $stdout)
        JSON.parse(response.body)
    end
    
    def self.get_client(args)
        response = HTTParty.get("#{base_url}/api/v1/clients/#{args[:id]}" ,:headers => headers(args[:token]), :debug_output => $stdout)
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

    def self.update_user(args)
        response = HTTParty.put("#{base_url}/api/v1/users/#{args[:id]}",body: args[:data].to_json ,:headers => headers(args[:token]), :debug_output => $stdout)
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