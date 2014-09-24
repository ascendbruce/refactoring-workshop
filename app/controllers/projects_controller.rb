require 'open-uri'

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    # FIXME: 1. Intention Revealing Method

    # When user is admitted we show it's active projects
    if current_user && current_user.projects.exists?
      @projects = current_user.active_projects
    else
      # If not admitted we show some featured projects
      @projects = Project.featured

      # set a marketing flash if user is new,
      # and a special price for user who signed up less than a week ago
      if current_user && current_user.created_at >= 1.week.ago
        flash.now[:notice] = 'Upgrade and get 20% off for having your own projects!'
      elsif current_user && current_user.created_at < 1.week.ago
        flash.now[:notice] = 'Upgrade for having your own projects!'
      end
    end
  end

  def show
  end

  def edit
  end

  def new
    @project = Project.new
  end

  def update
    if @project.update(project_params)

      # FIXME: 2 Move controller logic into model
      if @project.is_featured?
        if @project.created_at > 1.week.ago
          @project.label = "new featured"
        else
          @project.label = "featured"
        end
      else
        @project.label = "normal"
      end
      @project.save

      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def create
    @project = Project.new(project_params)

    if @project.save

      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @project.destroy

    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :is_featured)
  end
end
