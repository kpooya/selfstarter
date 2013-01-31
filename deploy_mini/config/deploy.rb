# ssh_options[:keys] = [File.join(ENV["HOME"], "linquet", "ssh", "john.pem")]
set :user,    "ec2-user"
set :ssh_key, "/Users/qiang/linquet/ssh/john.pem"
ssh_options[:keys] = ["/Users/qiang/linquet/ssh/john.pem"] 

set :application, "set your application name here"
set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


namespace :deploy do
	task :start do; end
end

task :search_libs, :hosts => ["ec2-184-73-110-240.compute-1.amazonaws.com", "ec2-54-234-87-253.compute-1.amazonaws.com"] do
  run "ls -x1 /usr/lib | grep -i xml"
end

namespace :live do
	task :restart_rails, :hosts => ["ec2-184-73-110-240.compute-1.amazonaws.com", "ec2-54-234-87-253.compute-1.amazonaws.com"] do
	  run "cd ~/selfstarter; git reset --hard HEAD^^; git checkout . ; git pull"
 	  run "/bin/bash --login ~/bin/restart_ss_production"
	end
	task :try_rails1, :hosts => ["ec2-184-73-110-240.compute-1.amazonaws.com"] do
	  run "cd ~/selfstarter; git pull"
 	  run "/bin/bash --login ~/bin/restart_ss_production"
	end
end

namespace :dev do
	task :restart_rails, :hosts => ["epoma.org"] do
		set :ssh_key, "/Users/qiang/linquet/ssh/john.pem"
		ssh_options[:keys] = ["/Users/qiang/linquet/ssh/john.pem"] 
		run "cd ~/selfstarter; git pull"
		run "/bin/bash --login ~/bin/restart_ss_production"
	end
end
