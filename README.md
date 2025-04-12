# Wahui Online

## Description

Wahui Online is an online gambling game based on the traditional "Wahui" betting game popular in Sabah. Players can bet on 20 different boards each round. The game provides clues in each round to aid players in their betting decisions.

## Frontend

This project utilizes **Tailwind CSS** for its frontend styling, providing a utility-first approach for rapid UI development.

## Gemfile Dependencies

The following gems are used in this Rails project:

* `rails (~> 7.2.1, >= 7.2.1.2)`: The core Ruby on Rails framework.
* `sprockets-rails`: The original asset pipeline for Rails.
* `sqlite3 (>= 1.4)`: The database used for development and testing (can be configured for other databases in production).
* `puma (>= 5.0)`: The web server used to run the Rails application.
* `importmap-rails`: Manages JavaScript dependencies using ESM import maps.
* `turbo-rails`: Provides Hotwire's SPA-like page accelerator.
* `stimulus-rails`: Provides Hotwire's modest JavaScript framework.
* `tailwindcss-rails`: Integrates Tailwind CSS into the Rails asset pipeline.
* `jbuilder`: Used for building JSON APIs.
* `tzinfo-data`: Provides timezone data for Windows and JRuby platforms.
* `bootsnap`: Speeds up boot times by caching.
* `kaminari (~> 1.2)`: A popular gem for paginating ActiveRecord/Mongoid results.

**Development and Test Dependencies:**

* `debug (platforms: %i[ mri windows ], require: "debug/prelude")`: A powerful debugger for Ruby.
* `brakeman (require: false)`: A static analysis tool for security vulnerabilities.
* `rubocop-rails-omakase (require: false)`: Enforces Omakase Ruby styling conventions.
* `web-console`: Provides an in-browser console for exceptions pages in development.
* `capybara`: A gem for system testing.
* `selenium-webdriver`: Used by Capybara for browser automation in system tests.

## Setup

To get the Wahui Online project running locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd wahui_online
    ```

2.  **Install dependencies:**
    ```bash
    bundle install
    ```

3.  **Set up the database:**
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Install JavaScript dependencies:**
    ```bash
    rails importmap:install
    yarn build:css # Or npm run build:css if you are using npm
    ```

5.  **Start the development server:**
    ```bash
    rails server
    ```

6.  **Access the application:**
    Open your web browser and navigate to `http://localhost:3000`.

## Configuration

You can configure various aspects of the application through the `config/application.rb` file and environment-specific configuration files in the `config/environments/` directory.

## Database

This project uses SQLite3 as the default database. You can configure other database systems (e.g., PostgreSQL, MySQL) by modifying the `config/database.yml` file.

## Running Tests

To run the test suite:

```bash
rails test
