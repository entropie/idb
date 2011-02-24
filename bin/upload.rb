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

$stdout.sync = true
Dir.glob("../tmpimages/*.*").each {|rfile|
  file = File.expand_path(rfile)
  ret = JSON.parse(HTTPClient.
                   post(TARGET, { :name => File.basename(file), :file => File.new(file)}).body.content)
  ret.each_pair{|what, image|
    imagefc = HTTPClient.get("http://78.46.106.73:8300#{image}").body.content
    local_file = File.join(targetDir, image)
    File.open(local_file, 'wb'){|fc| fc.write(imagefc)}
    print "."
  }
}
puts

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
