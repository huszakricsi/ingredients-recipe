require 'spec_helper'
require 'active_model'
require_relative '../../app/validators/image_url_validator.rb'

RSpec.describe ImageUrlValidator do
  subject do
    Class.new do
      include ActiveModel::Validations    
      attr_accessor :image
      validates :image, image_url: true
    end.new
  end

  describe 'invalid images' do
    ['unknown', 'x', '.com.', '.', ' ', '', nil].each do |image|
      describe "when image is #{image}" do

        it "adds an error" do
          subject.image = image
          subject.validate
          expect(subject.errors[:image]).to include 'is not a valid HTTP URL'
        end
      end
    end
  end

  describe 'valid images' do
    ['http://www.image.com/image/123', 'https://www.images.net/image/123'].each do |image|
      describe "when image is #{image}" do
        it "does not add an error" do
          subject.image = image
          subject.validate
          expect(subject.errors[:image]).not_to include 'is not a valid HTTP URL'
        end
      end
    end
  end
end
