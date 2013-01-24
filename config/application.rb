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
  linquet_server_name = ENV['linquet_server']
  linquet_server_protocol = (ENV['linquet_server_protocol'] && ENV['linquet_server_protocol'].downcase) || "http"
  linquet_server_port = ENV['linquet_server_port'] || "80"

  if linquet_server_name.nil?
    require 'socket'
    if Socket.gethostname.downcase == "qiang-lin-mac.local"
      linquet_server_name = "localhost"
      linquet_server_port = "3000"
    else
      raise "Server name is not set. Use linquet_server= linquet_server_protocol= linquet_server_port="
    end
  end

  LINQUET_SERVER_URL = linquet_server_protocol + "://" +
      linquet_server_name +
      if (linquet_server_port && !(linquet_server_protocol == "https" && linquet_server_port == "443") && !(linquet_server_protocol == "http" && linquet_server_port == "80"))
        ":" + linquet_server_port
      else
        ""
      end
end

LINQUET_SERVER_URL = SetLinuqetUrl::LINQUET_SERVER_URL
