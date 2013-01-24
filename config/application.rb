require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Selfstarter

  class Application < Rails::Application

    # --- Standard Rails Config ---
    config.time_zone = 'Pacific Time (US & Canada)'
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_record.whitelist_attributes = true
    # Enable the asset pipeline
    config.assets.enabled = true
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    # --- Standard Rails Config ---
  end
end


class SetLinuqetUrl
  rails_server_name = ENV['rails_server']
  rails_server_protocol = (ENV['rails_server_protocol'] && ENV['rails_server_protocol'].downcase) || "http"
  rails_server_port = ENV['rails_server_port'] || "80"

  if rails_server_name.nil?
    require 'socket'
    if Socket.gethostname.downcase == "qiang-lin-mac.local"
      rails_server_name = "localhost"
      rails_server_port = "3000"
    else
      raise "Server name is not set. Use rails_server= rails_server_protocol= rails_server_port="
    end
  end

  RAILS_SERVER_URL = rails_server_protocol + "://" +
      rails_server_name +
      if (rails_server_port && !(rails_server_protocol == "https" && rails_server_port == "443") && !(rails_server_protocol == "http" && rails_server_port == "80"))
        ":" + rails_server_port
      else
        ""
      end
end

LINQUET_SERVER_URL = SetLinuqetUrl::RAILS_SERVER_URL
