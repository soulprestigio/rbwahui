# Wahui Online Blueprint

## Project Overview

Wahui Online is a digital version of the traditional Sabahan gambling game "Wahui." It allows players to place bets on 20 different boards each round, with clues provided to help them make informed decisions. The project is built with Ruby on Rails and utilizes modern web technologies like Tailwind CSS and Hotwire for a responsive and interactive user experience.

## Core Features

The application revolves around the following key features:

*   **Homepage:** A landing page that introduces the game and provides access to the main features.
*   **Boards:** The main game interface where players can view the 20 boards and place their bets.
*   **Synonyms:** A feature that provides clues to players, likely by showing synonyms or related words to the winning board.
*   **Wahuiboards:** This appears to be a central model for the game, likely managing the state of the boards and the game rounds.
*   **User Management:** A complete system for user registration and authentication using the Devise gem.
*   **Wallet System:** Users have a personal wallet to manage their funds. They can deposit money into their wallet using the ToyyibPay payment gateway.

## Wallet System & ToyyibPay Integration

The wallet system allows users to add funds to their account to place bets. The implementation uses the ToyyibPay payment gateway.

*   **Deposit Flow:**
    1.  The user navigates to their wallet and initiates a deposit.
    2.  They are redirected to the ToyyibPay website to complete the payment.
    3.  Upon completion, ToyyibPay sends a webhook to the application to confirm the payment status.
*   **Controllers:**
    *   `WalletsController`: Displays the user's wallet balance.
    *   `WalletDepositsController`: Handles the creation of a deposit and redirects the user to ToyyibPay.
    *   `ToyyibpayWebhooksController`: Receives and processes webhooks from ToyyibPay to update wallet balances.

## Technologies

The project is built on a solid foundation of modern web technologies:

*   **Backend:** Ruby on Rails 7.2.1
*   **Payment Gateway Integration:** `httparty` is used to communicate with the ToyyibPay API.
*   **Frontend:**
    *   Tailwind CSS for styling
    *   Hotwire (Turbo and Stimulus) for a reactive user interface
    *   Importmap for JavaScript dependency management
*   **Database:** SQLite3 in development, with the flexibility to use other databases like PostgreSQL or MySQL in production.
*   **Web Server:** Puma
*   **Testing:**
    *   Minitest for unit and integration tests
    *   Capybara and Selenium for system tests
*   **Code Quality:**
    *   Brakeman for static security analysis
    *   Rubocop for code style enforcement

## Database Schema

Based on the models and migrations, the database schema likely includes the following tables:

*   **boards:** Represents the 20 betting boards in the game. It probably has fields for the board's name, image, and other attributes.
*   **synonyms:** Stores the clues for each round, with a likely association to the `wahuiboards` table.
*   **wahuiboards:** The central table that manages the game rounds, including the winning board and the clues for that round.
*   **users:** Stores user information for authentication.
*   **wallets:** Stores the balance for each user. Each user `has_one` wallet.
*   **transactions:** Records all financial transactions (deposits, withdrawals, bets) associated with a wallet.

## Routes

The application's routes are defined in `config/routes.rb` and include the following:

*   `root "homepage#index"`: The homepage of the application.
*   `devise_for :users`: User authentication routes.
*   `resource :wallet, only: [:show]`: Displays the user's wallet.
*   `resources :wallet_deposits, only: [:new, :create]`: Routes for creating a new deposit.
*   `post 'toyyibpay/webhook', to: 'toyyibpay_webhooks#create'`: Endpoint for receiving ToyyibPay webhooks.
*   `resources :boards`: Provides the standard RESTful routes for the `Board` model.
*   `resources :synonyms`: Provides the standard RESTful routes for the `Synonym` model.
*   `resources :wahuiboards`: Provides the standard RESTful routes for the `Wahuiboard` model.
*   `get "up" => "rails/health#show"`: A health check endpoint.
*   PWA-related routes for the service worker and manifest.

## Environment Variables

To connect to the ToyyibPay payment gateway, the following environment variables must be set:

*   `TOYYIBPAY_USER_SECRET_KEY`: Your ToyyibPay user secret key.
*   `TOYYIBPAY_CATEGORY_CODE`: The ToyyibPay category code for the bills.

## Setup

To get the project running locally, follow these steps:

1.  Clone the repository.
2.  Install the required gems: `bundle install`
3.  Create and migrate the database: `rails db:create && rails db:migrate`
4.  Set the required environment variables (see above).
5.  Install JavaScript dependencies: `rails importmap:install`
6.  Build the CSS: `yarn build:css` (or `npm run build:css`)
7.  Start the development server: `rails server`

## Testing

To run the test suite, execute the following command:

```bash
rails test
```