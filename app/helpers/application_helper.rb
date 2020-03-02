module ApplicationHelper
  def sortable(column)
    direction = params[:direction] == 'DESC' ? 'ASC' : 'DESC'
    link_to t("tasks.#{column}"), order_by: column.split('.')[0], direction: direction
  end
end
