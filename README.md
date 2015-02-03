# Deployable::Log

Deployable::Log creates a singleton log instance that will be accessible
via the `log` function where ever you require `deployable/log`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deployable-log'
```

And then execute:

    $ bundle

Or install it yourself

    $ gem install deployable-log

## Usage

    require 'deplyoable/log'

    include Deployable::Log

    log.info "all the information"


## Contributing

1. Fork it ( https://github.com/deployable/deployable-log/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
