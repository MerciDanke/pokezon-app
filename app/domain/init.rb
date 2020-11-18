# frozen_string_literal: true

folders = %w[popularity]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
