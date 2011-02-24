#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "../lib/idb"
require "ramaze"
require "haml"

require "app"

require "controller/idb"
require "controller/main"
require "controller/css"
require "controller/api"

begin
  require "RMagick"
  require "model/images"
rescue LoadError
  warn "RMagick not available on this platform"
end



module IDB::App
  trait[:mode] = :devel
  if `hostname` =~ /xeno/
    trait[:port] = 8300
    trait[:ip]   = "localhost"
  else
    trait[:port] = 8300
    trait[:ip]   = "78.46.106.73"
  end
  what = Config.server["daemon"] || :run
  run
end




=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
