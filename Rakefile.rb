#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "lib/idb"

include IDB

task :test do
  images = Images.all
  img = images.first
  # p img.next == images[1]
  # p img.next.next == images[2]
  p images.random
  p images.random
  # p img.path
  # p img.thumbnail
  # p img.medium
  # p img.http_path
  # p img.http_thumbnail
  # p img.http_medium
  # p img.size
  # p img.size(:thumb)
  # p img.size(:medium)
  # p img.expand_path(:thumb)
  # p img.url
  # p img.url(:thumb)
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
