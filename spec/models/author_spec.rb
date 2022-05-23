require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'DB columns, constraints and relations', :shoulda do
    it { should have_db_column(:id)        .of_type(:integer)                           }
    it { should have_db_column(:created_at).of_type(:datetime)                          }
    it { should have_db_column(:updated_at).of_type(:datetime)                          }
    it { should have_db_column(:name)      .of_type(:string) .with_options(null: false) }

    it { should have_many(:recipes).class_name('Recipe') }
  end

  include_examples 'property presences', ['name']

end
