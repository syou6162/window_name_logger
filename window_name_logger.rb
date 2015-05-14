require 'bundler/setup'
require 'appscript'
require 'json'

# http://stackoverflow.com/questions/480866/get-the-title-of-the-current-active-window-document-in-mac-os-x

frontmost = Appscript.app('System Events').application_processes.get.select{ |a| a.frontmost.get }.first
result = {}

result["date"] = Time.now.to_s

if frontmost
  result["application"] = frontmost.name.get.to_s
  if frontmost.windows.count > 0
    window = frontmost.windows.first
    result["window_name"] = window.name.get.to_s
  end
end

puts result.to_json
