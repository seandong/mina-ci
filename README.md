# mina-ci
Mina recipe for checking Circle CI build status

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mina-ci', require: false
```

And then execute:

    $ bundle

## Usage

    require 'mina/rollbar'

    ...
    # replace value w/your real access token
    set :circle_token,    'your circle API token'
    set :circle_username, 'your circle project username'
    set :circle_project,  'your circle project'

    task deploy: :environment do
      deploy do
        invoke :'ci:verify_status'
        ...

        to :launch do
          ...
        end
      end
    end

## Options

| Name                         | Description                         |
| ---------------------------- | ----------------------------------- |
| `circle_token`               | CircleCI API token                  |
| `circle_username`            | CircleCI project username           |
| `circle_project`             | CircleCI project name               |

## Contributing

1. Fork it ( https://github.com/seandong/mina-ci/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request