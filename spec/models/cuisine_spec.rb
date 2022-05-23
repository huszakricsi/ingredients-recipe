require 'rails_helper'

RSpec.describe Cuisine, type: :model do
  describe 'DB columns, constraints and relations', :shoulda do
    it { should have_db_column(:id)        .of_type(:integer)                           }
    it { should have_db_column(:created_at).of_type(:datetime)                          }
    it { should have_db_column(:updated_at).of_type(:datetime)                          }
    it { should have_db_column(:name)      .of_type(:string).with_options(null: false)  }

    it { should have_many(:recipes).class_name('Recipe') }
  end

  include_examples 'property presences', ['name']

  describe 'Validations' do
    let(:valid_name_create_params) { { name: 'Valid Name'} }
    let(:invalid_name_create_params) { { name: '0-9`!@#\$%\^&*+_='} }

    
    it "Passes the validation when the name contains only valid characters" do
      expect(described_class.create(valid_name_create_params).errors.full_messages).not_to include('Name is invalid')
    end

    it "Fails the validation when the name contains any ivalid characters" do
      expect(described_class.create(invalid_name_create_params).errors.full_messages).to   include('Name is invalid')
    end
  end
end
