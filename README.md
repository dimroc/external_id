# ExternalId

Generates an external id to mask the counts of records inherent with auto-increment ids. Depends on ActiveRecord, and the id is created at time of persistence.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'external_id'
```

## Usage

1. Create a column called `external_id` of type string with an index, usually via AR migration.

    ```ruby
    class SomeMigration
      add_column :my_classes, :external_id, :string, unique: true
    end
    ```

2. Add the following lines to your class: `include ExternalId; external_id prefix: "X"`
3. Done.

The column name and the length of the id can be customized:

```ruby
external_id :different_id, bytes: 6
```

Works extremely well alongside [`friendly_id`](https://github.com/norman/friendly_id):

```ruby
class MyRecord < ApplicationRecord
  extend FriendlyId
  include ExternalId

  external_id prefix: "B"
  friendly_id :external_id

  ...
end

# Can now be used as such:

MyRecord.friendly.find("B123456")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Dimitri Roche/external_id.

