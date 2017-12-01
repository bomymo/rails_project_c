class UserMailer < ApplicationMailer
  def contact_form(email, name, message)
    @message = message
    mail(from: email,
      to: 'bomymo@gmail.com',
    subject: "A new contact form message from #{name}")
  end

  def welcome(user)
    @appname = "Pop 60!"
    mail(to: user.email,
      subject: "Welcome to #{@appname}")
  end

  def thanks(user, product)
    logger.debug("!!Thanks message!!")
    mail(to: user.email,
      subject: "Your purchase from Pop60!",
      body: "Thanks for your purchase of #{product.name}! We know you'll love it!")
  end
end


   #ActionMailer::Base.mail(from: @email,
    #  to: "bomymo@gmail.com",
    #  subject: "A new contact form message from #{@name}",
    #  body: @message).deliver_now