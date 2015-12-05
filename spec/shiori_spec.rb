require 'spec_helper'

describe Shiori do
  it 'has a version number' do
    expect(Shiori::VERSION).not_to be nil
  end

  it 'save image file and resize' do
    shiori = Shiori::save_image "https://www.google.co.jp/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png", "./"
    shiori.resize 300, 300
    shiori.resize_to_fill 300

    expect(File.exist?(shiori.save_path)).to be true
    expect(File.exist?(shiori.resize_path)).to be true
  end

end
