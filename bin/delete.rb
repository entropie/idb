#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "rubygems"
require "net/http"
require "uri"
require "cgi"
require "httpclient"
require "pp"
require "json"
require "../lib/idb"

img = ARGV.shift

TARGETS = ["http://78.46.106.73:8300/api/delete/", "http://localhost:8300/api/delete/"]

TARGETS.each do |target|
  p HTTPClient.post(target + img).body.content
end





=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
