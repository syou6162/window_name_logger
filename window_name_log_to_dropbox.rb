#!/usr/bin/env ruby
# coding: utf-8
require 'dropbox-api'

Dropbox::API::Config.app_key = ENV["DROPBOX_APP_KEY"]
Dropbox::API::Config.app_secret = ENV["DROPBOX_APP_SECRET"]
Dropbox::API::Config.mode = "dropbox"

@client = Dropbox::API::Client.new(:token  => ENV["DROPBOX_TOKEN"], :secret => ENV["DROPBOX_SECRET"])

filename = ARGV[0]
puts @client.upload "window_name_log/#{filename}", File.open(filename).read
