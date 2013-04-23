# -*- coding: utf-8 -*-

require 'sinatra'
require 'yaml'
require 'open-uri'

get '/' do
  config_file = "config.yml"
  config = YAML.load(open(config_file))
  certs = [config["username"], config["password"]]

  res = open("http://#{config['host']}/index.cgi/amgr_select", "r:EUC-JP", {:http_basic_authentication => certs}).read.encode("UTF-8")

  if res.include?("PPPoE相手無応答")
    "インターネット死んでる"
  else
    "インターネット生きてる"
  end
end
