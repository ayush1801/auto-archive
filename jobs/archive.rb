module Jobs

  class Archive < ::Jobs::Scheduled
    every 4.months

    def execute(args)
      Logster.logger.info "executing AutoArchive"

      if SiteSetting.aa_auto_archived_enabled

      end
    end

  end
end
