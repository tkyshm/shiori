require "shiori/version"
require 'open-uri'
require 'rmagick'
require 'securerandom'

module Shiori
  def self.save_image image_path, save_path
    Core.new image_path , save_path
  end

  class Core
    attr_accessor :save_path, :resize_path, :uid

    def initialize org_image_path, save_path
      @uid = SecureRandom.hex(16)

      image = nil 
      meta = nil
      open(org_image_path, "User-Agent" => "shiori-bot/#{Shiori::VERSION}") do |data|
        image = data.read
        meta = data.meta
      end
      ext = meta["content-type"].gsub("image\/","")
      @save_path = "#{save_path}/image_#{@uid}.#{ext}"
     
      open(@save_path, 'wb') do |output|
        output.write(image)
      end
    end

    def resize width, height
      orig = Magick::Image.read(@save_path).first
      image = orig.resize_to_fit(width, height)
      @resize_path = "#{File.dirname(@save_path)}/#{File.basename(@save_path, ".*")}_#{width}#{File.extname(@save_path)}"
      image.write(@resize_path)
    end
    
    def resize_to_fill fill
      orig = Magick::Image.read(@save_path).first
      image = orig.resize_to_fill(fill, fill)
      @fill_path = "#{File.dirname(@save_path)}/#{File.basename(@save_path, ".*")}_fill_#{fill}#{File.extname(@save_path)}"
      image.write(@fill_path)
    end
  end
end
