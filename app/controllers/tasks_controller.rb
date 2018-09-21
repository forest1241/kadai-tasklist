class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update,:destroy]
  
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page]).per(25)
  end
  
  def show
  end
  
  def new 
    @task = Task.new
  end
  
  def edit
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "Taskが作成されました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskが作成されませんでした"
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
    @task = Task.find(params[:id])
  end
  
  #strong parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end
