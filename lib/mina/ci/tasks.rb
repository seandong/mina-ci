require 'json'

# # Modules: CI
# Adds settings and tasks for checking CircleCI status.
#
#     require 'mina/ci'
#
# ## Settings
#
# ### circle_token
# CircleCI API access token.
#
# ### circle_username
# CircleCI username
#
# ### circle_project
# Name by which CircleCI knows your project
#

set_default :circle_token,      -> { ENV['CIRCLE_TOKEN'] }
set_default :circle_username,   -> { ENV['CIRCLE_USERNAME'] }
set_default :circle_project,    -> { ENV['CIRCLE_PROJECT'] }
set_default :circle_notify_url, -> { '' }

namespace :ci do

  desc 'Verify CircleCI build status.'
  task :verify_status => :environment do
    queue %[echo "-----> check CircleCI build status"]
    die 0, 'Please set `:circle_token`.'     unless circle_token
    die 0, 'Please set `:circle_username`.'  unless circle_username
    die 0, 'Please set `:circle_project`.'   unless circle_project

    unless success?
      notify_error
      die 0, "CircleCI build failed. current status: #{cricle_status}), please check and fix it first."
    end
  end

  private

  def circle_url
    "https://circleci.com/api/v1/project/#{circle_username}/#{circle_project}/tree/#{branch}?circle-token=#{circle_token}&limit=1"
  end

  def circle_repsonse
    JSON.parse `curl -s -H 'Accept: application/json' #{circle_url}`
  end

  def notify_error
    if circle_notify_url && circle_notify_url != ''
      `curl -d "subject=#{circle_project}(#{branch}) deploy failed." -d "message=status: #{cricle_status}" #{circle_notify_url}`
    end
  end

  def success?
    %w(success fixed).include?(cricle_status)
  end

  def cricle_status
    @cricle_status ||= begin
      response = circle_repsonse.find { |item| item['branch'] == branch }
      response.nil? ? '' : response['status']
    end
  end
end