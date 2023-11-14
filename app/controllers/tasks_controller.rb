class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
    set_task
    # By default, .find takes an id as paramater
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    # Raises an error because params are not accessible (permitted: false)
    # We cannot save data without using Strong Params (private method below)
    # Then pass in that private method as instance of the task in Task.new()
    redirect_to task_path(@task)
  end

  def edit
    set_task
  end

  def update
    set_task
    @task.update(task_params)
    redirect_to task_path(@task)
  end

  def destroy
    set_task
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
