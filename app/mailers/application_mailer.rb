class ApplicationMailer < ActionMailer::Base
  default from: Settings.from_address
  layout "mailer"
end
