# Xraylib Ruby

This gem provides a [Ruby](https://www.ruby-lang.org) interface to
[xraylib](https://github.com/tschoonj/xraylib) for the interaction of
X-rays with matter, using [Fiddle](https://github.com/ruby/fiddle)
instead of [SWIG](http://www.swig.org).

## Installation

Instal [xraylib](https://github.com/tschoonj/xraylib) once you have
agreed to [the
license](https://github.com/tschoonj/xraylib/blob/master/license_all.txt).
If you’re using [Homebrew](https://brew.sh), The installation procedure
is as follows:

``` sh
brew tschoonj/tap/xraylib
```

Add this line to your application’s Gemfile:

``` ruby
gem 'xraylib'
```

And then execute:

``` sh
bundle install
```

Or install it yourself as:

``` sh
gem install xraylib
```

## Usage

``` ruby
require 'xraylib'
include Xraylib

puts "Atomic weight of C: #{atomic_weight(6)}"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run
`bundle exec rake install`. To release a new version, update the version
number in `version.rb`, and then run `bundle exec rake release`, which
will create a git tag for the version, push git commits and the created
tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/zalt50/xraylib-ruby. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected
to adhere to the [code of
conduct](https://github.com/zalt50/xraylib-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Xraylib project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/zalt50/xraylib-ruby/blob/main/CODE_OF_CONDUCT.md).

## ToDo

- Proper error handling

## Reference

- [A library for X-ray–matter interaction cross sections for X-ray
  fluorescence applications](https://doi.org/10.1016/j.sab.2004.03.014),
  Spectrochimica Acta Part B: Atomic Spectroscopy, Volume 59, Issues
  10-11, 2004, pp. 1725-1731
