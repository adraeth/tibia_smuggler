module ApplicationHelper

  def full_title(page_title)
    base_title = 'Tibia Smuggler WT'
    page_title.empty? ? base_title : "#{ base_title } | #{ page_title }"
  end

  def image_name_for(char)
    char != ',' ? char : 'comma'
  end

  def chars_with_separators(number)
    number.to_s.reverse.scan(/.{1,3}/).join(',').chars
  end

  def gold_count_as_image_set
    chars = chars_with_separators(World.sum(:amount))
    chars.map { |char| image_tag("numbers/#{image_name_for char}.png") }.join.html_safe
  end

  def random_header_center_image
    image_tag "header_images/image#{ Random.rand(5) + 1 }.png", alt: 'Header image'
  end
end
