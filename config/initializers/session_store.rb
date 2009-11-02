# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_matcher_session',
  :secret      => '56d09ded8b5d1dde4250647da28ade9b41cc71cd851b33d47a62ae7a460e71dd07b760d700d3c81531817e4dee547b409b1f49ae2273670a48c72dc57afa016d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
