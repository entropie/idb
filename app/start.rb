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

module IDB::App
  trait[:mode] = :devel
  trait[:port] = 8300
  trait[:ip]   = "localhost"
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
