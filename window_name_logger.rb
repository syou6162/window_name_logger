require 'bundler/setup'
require 'appscript'
require 'json'

# http://stackoverflow.com/questions/480866/get-the-title-of-the-current-active-window-document-in-mac-os-x

result = {}

result["date"] = Time.now.to_s
STDERR.puts Time.now.to_s

sleep_time=`ioreg -c IOHIDSystem | perl -ane 'if (/Idle/) {$idle=(pop @F)/1000000000; print $idle,"\n"; last}'`.to_f
exit if sleep_time > 300

frontmost = Appscript.app('System Events').application_processes.get.select{ |a| a.frontmost.get }.first

if frontmost
  result["application"] = frontmost.name.get.to_s.force_encoding("UTF-8")
  if frontmost.windows.count > 0
    window = frontmost.windows.first
    result["window_name"] = window.name.get.to_s.force_encoding("UTF-8")
  end
end

STDERR.puts Time.now.to_s
puts result.to_json
