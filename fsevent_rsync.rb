# source: http://pastebin.com/viMSaRh3
# Invoke rsync when there are changes in the current directory

require 'rb-fsevent'
require 'open3'

include Open3

options = { :latency => 2 }

rsync = 'rsync -avzic -e ssh --delete --include-from ".rsynckeep" ' \
  '--exclude-from ".rsyncignore" . ' \
  'deploy@joelam.dev.cloud.vitrue.com:/home/deploy/Projects/manchunlam/rails_sandbox/'

fsevent = FSEvent.new

fsevent.watch Dir.pwd, options do |directories|
  puts "Detected change inside: #{directories.inspect}"
  popen3(rsync) do |stdin, stdout, stderr|
    stdout.read.split("\n").map { |line|
      puts "rsync: #{line}"
    }
  end
end

fsevent.run
