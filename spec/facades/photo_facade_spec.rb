require 'rails_helper'

RSpec.describe PhotoFacade do
  describe 'random_img' do
    it 'returns random image for city' do
      VCR.use_cassette('san_antonio_photo') do
        photo = PhotoFacade.random_img('san antonio,tx')

        expect(photo).to be_instance_of(Image)
      end
    end
  end
end
