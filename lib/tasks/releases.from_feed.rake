namespace :releases do
  desc "Pulls feed from tracker and creates releases from it"
  task :from_feed, [:url] => :environment do |task, args|
    begin
      release_count = Release.count
      url = args[:url] || "http://www.tokyotosho.info/rss.php?filter=1,7&entries=450"
      Release.from_feed(url)
      puts "#{Release.count - release_count} releases successfully added"
    rescue Exception => e
      puts "Pull from tracker failed with: #{e.message}"
      exit 1
    end
  end
end
