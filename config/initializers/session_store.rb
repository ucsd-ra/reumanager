# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key => '_nsfreu_session',
  :secret      => '9e4b55560c0e8d28b3ca245987755dbf2d249b68a6cf18391cc3fe52d9754f8607be95f34095dfc5891df6ffe9f8d9d277bfb8d33ccffdeaf72ebcf9f736d289'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store