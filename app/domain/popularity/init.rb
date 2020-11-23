# frozen_string_literal: true

folders = %w[lib values entities mappers]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
