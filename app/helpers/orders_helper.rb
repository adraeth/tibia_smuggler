module OrdersHelper

  def get_order_status
    if @order.order_status_id == 5
      "#{@order.order_status.text} - #{@order.rejection_reason}"
    else
      @order.order_status.text
    end
  end
end
