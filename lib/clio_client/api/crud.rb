module ClioClient
  module Api
    module Crud

      def api=(api); @api = api; end
      def api; @api; end

      def initialize(api)
        @api = api
      end

      def list(params = {})
        response = api.get(end_point_url, params)
        response[plural_resource].collect{ |r| data_item(r) }
      end

      def find(id)
        response = api.get("#{end_point_url}/#{id}")
        data_item(response[singular_resource])
      end

      def new(params = {})
        data_item(params)
      end

      def create(params = {})
        response = api.post(end_point_url, {singular_resource => params}.to_json)
        data_item( response[singular_resource])        
      end

      def update(id, params = {})
        response = api.put("#{end_point_url}/#{id}", {singular_resource => params}.to_json)
        data_item(response[singular_resource])        
      end

      def destroy(id)
        api.delete("#{end_point_url}/#{id}", false)
      end

    end
  end
end