class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new 
    @task = Task.new
  end
  
  def edit
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      
      flash[:success] = "タスクが更新されました"
      redirect_to @task
      
    else
      flash[:danger] = "タスクは更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:danger] = "taskは削除されました"
    redirect_to tasks_url
  end

  private
  
  #strong parameter
  def task_params
    params.require(:task).permit(:content)
  end
end
