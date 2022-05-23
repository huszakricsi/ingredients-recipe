require 'rails_helper'

RSpec.describe ::Configuration, type: :lib do
  let(:configuration) do
    {
      recipes_url: 'https://pennylane-interviewing-assets-20220328.s3.eu-west-1.amazonaws.com/recipes-en.json.gz',
      paginates_per: 10
  }.with_indifferent_access
  end

  let(:expected_recipes_url) {configuration[:recipes_url]}
  let(:expected_paginates_per) {configuration[:paginates_per]}

  describe 'Configuration initialization woks correctly' do
    it 'The configuration method tries to load the yaml file, and works correctly' do
      expect(YAML).to receive(:load_file).with(Rails.root.join('config/initializers/configuration.yml')).and_return(configuration)
      ::Configuration.instance.configuration
      expect(::Configuration.instance.recipes_url).to   eq(expected_recipes_url)
      expect(::Configuration.instance.paginates_per).to eq(expected_paginates_per)
      expect(::Configuration.instance.configuration).to eq(configuration)
    end
  end

  describe 'All instance method returns the corresponding configuration value' do
    before :each do
      allow_any_instance_of(::Configuration).to receive(:configuration).and_return(configuration)
    end

    it 'The recipes_url method returns the corresponding value correctly' do
      expect(::Configuration.instance.recipes_url).to eq(expected_recipes_url)
    end

    it 'The paginates_per method returns the corresponding value correctly' do
      expect(::Configuration.instance.paginates_per).to eq(expected_paginates_per)
    end

  end
end
