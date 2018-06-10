module Capistrano
  module App
    module Helpers
      def file_exists?(path)
        test "[ -e #{path} ]"
      end

      def template(name)
        StringIO.new(template_to_s(name))
      end

      def template_to_s(name)
        locals = {
          deploy_path: deploy_path,
          current_path: current_path,
          shared_path: shared_path,
          nginx_workers: fetch(:nginx_workers, 1),
          unicorn_workers: fetch(:unicorn_workers, 1)
        }

        ERB.new(File.read("lib/capistrano/tasks/confs/#{name}.erb"), nil, '-')
          .result(ERBNamespace.new(locals).get_binding).gsub(/\r\n/, "\n")
      end

      def sudo_upload!(from, to)
        filename = File.basename(to)
        to_dir = File.dirname(to)
        tmp_file = "#{fetch(:tmp_dir)}/#{filename}"
        upload! from, tmp_file

        sudo(:rm, to) if file_exists?(to)
        sudo :mv, tmp_file, to_dir
      end

      class ERBNamespace
        def initialize(hash)
          hash.each do |key, value|
            singleton_class.send(:define_method, key) { value }
          end
        end

        def get_binding
          binding
        end
      end
    end
  end
end
