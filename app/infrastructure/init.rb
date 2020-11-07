# frozen_string_literal: true

# folders = %w[gateways database]
folders = %w[gateways]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
