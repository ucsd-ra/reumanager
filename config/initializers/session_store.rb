# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key => '_nsfreu_surf_session',
  :secret      => '53ca2459877f2d24ff9b68a6cf18f2d24ff9b3ff9b6818919754124dfsff9bea6cf95f34095dfc5891df6ffe9f8d9d277bfb8d33ccffdeaf72ebcf9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store