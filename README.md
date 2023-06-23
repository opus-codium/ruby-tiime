# Tiime

This gem `tiime` is a [Tiime](https://www.tiime.fr/) API client.

Please note that an unofficial API client as _Tiime_ do not provide official API support.

## Usage

```ruby
require 'tiime'

# Companies
pp Tiime::Company.all

my_company = Tiime::Company.all.first

# Customers

pp Tiime::Customer.all(company_id: my_company.id)

# Bank accounts

pp Tiime::BankAccount.all(company_id: my_company.id)

# Bank transactions

pp Tiime::BankTransaction.all(company_id: my_company.id)

# Document

pp Tiime::Document.all(company_id: my_company.id)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/opus-codium/ruby-tiime.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/opus-codium/ruby-tiime/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Tiime project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/opus-codium/ruby-tiime/blob/main/CODE_OF_CONDUCT.md).
