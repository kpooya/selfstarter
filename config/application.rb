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
  front_server_protocol = (ENV['front_server_protocol'] && ENV['front_server_protocol'].downcase) || "http"
  front_server_name = ENV['front_server_name']
  front_server_port = ENV['front_server_port'] || "80"

  if front_server_name.nil?
    require 'socket'
    if Socket.gethostname.downcase == "qiang-lin-mac.local"
      front_server_name = "localhost"
      front_server_port = "3000"
    else
      raise "Server name is not set. Use export front_server= ; export front_server_protocol= ; export front_server_port=;"
    end
  end

  FRONT_SERVER_URL = front_server_protocol + "://" +
      front_server_name +
      if (front_server_port && !(front_server_protocol == "https" && front_server_port == "443") && !(front_server_protocol == "http" && front_server_port == "80"))
        ":" + front_server_port
      else
        ""
      end
end

LINQUET_SERVER_URL = SetLinuqetUrl::FRONT_SERVER_URL

class SubPath
  if ENV["RAILS_RELATIVE_ROOT"]
    ROOT = ENV["RAILS_RELATIVE_ROOT"]
    def self.getAbsolutePath(path)
      ROOT + path
    end
  else
    def self.getAbsolutePath(path)
      path
    end
  end

  def self.getUrl(path)
    LINQUET_SERVER_URL + getAbsolutePath(path)
  end
end



