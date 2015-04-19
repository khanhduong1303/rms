module ApplicationHelper
  def sort_link (column, title = nil)
    title ||= column.titleize
    cssclass = column == sort_column ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, admins_path(params.merge(sort: column, direction: direction, page: nil, user: nil)), {class: cssclass}
  end

  def number_format number = 0
    txt = number.to_i.to_s
    rs = ''
    for s in 0...txt.size do
      rs += txt[txt.size - s - 1]; rs += ',' if (s+1)%3 == 0 && s+1 > 1 && s+1 != txt.size
    end
    return session[:language] == 'vi' || session[:language].nil? ? rs.reverse! + ' đồng' : rs.reverse!
  end
end
