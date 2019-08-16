# Use this file to easily define all of your cron jobs.

set :output, "log/cron_log.log"

every 1.day, at: "12:00 am" do
  runner "Poll.pick_winners"
end
