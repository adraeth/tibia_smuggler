module OrdersHelper

  def get_order_status_for(order)
    if order.order_status_id == 5
      "#{order.order_status.text} - #{order.rejection_reason}."
    else
      order.order_status.text
    end
  end

  def get_smuggler_charname
    if @order.order_status_id.between?(2,4)
      link_to "Gold Smuggler #{@order.world_to.name}",
            "http://www.tibia.com/community/?subtopic=characters&amp;name=Gold+Smuggler+#{@order.world_to.name}".html_safe
    else
      '---'
    end
  end
end
