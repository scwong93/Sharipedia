class WikisController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index, :show]


  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    if current_user.present?
      collaborators = []
      @wiki.collaborators.each do |collaborator|
        collaborators << collaborator.email
      end
      unless @wiki.private == false || @wiki.user == current_user || collaborators.include?(current_user.email) || current_user.admin?
        flash[:alert] = "You do not have access to view this wiki."
        redirect_to wikis_path
      end
    else
      flash[:alert] = "You do not have access to view this wiki."
      redirect_to wikis_path
    end
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating the wiki. Please try again."
      render :edit
    end

    def destroy
      @wiki = Wiki.find(params[:id])

      if @wiki.destroy
        flash[:notice] = "\"#{@wiki.title}\" has been deleted."
        redirect_to wikis_path
      else
        flash.now[:alert] = "There was an error deleting the wiki. Please try again."
        render :show
      end
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
