module WorldsHelper

  def location_icon_for(location)
    image_tag("flags/#{location.downcase}.png")
  end

  def transfer_status_for(world)
    output = ''
    if world.blocked_for_outgoing
      output << '<span class="red">Transfers from this world are currently blocked!</span><br />'
    else
      output << '<span class="gray">Transfers from this world are possible.</span><br />'
    end
    if world.blocked_for_incoming
      output << '<span class="red">Transfers to this world are currently blocked!</span><br />'
    else
      output << '<span class="gray">Transfers to this world are possible.</span><br />'
    end
    if world.amount > 5_000_000 and not (world.blocked_for_incoming and world.blocked_for_outgoing)
    output << '<span class="orange">High transfers from this world may be rejected!</span>'
    end
    output.html_safe
  end

  def tibia_com_link_for(world)
    link_to world.name, "http://www.tibia.com/community/?subtopic=worlds&world=#{world.name}"
  end
end
