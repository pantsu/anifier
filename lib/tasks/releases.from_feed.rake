namespace :releases do
  desc "Pulls feed from tracker and creates releases from it"
  task :from_feed, [:url] => :environment do |task, args|
    begin
      release_count = Release.count
      Release.from_feed(args[:url])
      puts "#{Release.count - release_count} releases successfully added"
    rescue Exception => e
      puts "Pull from tracker failed with: #{e.message}"
      exit 1
    end
  end
end