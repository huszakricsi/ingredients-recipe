# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

p 'Create temporary directory for the recipes'
Dir.mktmpdir('tmp_dir_for_recipes') do |dir|

  p 'Fetching the recipes'
  url      = ::Configuration.instance.recipes_url
  request  = RestClient::Request.new(method: :get, headers: { content_type: 'application/gzip'}, url: url)
  response = request.execute.body

  p 'Decompressing and parsing'
  decompressed = ActiveSupport::Gzip.decompress(response)
  parsed_json  = JSON.parse(decompressed)

end
