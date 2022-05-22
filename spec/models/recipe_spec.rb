require 'rails_helper'

RSpec.describe Recipe, type: :model do

  describe 'DB columns, constraints and relations', :shoulda do
    it { should have_db_column(:id)           .of_type(:integer)               }
    it { should have_db_column(:created_at)   .of_type(:datetime)              }
    it { should have_db_column(:updated_at)   .of_type(:datetime)              }
    it { should have_db_column(:author_id)    .of_type(:integer)               }
    it { should have_db_column(:category_id)  .of_type(:integer)               }
    it { should have_db_column(:cuisine_id)   .of_type(:integer)               }
    it { should have_db_column(:title)        .of_type(:string)                }

    
    it { should have_many(:ingredient_recipes)                        }
    it { should have_many(:ingredients).through('ingredient_recipes') }
  end
end
