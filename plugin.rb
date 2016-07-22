# name: auto-archive
# about: Automate the archiving of all or most topics on a timed basis
# version: 0.1
# authors: Erik Ordway
# url: https://github.com/eriko/auto-archive

enabled_site_setting :aa_auto_archived_enabled

after_initialize do

  require_dependency File.expand_path('../jobs/archive.rb', __FILE__)

end

