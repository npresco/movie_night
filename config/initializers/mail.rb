ApplicationMailer.smtp_settings = {
  :user_name => "#{Rails.application.credentials.sendgrid.username}",
  :password => "#{Rails.application.credentials.sendgrid_password}",
  :domain => "#{Rails.application.credentials.domain}",
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
