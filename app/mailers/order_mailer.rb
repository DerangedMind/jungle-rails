class OrderMailer < ApplicationMailer

  default from: 'orders@jungle.com'

  def order_email(order)
    @order = order
    @url = '/orders/#{@order.id}'
    mail( 
      to: @order.email, 
      subject: '[Order ##{@order.id}] Thanks for ordering!'
    )
  end
end