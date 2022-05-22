require 'rails_helper'

RSpec.describe IngredientRecipe, type: :model do  describe 'DB columns, constraints and relations', :shoulda do
  it { should have_db_column(:id)        .of_type(:integer)                           }
  it { should have_db_column(:created_at).of_type(:datetime)                          }
  it { should have_db_column(:updated_at).of_type(:datetime)                          }

  it { should belong_to(:recipe).class_name('Recipe') }
  it { should belong_to(:ingredient).class_name('Ingredient') }
end
end
