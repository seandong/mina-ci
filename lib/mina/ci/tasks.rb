require 'json'
require 'mina/rails'

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

set_default :circle_token,     nil
set_default :circle_username,  nil
set_default :circle_project,   nil

namespace :ci do

  desc 'Verify CircleCI building status.'
  task :verify_status => :evironment do
    queue %[echo "-----> check CircleCI status"]
    die 0, 'Please set your `:circle_token`.'    unless circle_token
    die 0, 'Please set your `:circle_username`.' unless circle_username
    die 0, 'Please set your `:circle_project`.'  unless circle_project

    unless %w(success fixed).include?(cricle_status)
      die 1, "CircleCI not passed (#{cricle_status}), please check and fix problem first."
    end
  end

  private

  def circle_url
    "https://circleci.com/api/v1/project/#{circle_username}/#{circle_project}?circle-token=#{circle_token}"
  end

  def circle_repsonse
    JSON.parse `curl -H 'Accept: application/json' #{circle_url}`
  end

  def cricle_status
    @cricle_status ||= begin
      response = circle_repsonse.find { |item| item['branch'] == branch }
      response.nil? ? '' : response['status']
    end
  end
end