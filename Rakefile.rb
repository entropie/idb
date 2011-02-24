#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "lib/idb"

include IDB

task :test do
  images = Images.load
  img = images.first
  p img.path
  p img.thumbnail
  p img.medium
  p img.http_path
  p img.http_thumbnail
  p img.http_medium
  p img.size
  p img.size(:thumb)
  p img.size(:medium)
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
