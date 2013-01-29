# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Selfstarter::Application.initialize!

# Use git commit id as asset_id, to avoid the potential problem of Rails default asset_id may not work among servers with different timestamps
git_commit_name = `git log -1 --pretty=format:"%h" 2> /dev/null `
if git_commit_name.empty?
  puts " Info: current directory is not a git repository. RAILS_ASSET_ID will not be set using git commit. "
else
  ENV['RAILS_ASSET_ID'] = git_commit_name
end




