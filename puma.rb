#!/usr/bin/env puma

directory '/var/www/app/current'
rackup "/var/www/app/current/config.ru"
environment 'production'

tag ''

pidfile "/var/www/app/shared/tmp/pids/puma.pid"
state_path "/var/www/app/shared/tmp/pids/puma.state"
stdout_redirect '/var/www/app/shared/log/puma_access.log', '/var/www/app/shared/log/puma_error.log', true


threads 0,16

port 3000

# bind 'unix:///var/www/app/shared/tmp/sockets/puma.sock'

workers 0




restart_command 'bundle exec puma'


prune_bundler


on_restart do
    puts 'Refreshing Gemfile'
      ENV["BUNDLE_GEMFILE"] = ""
end
