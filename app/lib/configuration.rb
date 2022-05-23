class Configuration
  include Singleton

  def configuration
    @configuration ||= YAML.load_file(Rails.root.join('config/initializers/configuration.yml')).with_indifferent_access
  end

  def recipes_url
    @recipes_url ||= (ENV['RECIPES_URL'] || configuration[:recipes_url])
  end

  def paginates_per
    @paginates_per ||= (ENV['PAGINATES_PER'] || configuration[:paginates_per])
  end

end
