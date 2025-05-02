namespace :active_storage do
  desc "Migrate local files to Akamai"
  task migrate_to_akamai: :environment do
    old_service = ActiveStorage::Blob.service
    new_service = ActiveStorage::Service.configure(:akamai, Rails.configuration.active_storage.service_configurations)

    ActiveStorage::Blob.find_each do |blob|
      next if blob.service_name == "akamai"

      puts "Migrating #{blob.filename}..."

      io = old_service.download(blob.key)
      new_service.upload(blob.key, StringIO.new(io), checksum: blob.checksum)

      blob.update!(service_name: "akamai")
    end
  end
end
