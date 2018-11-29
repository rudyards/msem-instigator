# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
Rails.application.load_tasks

def db
  @db ||= begin
    require_relative "./search-engine/lib/card_database"
    CardDatabase.load
  end
end



desc "Generate index"
task "index" do
  sh "./search-engine/indexer/bin/indexer"
end


desc "Fetch MSEM pics"
task "pics:MSEM" do
  pics = Pathname("./public/cards")
  db.printings.each do |c|
    next unless c.multiverseid
    if c.layout == "split"
      tempNumber = c.number.gsub(/[ab]/, "")
    else
      tempNumber = c.number
    end
    path = pics + Pathname("#{c.set_code}/#{tempNumber}.jpg")
    path.parent.mkpath
    next if path.exist?
    url = "http://mse-modern.com/msem2/images/#{c.set_code}/#{tempNumber}.jpg"
    puts "Downloading #{c.name} #{c.set_code} #{c.multiverseid}"
    puts "   from #{url.to_s}"
    puts "   to #{path.to_s}"
    command = "wget -nv -nc #{url} -O #{path}"
    #puts "   command: #{command}"
    system "wget", "-nv", "-nc", url, "-O", path.to_s
  end
end

desc "Fetch new Comprehensive Rules"
task "rules:update" do
  sh "bin/fetch_comp_rules"
  sh "bin/format_comp_rules"
end