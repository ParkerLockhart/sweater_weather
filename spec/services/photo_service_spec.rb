require 'rails_helper'

RSpec.describe PhotoService do
  describe 'random_img' do
    before(:each) do
      VCR.insert_cassette('san_antonio_photo')
    end
    after(:each) do
      VCR.eject_cassette('san_antonio_photo')
    end

    let!(:background) { PhotoService.random_img('san antonio,tx') }

    it 'returns response hash' do
      expect(background).to be_a(Hash)
    end

    it 'response hash has photo data' do
      expect(background).to have_key(:urls)
      expect(background[:urls]).to be_a(Hash)
      expect(background[:urls]).to have_key(:raw)
      expect(background[:urls][:raw]).to be_a(String)

      expect(background).to have_key(:user)
      expect(background[:user]).to be_a(Hash)
      expect(background[:user]).to have_key(:name)
      expect(background[:user][:name]).to be_a(String)
    end
  end
end
