# frozen_string_literal: true

folders = %w[pokezon popularity]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
