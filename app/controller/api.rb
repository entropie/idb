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
    fname = "original/#{Digest::SHA1.hexdigest(filec)}#{extname}"
    copy_uploaded_file(tempfile.path, fname)
  end

  def index
    "asd"
  end

  def mk_public_path(f)
    f.gsub(File.join(IDB::Source, "app/public"), '')
  end
  private :mk_public_path

  def upload
    response['Content-Type'] = 'application/json'
    if request.post?
      name = request[:name]
      tempfile, filename, @type = request[:file].
        values_at(:tempfile, :filename, :type)

      @extname, @basename = File.extname(name), File.basename(name)
      @file_size = tempfile.size

      new_file = ApiController::upload_file(name, @extname, tempfile, filename, @type)

      IDB::ResizeFacility::ImageResizeFacility.new{ resize(new_file) }.start(:thumbnail, :medium)

      ret = {
        :orginal     => mk_public_path(new_file),
        :thumbnail   => mk_public_path(new_file.gsub(/original/, 'thumbnail')),
        :medium      => mk_public_path(new_file.gsub(/original/, 'medium'))
      }.to_json
    end
  end

  def delete(img)
    response['Content-Type'] = 'application/json'
    i = 0
    [:original, :thumbnail, :medium].each do |isize|
      path = File.join(MediaPath, isize.to_s, img)
      if File.exist?(path)
        FileUtils.rm(path)
        i+=1
      end
    end
    {:ok => true, :deleted_count => i}.to_json
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
