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
      link_to "Gold Smuggler #{@order.world_from.name}",
            "http://www.tibia.com/community/?subtopic=characters&amp;name=Gold+Smuggler+#{@order.world_from.name}".html_safe
    else
      '---'
    end
  end

  def tibia_com_char_link_for(charname)
    link_to charname, "http://www.tibia.com/community/?subtopic=characters&amp;#{charname.to_query('name')}".html_safe
  end
end
