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
        images << Image.new(File.basename(image), images)
      end
      images.replace(images.sort_by{|image| File.ctime(image.expand_path) })
    end

    def self.all(force = false)
      if @images.nil? or force
        @images = load
      end
      @images
    end

    def random
      sort_by{ rand }.first
    end

    def by_score
      sort_by{|img| img.score}.reverse
    end

    def top(arg = 0)
      by_score[arg]
    end

  end

  class Image

    attr_reader :list

    RelativePath = "public/images/original/%s"

    HTTPPath     = "/images/%s/%s"

    def score
      @score ||= rand(100)
    end

    def next
      list[list.index(self) + 1]
    end

    def prev
      list[list.index(self) - 1]
    end

    def initialize(image, list)
      @image = image
      @list  = list
    end

    def identifier
      File.basename(path).split(".").first
    end

    def inspect
      %Q(<Image: #{File.basename(path)}>)
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

    def r_original
      path
    end

    def url(which = :original)
      http_path(which)
    end

    def original
      http_path
    end

    def css
      "img-#{list.index(self)}"
    end

    def thumbnail
      http_path(:thumbnail)
    end
    alias :thumb :thumbnail

    def medium
      http_path(:medium)
    end

    def tag(which = :original)
      %Q(<div class="img-box"><img data-org="#{send(:original)}" src="#{send(which)}" class="#{css} #{which}" data-score="#{score}" /></div>)
    end

    def _thumbnail
      alternative_image(:thumbnail)
    end
    alias :_thumb :_thumbnail

    def _medium
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
