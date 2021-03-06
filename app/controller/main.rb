#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class MainController < IDBController
  map :/
  engine :Haml

  def index
    @images = IDB::Images.all
    @thumblinks = []
    i = 13
    pg = 0
    mod = 38
    @images.top(12..-1).each_slice(mod){|s|
      @thumblinks << ["#{pg+=1}", "/thumbs/#{i}/#{i+mod}"]
      i+=mod
    }
  end

  def thumbnails
    @images = IDB::Images.all
    @thumblinks = []
    i = pg = 0
    mod = 95
    @images.top(0..-1).each_slice(mod){|s|
      @thumblinks << ["#{pg+=1}", "/thumbs/#{i}/#{i+mod}"]
      i+=mod
    }
  end

  def thumbs(start, stop)
    @images = IDB::Images.all.top(start.to_i...stop.to_i)
  end

  def random
    @img = IDB::Images.all.random
  end

  def img(*fragments)
    @img = "/#{fragments.join("/")}"
  end

  def _thumbnails_for_preload
    @images = IDB::Images.all
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
