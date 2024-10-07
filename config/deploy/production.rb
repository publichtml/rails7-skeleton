set :repo_url, "https://github.com/publichtml/rails7-samson-sample-client"
set :application, "rails7-samson-sample-client"

server "localhost", user: "root", roles: %w{app db web}

server "localhost",
  user: "root",
  roles: %w{web app db},
  ssh_options: {
    # user: "user_name", # overrides user setting above
    # keys: %w(/home/user_name/.ssh/id_rsa),
    # forward_agent: false,
    # auth_methods: %w(publickey password)
    password: "screencast",
    port: 5000
  }

set :branch, "capistrano3-puma"
set :production
set :deploy_to, "/var/www/app"
set :puma_service_unit_name, 'puma'
# NOTE: capistrano は non-login shell を使うので、
#       必要な環境変数は capistrano 側で指定する必要がある
set :default_env, {
  RAILS_ENV: :production,
}

append :linked_files, ".env", "config/database.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
