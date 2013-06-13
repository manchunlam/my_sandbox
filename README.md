# Testing Rails App with Capybara

## Setup

1. `Gemfile`, add

    ```
    group :development, :test do
      gem 'capybara', '~>2.1.0'
      gem 'rspec-rails', '~>2.13.2'
      gem 'selenium-webdriver', '~>2.33.0'
      gem 'database_cleaner', '~>1.0.1'
    end
    ```

2. Generate `rspec` files

    ```
    bin/./rails g rspec:install
    ```

3. Load `capybara` in `spec_helper.rb`, and add
    ```
    require 'capybara/rails'
    require 'capybara/rspec'
    ```

## Testing Examples

All `capybara` specs should be under `spec/features`. To run the tests, do

```
bundle exec rspec spec/features
```

## Notes

1. Always use `path` helpers instead of `url` helpers.
    * The `url` helper seems to have a fixed _example.com_ domain
2. If Javascript testing is needed, you have to specify it in you spec using
`:js => true`
    1. It tells `capybara` to use `selenium-webdriver` instead of its own
    2. A headless environment must first be running for the _headless browser_
    to run

        ```
        Xvfb +extension RANDR :99 -ac &
        ```
3. When using `:js => true`, `rspec` does **not** automatically clean your test
database. Please clean it with

    ```
    it 'should destroy a user', :js => true do
      DatabaseCleaner.clean

      # start writing the test
    end
    ```

    The corresponding `rspec` config is

    ```
    RSpec.configure do |config|
      DatabaseCleaner.strategy = :truncation
    end
    ```

    For detail explanation, please see [Capybara Different Failures with :js =>
    true and without](http://stackoverflow.com/a/13234966)
