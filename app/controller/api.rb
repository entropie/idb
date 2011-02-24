#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class ApiController < IDBController
  map "/api"

  MediaPath = File.join(IDB::Source, "app/public/images"

  def self.copy_uploaded_file(src, to)
    Dir.chdir(Media.media_path) do
      check = Repos.expand_path(to)
      FileUtils.mkdir_p(File.dirname(to))
      FileUtils.copy(src, to)
    end
  end

  def self.upload_file(name, extname, tempfile, filename, type)
    filec = File.open(tempfile.path, 'rb').read
    fname = "#{name}#{extname}"

    copy_uploaded_file(tempfile.path, fname)

    bmedia = OY::Media.create_bare(fname)
    media  = bmedia.create do |pg|
      pg.message = "update"
      pg.data = filec
    end
  end

  def index
    "asd"
  end

  def upload
    if request.post?
      name = request[:name]
      tempfile, filename, @type = request[:file].
        values_at(:tempfile, :filename, :type)

      @extname, @basename = File.extname(filename), File.basename(filename)
      @file_size = tempfile.size

      ApiController::upload_file(name, @extname, tempfile, filename, @type)

      redirect SpecialController.r(:media, "#{name}#{@extname}")
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
