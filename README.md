# Shiori

## Installation

Gemfile.

```ruby
gem 'shiori', git: "git://github.com/tkyshm/shiori.git"
```

## Usage

```ruby
shiori = Shiori::save_image "http://example.com/example.jpg", "~/Pictures"

shiori.resize 400, 200

shiori.resize_to_fill 300

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tkyshm/shiori.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

