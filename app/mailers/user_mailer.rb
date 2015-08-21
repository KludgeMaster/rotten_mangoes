class UserMailer < ActionMailer::Base
  default from: 'notifications@rottenmango.com'
  
 
  def byebye_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'You are kicked out!!!')
  end
end

