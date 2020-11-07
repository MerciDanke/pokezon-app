# frozen_string_literal: true

%w[entities mappers products]
  .each do |folder|
    require_relative "#{folder}/init"
  end
