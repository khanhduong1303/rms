module ApplicationHelper
def sort_link (column , title = nil )
title ||= column.titleize 
cssclass = column == sort_column ? "current #{sort_direction}" : nil
direction = ( column == sort_column && sort_direction == "asc" ) ? "desc" : "asc"
link_to title ,admins_path(params.merge(sort: column , direction: direction , page: nil , user: nil )) , {class: cssclass }
end
end
