#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

require "rubygems"
require "ostruct"
require "nokogiri"
require "json"
require "unicode"

require "pp"

module IDB
  Source  = File.dirname(File.dirname(File.expand_path(__FILE__))) unless const_defined?(:Source)

  Version = [0, 4, 3] unless const_defined?(:Version)

  $: << File.join(Source, "lib/idb") unless $:.include?(File.join(Source, "lib/idb"))
  $: << File.join(Source, "app")     unless $:.include?(File.join(Source, "app"))

end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
