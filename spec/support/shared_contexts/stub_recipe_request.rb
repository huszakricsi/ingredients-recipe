RSpec.shared_context 'stub recipe request' do
  let(:recipes_url) { 'https://pennylane-interviewing-assets-20220328.s3.eu-west-1.amazonaws.com/recipes-en.json.gz' }

  before :each do
    allow_any_instance_of(::Configuration).to receive(:recipes_url).and_return(recipes_url)
    stub_request(:get, recipes_url).to_return(status: 200, body: ActiveSupport::Gzip.compress(recipe_objects.to_json))
  end
end
