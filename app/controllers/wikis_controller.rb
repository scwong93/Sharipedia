class WikisController < ApplicationController

  before_action :authenticate_user


  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
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
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
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
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    authorize @wiki

    if @wiki.save
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
  def authenticate_user
    unless current_user
      flash.now[:alert] = "You must be a member to perform this action."
      redirect_to wikis_path
    end
  end
end
