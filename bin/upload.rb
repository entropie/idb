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

TARGET = "http://78.46.106.73:8300/api/upload"

file = File.expand_path(ARGV.shift)

uri = URI.parse(TARGET)
host = uri.host
path = uri.path[1..-1]

puts HTTPClient.post(TARGET, { :name => File.basename(file), :file => File.new(file)}).body.content



# def hash_to_data(hash)
#   hash.inject("") {|mem, arr|
#     mem << "%s=%s;" % [arr.first, CGI.escape(arr.last)]
#   }
# end

# dhash = { :filename => File.basename(file) }
# puts hash_to_data(dhash)

#net = Net::HTTP.new(host, "8300")
#net.post(path, hash_to_data(dhash))

=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
