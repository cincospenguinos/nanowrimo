# nanowrimo

[![Build Status](https://travis-ci.com/cincospenguinos/nanowrimo.svg?branch=master)](https://travis-ci.com/cincospenguinos/nanowrimo)
[![Maintainability](https://api.codeclimate.com/v1/badges/b8039b84a8ead0cf1ce6/maintainability)](https://codeclimate.com/github/cincospenguinos/nanowrimo/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/cincospenguinos/nanowrimo/badge.svg?branch=master)](https://coveralls.io/github/cincospenguinos/nanowrimo?branch=master)

Simple wrapper for NaNoWriMo's [wordcount API](https://nanowrimo.org/wordcount_api) and [writer API](https://nanowrimo.org/api/wordcount).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nanowrimo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nanowrimo

## Usage

You can use this to interact with Nanowrimo's API, through the Nanowrimo object:

```ruby
nano = Nanowrimo.new
summary = nano.site_summary
```

If you provide a username and secret key, you can update your wordcount:
```ruby
nano = Nanowrimo.new(username, secret)
nano.set_wordcount(50001)
```

You can do all of this in a block if you don't feel like having an object floating around:
```ruby
Nanowrimo.new(username, secret) do |nano|
  friend_wc = nano.summary('some_friend_i_have')[:user_wordcount]
  nano.set_wordcount(friend_wc)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/cincospenguinos/nanowrimo). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).