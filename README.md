# Twik

This gem is a ruby version of [Twik](http://gustavomondron.github.io/twik/) for Android.
It is an easy to use password generator and manager.

## Installation

Install it yourself as:

    $ gem install twik

## Usage

### CLI

```
Usage: twik [options] tag

Specific options:
    -l, --length LENGTH              length of generated password (4-26). Default: 16
    -p, --profile PROFILE            profile to use. Default: 'default'
    -t, --type TYPE                  type of password:
                                       alphanumeric_and_special_chars, alphanumeric, numeric
                                       Default: alphanumeric_and_special_chars

Common options:
    -h, --help                       Show this message
        --version                    Show version
```

Your profiles and private keys are stored in `~/.config/twik/config.yml`.

### Gem

```ruby
require 'twik'

Twik::TYPE
# => [:alphanumeric_and_special_chars, :alphanumeric, :numeric]

twik = Twik.new('PRIVATE-KEY', length: 16, type: :alphanumeric_and_special_chars)
twik.generate('tag', 'masterkey')
# => "ucf+p5TxMb0f/DE1"

twik.generate('tag', 'masterkey', length: 8, type: :numeric)
# => "91454552"
```

## Contributing

1. Fork it ( https://github.com/gdott9/twik/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
