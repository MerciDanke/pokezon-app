# frozen_string_literal: true

require_relative '../helpers/spec_helper'
require_relative '../helpers/spec_helper_product'

describe 'Unit test of MerciDanke API gateway' do
  it 'must report alive status' do
    alive = MerciDanke::Gateway::Api.new(MerciDanke::App.config).alive?
    _(alive).must_equal true
  end

  it 'must be run in beginning' do
    res = MerciDanke::Gateway::Api.new(MerciDanke::App.config)
      .all_pokemon

    _(res.success?).must_equal true
  end

  it 'must be able to add a pokemon' do
    res = MerciDanke::Gateway::Api.new(MerciDanke::App.config)
      .add_pokemon(POKE_NAME)

    _(res.success?).must_equal true
  end

  it 'must be able to add a product' do
    res = MerciDanke::Gateway::Api.new(MerciDanke::App.config)
      .add_product(POKE_NAME)

    _(res.success?).must_equal true
  end

  it 'must be able to plus a like to pokemon' do
    res = MerciDanke::Gateway::Api.new(MerciDanke::App.config)
      .like_pokemon(ID)

    _(res.success?).must_equal true
  end

  it 'must be able to plus a like to product' do
    res = MerciDanke::Gateway::Api.new(MerciDanke::App.config)
      .like_pokemon(PROD_ID)

    _(res.success?).must_equal true
  end
end
