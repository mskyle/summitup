module ApplicationHelper
  def sortable(column, title = nil)
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"

    link_to title, {:sort => column, :direction => direction}, :class => css_class
  end
end
