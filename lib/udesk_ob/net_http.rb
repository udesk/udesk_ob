module UdeskOb
  module HTTPRequest
    def initialize(path, initheader = nil)
      trace_id = UdeskOb::Log.trace_id
      if trace_id
        initheader ||= {}
        initheader[UdeskOb::Log::HTTP_HEADER] = trace_id
      end
      super
    end
  end
end

Net::HTTPRequest.prepend(UdeskOb::HTTPRequest)
