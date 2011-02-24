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

TARGET = "http://78.46.106.73:8300/api/upload"

file = File.expand_path(ARGV.shift)

targetDir = File.join(IDB::Source, "app/public")

ret = JSON.parse(HTTPClient.post(TARGET, { :name => File.basename(file), :file => File.new(file)}).body.content)

ret.each_pair{|what, image|
  p File.join(targetDir, image)
}

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
