#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class IDBController < Ramaze::Controller
  layout(:layout) { !request.xhr? }
  helper :render
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
