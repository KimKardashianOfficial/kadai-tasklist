class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:edit]
  
  def index
     @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Message は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Message は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Message は正常に削除されました'
    #redirect_to tasks_url
    redirect_to users_url
  end
  
  # NEW ADD
  def correct_user
    @task = Task.find(params[:id])
    p @task
    #unless @task
    if @task.user_id.to_i != current_user.id.to_i
      redirect_to users_url
    end
  end
  # NWW ADD END
  
   private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content , :status , :user_id)
  end
end