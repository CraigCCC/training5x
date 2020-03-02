module TasksHelper
  def status_options
    options = [[I18n.t('tasks.status.pending'), 0], [I18n.t('tasks.status.processing'), 1], [I18n.t('tasks.status.done'), 2]]
    options_for_select(options)
  end
end
