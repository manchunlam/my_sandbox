# Testing Rails App with Capybara

## Setup

1. `Gemfile`, add

    ```
    group :development, :test do
      gem 'capybara', '~>2.1.0'
      gem 'rspec-rails', '~>2.13.2'
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


