module ApplicationHelper
  def sortable(column)
    direction = params[:direction] == 'DESC' ? 'ASC' : 'DESC'
    link_to t('tasks.end_at'), order_by: column, direction: direction
  end
end
