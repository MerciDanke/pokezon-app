# frozen_string_literal: true

folders = %w[models infrastructure controllers domain]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
