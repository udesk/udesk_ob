module UdeskOb
  module RestClientHeader
    def default_headers
      headers = super
      trace_id = UdeskOb::Log.trace_id
      if headers.is_a?(Hash) && trace_id
        headers[UdeskOb::Log::HTTP_HEADER] = trace_id
      end
      headers
    end
  end
end

RestClient::Request.prepend(UdeskOb::RestClientHeader)
