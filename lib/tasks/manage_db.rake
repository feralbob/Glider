namespace :db do
  desc "Clean old messages"
  task :manage_db => :environment do
    m = Message.find(:all, :conditions => ["created_at < ?",  (Time.now - 1.day).strftime('%Y-%m-%d')] )
    m.each do |m|
      puts "Deleting #{m.message}"
      m.destroy
    end
    puts "Done."
  end
end
