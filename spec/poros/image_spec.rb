require 'rails_helper'

RSpec.describe Image do
  let!(:data) { ["city, st", {urls: { raw: "url"}, user: { name: "John Doe"}}] }
  let!(:image) { Image.new(data) }

  it 'exists' do
    expect(image).to be_instance_of(Image)
  end

  it 'has attributes' do
    expect(image.id).to eq(nil)
    expect(image.location).to eq("city, st")
    expect(image.image_url).to eq("url")
    expect(image.credit).to be_a(Hash)

    expect(image.credit).to have_key(:source)
    expect(image.credit[:source]).to eq("https://unsplash.com")
    expect(image.credit).to have_key(:author)
    expect(image.credit[:author]).to eq("John Doe")
  end
end
