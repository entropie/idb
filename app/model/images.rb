#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module IDB

  class Images < Array

    ImageDir = File.join(Source, "app/public/images/")

    def self.load
      images = self.new
      Dir.glob("#{File.join(ImageDir, 'original')}/*.*").each do |image|
        images << Image.new(File.basename(image))
      end
      images
    end

    def self.all
      @images = load
    end
  end

  class Image

    RelativePath = "app/public/images/original/%s"

    HTTPPath     = "/images/%s/%s"

    def initialize(image)
      @image = image
    end

    def expand_path(which = :original)
      File.expand_path(alternative_image(which))
    end

    def path
      RelativePath % @image
    end

    def http_path(which = :original)
      HTTPPath % [which, @image]
    end

    def original
      path
    end

    def url(which = :original)
      http_path(which)
    end

    def http_original
      http_path
    end

    def http_thumbnail
      http_path(:thumbnail)
    end

    def http_medium
      http_path(:medium)
    end

    def thumbnail
      alternative_image(:thumbnail)
    end
    alias :thumb :thumbnail

    def medium
      alternative_image(:medium)
    end

    def alternative_image(which, base = nil)
      tpath = base.nil? ? path : http_path
      path.gsub(/original/, "#{which}")
    end

    def size(which = :original)
      File.size(send(which))
    end
  end

end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
