worker_processes ENV['UNICORN_WORKERS'] && ENV['UNICORN_WORKERS'].to_i || 3
timeout          ENV['UNICORN_TIMEOUT'] && ENV['UNICORN_TIMEOUT'].to_i || 15
preload_app      true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  if defined?(ActiveRecord::Base)
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] && ENV['DB_REAP_FREQ'].to_i || 10 # seconds
    config['pool']              = ENV['DB_POOL'] && ENV['DB_POOL'].to_i || 2

    ActiveRecord::Base.establish_connection(config)
  end
end
