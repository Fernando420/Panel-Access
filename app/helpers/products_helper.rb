module ProductsHelper

    def getStatus(status)

        case status.to_i
        when 0
            return 'Inactivo'
        when 1
            return 'Activo'
        end
        
    end

    def getSelled?(status)

        case status
        when true
            return 'Vendido'
        when false
            return 'En Stock'
        end
        
    end
    
end
