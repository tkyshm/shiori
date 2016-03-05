require 'spec_helper'

describe Shiori do
  it 'has a version number' do
    expect(Shiori::VERSION).not_to be nil
  end

  it 'save image file and resize' do
    url = "http://idolmaster.jp/blog/vy4dffxn2qf1/wp-content/uploads/2015/07/62kn7HBemTPUDStMhUcWzmuHdLraLKL0.png"
    shiori = Shiori::save_image url, "./"
    shiori.resize 300, 300
    shiori.resize_to_fill 300

    expect(File.exist?(shiori.save_path)).to be true
    expect(File.exist?(shiori.resize_path)).to be true
  end


  it 'save image file using quality param' do
    url = "http://idolmaster.jp/blog/vy4dffxn2qf1/wp-content/uploads/2015/07/62kn7HBemTPUDStMhUcWzmuHdLraLKL0.png"
    shiori = Shiori::save_image url, "./", 2
    shiori.resize 300, 300
    shiori.resize_to_fill 300

    expect(File.exist?(shiori.save_path)).to be true
    expect(File.exist?(shiori.resize_path)).to be true
  end

  it 'save image file using unsupported quality integer' do
    url = "http://idolmaster.jp/blog/vy4dffxn2qf1/wp-content/uploads/2015/07/62kn7HBemTPUDStMhUcWzmuHdLraLKL0.png"
    shiori = Shiori::save_image url, "./", -1
    shiori.resize 300, 300
    shiori.resize_to_fill 300

    expect(File.exist?(shiori.save_path)).to be true
    expect(File.exist?(shiori.resize_path)).to be true
  end

  it 'new instance and resize from existing image file' do
    shiori = Shiori::new "./image_11111.png"
    shiori.resize 300, 300
    shiori.resize_to_fill 300, 300

    expect(File.exist?(shiori.save_path)).to be true
    expect(File.exist?(shiori.resize_path)).to be true
  end

end
