require 'rails_helper'

RSpec.describe Geolocation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lng) }
  end 
end
