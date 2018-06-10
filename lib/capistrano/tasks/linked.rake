namespace :linked do
  desc 'Upload linked files and directories'
  task :upload do
    invoke 'linked:upload:files'
    invoke 'linked:upload:dirs'
  end

  task :upload_files do
    invoke 'linked:upload:files'
  end

  task :upload_dirs do
    invoke 'linked:upload:dirs'
  end

  namespace :upload do
    task :files do
      on roles :all do
        fetch(:linked_files, []).each do |file|
          upload! file, "#{shared_path}/#{file}"
        end
      end
    end

    task :dirs do
      on roles :all do
        fetch(:linked_dirs, []).each do |dir|
          upload! dir, "#{shared_path}/", recursive: true, mkdir: true
        end
      end
    end
  end

  before 'linked:upload', 'deploy:check:make_linked_dirs'
end
