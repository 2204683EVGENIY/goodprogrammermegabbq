class ApplicationMailer < ActionMailer::Base
  default from: ENV["MJ_SENDER_ADRESS"]
  layout "mailer"
end
