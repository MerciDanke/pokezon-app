# frozen_string_literal: true

%w[pokemon products]
  .each do |folder|
    require_relative "#{folder}/init"
  end
