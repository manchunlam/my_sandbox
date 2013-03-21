# source: http://d.hatena.ne.jp/milk1000cc/20100804/1280893810
rails_root = File.expand_path('../..', __FILE__) 
# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches
worker_processes 2
 
# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
working_directory "/home/deploy/Projects/manchunlam/rails_sandbox" # e.g. "/Users/joelam/Projects/Vitrue/tabs"
 
# listen on a Unix domain socket
# directory path_to_project/tmp/sockets must exist
listen File.expand_path('tmp/sockets/unicorn.sock', rails_root), :backlog => 64
 
# pid
# directory path_to_project/tmp/pids must exist
pid File.expand_path('tmp/pids/unicorn.pid', rails_root)
 
# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:
stderr_path File.expand_path('log/unicorn.log', rails_root)
stdout_path File.expand_path('log/unicorn.log', rails_root)
 
# combine REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true
 
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
 
  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      # SIGTTOU だと worker_processes が多いときおかしい気がする
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
 
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
