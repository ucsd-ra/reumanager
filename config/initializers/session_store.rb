# Be sure to restart your server when you modify this file.

Reuman::Application.config.session_store :cookie_store, key: '_reuman_session', domain: {
  production: '.reumanager.com',
  development: '.lvh.me'
}.fetch(Rails.env.to_sym, :all)

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Reuman::Application.config.session_store :active_record_store
