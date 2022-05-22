class Configuration
  include Singleton

  def configuration
    @configuration ||= YAML.load_file(Rails.root.join('config/initializers/configuration.yml')).with_indifferent_access
  end

  def recipes_url
    configuration[:recipes_url]
  end

end