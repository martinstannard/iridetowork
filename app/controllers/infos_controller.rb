class InfosController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @info_pages, @infos = paginate :infos, :per_page => 10
  end

  def show
    @info = Info.find(params[:id])
  end

  def new
    @info = Info.new
  end

  def create
    @info = Info.new(params[:info])
    if @info.save
      flash[:notice] = 'Info was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @info = Info.find(params[:id])
  end

  def update
    @info = Info.find(params[:id])
    if @info.update_attributes(params[:info])
      flash[:notice] = 'Info was successfully updated.'
      redirect_to :action => 'show', :id => @info
    else
      render :action => 'edit'
    end
  end

  def destroy
    Info.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
