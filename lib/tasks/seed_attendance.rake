namespace :db do
  desc 'Seed random event attendances'
  task :seed_attendance, [:event_id] => :environment do |task, args|
    def seed_event_attendance(event_id = nil)
      event = event_id ? Event.find(event_id) : Event.all.sample(1).first

      if event.nil?
        puts '❌ No event found. Please create an event first or specify a valid event_id.'
        exit 1
      end

      all_users = User.all

      exit 1, '❌ No users found in the database.' if all_users.empty?

      min_users = (all_users.count / 2.0).ceil
      max_users = all_users.count
      selected_count = rand(min_users..max_users)

      selected_users = all_users.sample(selected_count)

      puts "🎯 Creating attendances for #{selected_count} users for event: '#{event.name}'"
      puts "📅 Event: #{event.start_time.strftime('%Y-%m-%d %H:%M')} - #{event.end_time.strftime('%Y-%m-%d %H:%M')}"
      puts "📍 Location: #{event.location}"
      puts ''

      created_count = 0
      skipped_count = 0

      ActiveRecord::Base.transaction do
        selected_users.each do |user|
          # Skip if attendance already exists
          if Attendance.exists?(user: user, event: event)
            skipped_count += 1
            next
          end

          status = case rand(100)
                   when 0..69  then 'approved'   # 70% approved
                   when 70..84 then 'requested'  # 15% requested
                   when 85..94 then 'waitlisted' # 10% waitlisted
                   else 'denied'                 # 5% denied
                   end

          Attendance.create!(
            user: user,
            event: event,
            status: status
          )

          created_count += 1

          print '.' if created_count % 50 == 0
        end
      end

      event.attendances.group(:status).count.each do |status, count|
        percentage = (count.to_f / event.attendances.count * 100).round(1)
        puts "   #{status.capitalize.ljust(11)}: #{count.to_s.rjust(3)} (#{percentage}%)"
      end
    end

    event_id = args[:event_id]&.to_i
    seed_event_attendance(event_id)
  end
end
