class OrderMailer < ActionMailer::Base
  default from: 'do-not-reply@tibiasmuggler.com'

  def order_created_email(order)
    @order = order
    mail(to: order.user.email, subject: 'TibiaSmuggler.com - You have created a worldtrade order!')
  end
end