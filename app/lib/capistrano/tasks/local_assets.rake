namespace :local_assets do
  desc 'Precompile assets locally and then rsync to web servers'
  task :precompile do
    sh "RAILS_ENV=production bundle exec rails assets:precompile"

    on roles(:app), in: :parallel do |server|
        run_locally do
          # TODO fetch(:user) not working
          execute :rsync,
            "-a --delete ./public/packs/ deploy@#{server.hostname}:#{shared_path}/public/packs/"
        end
    end

    run_locally do
      execute :rm, '-rf public/packs'
    end
  end
end
