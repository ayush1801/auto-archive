#monkey patch Topic to add a useful scope
class Topic
  scope :created_before, lambda { |time_ago| where('topics.created_at < ?', time_ago) }
end


module Jobs
  class Archive < ::Jobs::Scheduled
    every 1.day

    def execute(args)
      Logster.logger.info "executing AutoArchive"
      #aer we enabled
      #is this the year day to run on?
      if SiteSetting.aa_auto_archived_enabled && (Time.now.yday == SiteSetting.aa_archive_day)
        #This is horrible but works
        older_than = Date.new(Time.now.year, 1, 1) + SiteSetting.aa_archive_older_than_day
        #use system to archive topics
        user = User.find_by_username('system')
        #find the topics to close.
        #do them in batches for memory performance
        Topic.created_before(older_than).find_each(batch_size: 300) do |t|
          #puts "that was created #{t.created_at} going to archive #{t.title} "
          if t.archetype == Archetype.default  #only effect not (banner, private_messages)
            t.update_status('archived', true, user)
          end
        end
      end
    end
  end
end
