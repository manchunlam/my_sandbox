# _*_ coding: utf-8 _*_
worker_processes 1

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.

rails_root = File.expand_path('../..', __FILE__)
working_directory rails_root

# listen on a Unix domain socket
# directory path_to_project/tmp/sockets must exist
listen File.expand_path('tmp/sockets/unicorn.sock', ENV['RAILS_ROOT']), :backlog => 64

# pid
# directory path_to_project/tmp/pids must exist
pid File.expand_path('tmp/pids/unicorn.pid', ENV['RAILS_ROOT'])

# By default, the Unicorn logger will write to stderr.
# Additionally, ome applications/frameworks log to stderr or stdout,
# so prevent them from going to /dev/null when daemonized here:

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
