module Jobs

  class Archive < ::Jobs::Scheduled
    every 1.day

    def execute(args)
      Logster.logger.info "executing AutoArchive"

      if SiteSetting.aa_auto_archived_enabled

      end
    end

  end
end
