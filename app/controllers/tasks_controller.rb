class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update,:destroy]
  
  def index
    @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(25)
  end
  
  def show
  end
  
  def new 
    @task = Task.new
  end
  
  def edit
  end
  
  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = "タスクが作成されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが作成されませんでした"
      render :new
    end
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = "タスクが更新されました"
      redirect_to @task
    else
      flash[:danger] = "タスクは更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:danger] = "taskは削除されました"
    redirect_to tasks_url
  end
  

  private
  
  def set_task
    @task = Task.find_by(id: params[:id])
    redirect_to root_url if @task.try!(:user) != current_user
  end
  
  #strong parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
