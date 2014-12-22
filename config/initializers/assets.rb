# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( jquery.selectbox-0.2.min.js )
Rails.application.config.assets.precompile += %w( jquery.dataTables.js )
Rails.application.config.assets.precompile += %w( dataTables.colVis.js )
Rails.application.config.assets.precompile += %w( jquery.page-ui.js )
Rails.application.config.assets.precompile += %w( data_table_config.js )
Rails.application.config.assets.precompile += %w( normalize.css )
Rails.application.config.assets.precompile += %w( jquery.dataTables.css )
Rails.application.config.assets.precompile += %w( jquery.selectbox.css )
Rails.application.config.assets.precompile += %w( dataTables.colVis.css )
Rails.application.config.assets.precompile += %w( style.css.scss )
Rails.application.config.assets.precompile += %w( fonts/fonts.css )
Rails.application.config.assets.precompile += %w( style.css )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
