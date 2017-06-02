# frozen_string_literal: true

# Library for simple HTTP get and post requests
class Request
  @logger = nil

  class << self
    # @return [String]
    def fetch(url, method = :get, params = {})
      uri = URI(url)
      http = Net::HTTP.new(uri.host, 80)
      http.set_debug_output(@logger) if @logger
      request = method == :get ? get(uri) : post(uri, params)
      request['User-Agent'] = ua
      r = http.request(request)
      r.body
    end

    private

    # @return [Net::HTTP::Get]
    def get(uri)
      Net::HTTP::Get.new(uri.request_uri)
    end

    # @return [Net::HTTP::Post.]
    def post(uri, params)
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(params)
      request
    end

    # @return [String]
    def ua
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko)' \
        ' Chrome/58.0.3029.110 Safari/537.36'
    end
  end
end
