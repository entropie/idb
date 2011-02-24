#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class ApiController < IDBController
  map "/api"

  MediaPath = File.join(IDB::Source, "app/public/images")

  def self.copy_uploaded_file(src, to)
    puts ">>>#{src} : (#{to})"
    Dir.chdir(MediaPath) do
      FileUtils.mkdir_p(File.dirname(to))
      FileUtils.copy(src, to)
    end
    File.join(MediaPath, to)
  end

  def self.upload_file(name, extname, tempfile, filename, type)
    filec = File.open(tempfile.path, 'rb').read
    fname = "original/#{name}"
    copy_uploaded_file(tempfile.path, fname)
  end

  def index
    "asd"
  end

  def upload
    response[ 'Content-Type' ] = 'application/json'
    if request.post?
      name = request[:name]
      tempfile, filename, @type = request[:file].
        values_at(:tempfile, :filename, :type)

      @extname, @basename = File.extname(filename), File.basename(filename)
      @file_size = tempfile.size

      new_file = ApiController::upload_file(name, @extname, tempfile, filename, @type)

      IDB::ResizeFacility::ImageResizeFacility.new{ resize(new_file) }.start(:thumbnail, :medium)

      mk_public_path = proc{|f| f.gsub(File.join(IDB::Source, "app/public", '')) }
      ret = {
        :orginal     => mk_public_path.call(new_file),
        :thumbnail   => mk_public_path.call(new_file.gsub(/original/, 'thumbnail')),
        :medium      => mk_public_path.call(new_file.gsub(/original/, 'medium'))
      }.to_json
    end
  end
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
