# ssh_options[:keys] = [File.join(ENV["HOME"], "linquet", "ssh", "john.pem")]
set :user,    "ec2-user"
set :ssh_key, "/Users/qiang/linquet/ssh/john.pem"
ssh_options[:keys] = ["/Users/qiang/linquet/ssh/john.pem"] 

set :application, "set your application name here"
set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ec2-184-73-110-240.compute-1.amazonaws.com"
role :web, "ec2-54-234-87-253.compute-1.amazonaws.com"
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

task :sleep_5_seconds do
	sleep 5
end

namespace :live do
	task :restart_rails, :hosts => ["ec2-184-73-110-240.compute-1.amazonaws.com", "ec2-54-234-87-253.compute-1.amazonaws.com"] do
	  # run "cd ~/selfstarter; git reset --hard HEAD^^; git checkout . ; git pull"
 	  # run "/bin/bash --login -c ~/bin/restart_ss_production"
 	  run "~/bin/restart_ss_production"
	end

	task :git_pull, :hosts => ["ec2-184-73-110-240.compute-1.amazonaws.com", "ec2-54-234-87-253.compute-1.amazonaws.com"] do
	  run "cd ~/selfstarter; git checkout .; git pull; git log -1 --name-status"
	end

	task :git_back_30, :hosts => ["ec2-184-73-110-240.compute-1.amazonaws.com", "ec2-54-234-87-253.compute-1.amazonaws.com"] do
	  run "cd ~/selfstarter; git reset --hard HEAD~30; git checkout ."
	end

	task :smoke do
	  # system("until curl https://linquet.com/mini/ > /dev/null ; do  echo "Sleep one second" ; sleep 1 ; done ;")
	  # 8 is the number of links in links.txt
	  system("siege --concurrent=3 --delay=0 --reps=8 --verbose -f cap_files/links.txt")
	end

	desc "tail production log files" 
	task :tail_logs, :roles => :web do
	  run "tail -f ~/selfstarter/log/production.log" do |channel, stream, data|
	    puts  # for an extra line break before the host name
	    puts "#{channel[:host]}: #{data}" 
	    break if stream == :err    
	  end
	end

	task :all do
	  live.git_pull 
	  live.restart_rails 
	  sleep_5_seconds 
	  live.smoke
	end

	task :bundle_install, :hosts => ["ec2-184-73-110-240.compute-1.amazonaws.com", "ec2-54-234-87-253.compute-1.amazonaws.com"] do
	  run "cd ~/selfstarter; rvm info; rvm gemset use ss; rvm info;"
	end

	task :try_rails1, :hosts => ["ec2-184-73-110-240.compute-1.amazonaws.com"] do
	  run "cd ~/selfstarter; git pull"
 	  run "/bin/bash --login ~/bin/restart_ss_production"
	end
end

namespace :dev do
	task :restart_rails, :hosts => ["epoma.org"] do
		run "cd ~/selfstarter; git pull"
		run "~/bin/restart_ss_development"
	end
end
