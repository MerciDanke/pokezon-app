# frozen_string_literal: true

require 'roda'
require 'yaml'
require 'econfig'

module MerciDanke
  # Configuration for the App
  class App < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    configure :development, :test do
      ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
    end

    configure :production do
      # Set DATABASE_URL environment variable on production platform
    end

    configure do
      require 'sequel'
      DataBase = Sequel.connect(ENV['DATABASE_URL'])

      def self.DataBase # rubocop:disable Naming/MethodName
        DataBase
      end
    end
  end
end
