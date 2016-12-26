# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( booking/reservations.js )
Rails.application.config.assets.precompile += %w( booking/service_types.js )
Rails.application.config.assets.precompile += %w( booking/categories.js )
Rails.application.config.assets.precompile += %w( booking/customers.js )
Rails.application.config.assets.precompile += %w( booking/service_calendars.js )
Rails.application.config.assets.precompile += %w( booking/todays_bookings.js )
Rails.application.config.assets.precompile += %w( booking/service_type_reservations.js )

Rails.application.config.assets.precompile += %w( users/registrations.js )
Rails.application.config.assets.precompile += %w( users/sessions.js )
Rails.application.config.assets.precompile += %w( users/passwords.js )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
