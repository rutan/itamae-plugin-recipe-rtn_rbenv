# Itamae::Plugin::Recipe::RtnRbenv

Installs rbenv and ruby_build.

## Installation

Add this line to your application's Gemfile:

    gem 'itamae-plugin-recipe-rtn_rbenv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-rtn_rbenv

## Usage

### install for single user

```ruby
include_recipe 'rtn_rbenv::user'
```

### install for system

```ruby
include_recipe 'rtn_rbenv::system'
```

### node.json

```json
{
    "rtn_rbenv": {
        "user": "vagrant",
        "versions": {
            "2.1.3": [
                {
                    "name": "bundler",
                    "version": "1.7.3",
                    "force": true
                },
                "sinatra"
            ],
            "2.1.0": []
        },
        "global": "2.1.3"
    }
}
```

## Contributing

1. Fork it ( https://github.com/rutan/itamae-plugin-recipe-rtn_rbenv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
