require "shiori/version"
require 'open-uri'
require 'rmagick'
require 'securerandom'

module Shiori
  def self.save_image image_path, save_path, quality=-1
    Core.new image_path , save_path, quality
  end

  def self.new savefile, quality=-1
    Core.new nil, savefile, quality
  end

  class Core
    attr_accessor :save_path, :resize_path, :uid, :quality

    def initialize org_image_path, save_path, quality
      @quality = quality.integer? ? quality : -1
      if org_image_path != nil
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

        @resize_path = "#{File.dirname(@save_path)}/#{File.basename(@save_path, ".*")}_#{width}#{File.extname(@save_path)}"
        @fill_path = "#{File.dirname(@save_path)}/#{File.basename(@save_path, ".*")}_fill_#{fill}#{File.extname(@save_path)}"
      else
        @uid = save_path.gsub(/^.*image_(.*?)\.(.*)$/,"\\1")

        @save_path = savefile
        @resize_path = "#{File.dirname(@save_path)}/#{File.basename(@save_path, ".*")}_#{width}#{File.extname(@save_path)}"
        @fill_path = "#{File.dirname(@save_path)}/#{File.basename(@save_path, ".*")}_fill_#{fill}#{File.extname(@save_path)}"
      end
    end

    def resize width, height
      q = @quality
      orig = Magick::Image.read(@save_path).first
      image = orig.resize_to_fit(width, height)
      if q > -1
        image.write(@resize_path){ self.quality = q }
      else
        image.write(@resize_path)
      end
    end
    
    def resize_to_fill fill
      q = @quality
      orig = Magick::Image.read(@save_path).first
      image = orig.resize_to_fill(fill, fill)
      if q > -1
        image.write(@fill_path){ self.quality = q }
      else
        image.write(@fill_path)
      end

    end
  end
end
