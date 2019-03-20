require 'singleton'
require 'securerandom'
require 'json'

require 'redis'

require 'udesk_ob/config'
require 'udesk_ob/message_queue'
require 'udesk_ob/log'
require 'udesk_ob/railties' if defined? Rails
require 'udesk_ob/rest_client' if defined? RestClient
require 'udesk_ob/net_http' if defined? Net::HTTPRequest
require 'udesk_ob/sidekiq' if defined? Sidekiq
