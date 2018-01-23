# AmazScrape

The purpose of this gem is to allow you to search for items on amazon, explore the first 10 items, allowing users to drill down and explore additional details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amaz_scrape'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install amaz_scrape

## Usage

Enter amaz_scrape in the terminal. You will be prompted to enter an item to search on amazon.
The scrape will initiate. Scraping connections may fail but will automatically reattempt after 5 seconds
If the scrape was successful, the app will print a list of up to 10 items from the search results.
The results will contain details such as: name, price, manufacturer, rating and whether it is prime able
The user will then be able to pick an item to find additional details such as: features, colors, and whether it is in stock on amazon
The user then can go back to the list to explore additional items or search a new item.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'thekevinhuang'/amaz_scrape. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AmazScrape project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'thekevinhuang'/amaz_scrape/blob/master/CODE_OF_CONDUCT.md).
