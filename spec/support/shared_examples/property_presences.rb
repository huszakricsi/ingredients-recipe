RSpec.shared_examples 'property presences' do |property_names|
  describe "Property presence validations" do
    property_names.each do |property_name|
      describe "Should validate the presence of #{property_name.camelcase} property correctly" do
        let(:create_params_with_valid_property)   { {"#{property_name}": "ValidProperty"} }
        let(:create_params_with_invalid_property) { {"#{property_name}": ""} }
        let(:invalid_property_error_message)     { "#{property_name.camelcase} can't be blank" }

        it "Pass the validation if the value is valid" do
          expect(described_class.create(create_params_with_valid_property)  .errors.full_messages).not_to include(invalid_property_error_message)
        end
        it "Fail the validation if the value is invalid" do
          expect(described_class.create(create_params_with_invalid_property).errors.full_messages).to     include(invalid_property_error_message)
        end
      end
    end
  end
end
