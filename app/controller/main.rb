#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class MainController < IDBController
  map :/
  engine :Haml

  def index
    @images = IDB::Images.all
    "#{@images.size}"
  end

  def random
    @img = IDB::Images.all.random
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
