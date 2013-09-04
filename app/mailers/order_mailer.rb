class OrderMailer < ActionMailer::Base
  default from: 'do-not-reply@tibiasmuggler.com'

  def order_created_email(order)
    @order = order
    mail(to: order.user.email, subject: 'TibiaSmuggler.com - You have created a worldtrade order!')
  end

  def order_accepted_email(order)
    @order = order
    mail(to: order.user.email, subject: 'TibiaSmuggler.com - Your order was accepted!')
  end

  def parcel_confirmed_email(order)
    @order = order
    mail(to: order.user.email, subject: 'TibiaSmuggler.com - We are processing your order!')
  end

  def order_completed_email(order)
    @order = order
    mail(to: order.user.email, subject: 'TibiaSmuggler.com - Your order was completed!')
  end

  def order_rejected_email(order)
    @order = order
    mail(to: order.user.email, subject: 'TibiaSmuggler.com - Your order was rejected!')
  end
end