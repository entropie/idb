#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

module IDB
  module ResizeFacility

    module ReadDir
      def read_dir(dir, &blk)
        Dir.chdir(dir){
          Dir["*"].each do |folder|
            unless File.directory?(folder)
              yield File.expand_path(folder)
            else
              read_dir(folder, &blk)
            end
          end
        }
      end
    end

    # Example
    #  IRF::ImageResizeFacility.new(){
    #   recursive_resize("/Users/mit/facrez_tmp")
    #  }.start(:thumbnail, :medium)
    class ImageResizeFacility

      include ReadDir

      attr_accessor :policy, :bads

      ResizePolicies = {
        :thumbnail => proc{
          crop_resized!(48, 48)
        },
        :medium => proc{
          resize_to_fill!(320)
        }
      }

      def initialize(opts = {}, &blk)
        @bads = []
        @custom_policies = opts[:policies]
        instance_eval(&blk)
      end

      def policy(which)
        @custom_policies and @custom_policies[which] or ResizePolicies[which]
      end

      def start(*policies)
        spool.each do |img|
          policies.each do |policy|
            begin
              puts ">>> Resize(#{policy}): #{img}"
              new_img = Image.new(img)
              new_img.facility = self
              new_img.resize(policy)
            rescue Magick::ImageMagickError
              p $!
              bads << img
            end
          end
        end
        if bads.size > 0
          puts "Bad Files list:\n"
          bads.each{|b|
            puts b
          }
        end
      end

      def spool
        @spool ||= []
      end

      def resize(image)
        spool << image
      end

      def recursive_resize(dir)
        read_dir(dir) do |file|
          spool << file
        end
      end
    end

    class Image
      attr_accessor :resize_policy, :path, :image, :_image, :facility

      def width
        image.columns
      end

      def height
        image.rows
      end

      def method_missing(m, *a, &blk)
        image.send(m, *a, &blk)
      end

      def initialize(path)
        self.path = File.new(path)
        self.image = Magick::Image.read(path).first
        raise Magick::ImageMagickError, "image is nil" unless image
      end

      def filename_for(pol)
        name = File.basename(path.path)
        File.dirname(path.path) << "/../#{pol}/#{name}"
      end

      def write
        image.write filename_for(@policy)
      end

      def resize(policy = :default)
        @policy = policy
        instance_eval(&facility.policy(policy))
        write
      end
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
