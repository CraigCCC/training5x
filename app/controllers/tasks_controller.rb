class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search] || params[:search_status]
      session[:search] = [params[:search], params[:search_status]]
      @tasks = Task.search_like(params[:search]).search_status(params[:search_status])
    elsif params[:order_by].present?
      session[:search] ||= []
      @tasks = Task.search_like(session[:search][0]).search_status(session[:search][1]).sort_by_column(params[:order_by], params[:direction])
    else
      session.delete(:search)
      @tasks = Task.sort_by_created_at
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t("tasks.notices.add_success")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t("tasks.notices.edit_success")
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t("tasks.notices.delete_success")
  end

  private
  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title,
                                 :content,
                                 :status,
                                 :priority,
                                 :start_at,
                                 :end_at,
                                 :search)
  end
end
