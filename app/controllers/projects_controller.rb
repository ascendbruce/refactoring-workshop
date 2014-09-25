require 'open-uri'

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    # FIXME: 1. Intention Revealing Method

    if user_is_admitted?
      @projects = current_user.active_projects
    else
      @projects = Project.featured
      set_flash_for_not_admitted_user
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
      @project.update_label

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

  private

  def user_is_admitted?
    current_user && current_user.projects.exists?
  end

  def set_flash_for_not_admitted_user
    if new_free_user?
      flash.now[:notice] = 'Upgrade and get 20% off for having your own projects!'
    elsif old_free_user?
      flash.now[:notice] = 'Upgrade for having your own projects!'
    end
  end

  def new_free_user?
    current_user && current_user.created_at >= 1.week.ago
  end

  def old_free_user?
    current_user && current_user.created_at < 1.week.ago
  end
end
