class ArchiveItemsController < ApplicationController
  # GET /archive_items
  # GET /archive_items.json
  def index
    @archive_items = ArchiveItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @archive_items }
    end
  end

  # GET /archive_items/1
  # GET /archive_items/1.json
  def show
    @archive_item = ArchiveItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @archive_item }
    end
  end

  # GET /archive_items/new
  # GET /archive_items/new.json
  def new
    @archive_item = ArchiveItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @archive_item }
    end
  end

  # GET /archive_items/1/edit
  def edit
    @archive_item = ArchiveItem.find(params[:id])
  end

  # POST /archive_items
  # POST /archive_items.json
  def create
    @archive_item = ArchiveItem.new(params[:archive_item])

    respond_to do |format|
      if @archive_item.save
        format.html { redirect_to @archive_item, notice: 'Archive item was successfully created.' }
        format.json { render json: @archive_item, status: :created, location: @archive_item }
      else
        format.html { render action: "new" }
        format.json { render json: @archive_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /archive_items/1
  # PUT /archive_items/1.json
  def update
    @archive_item = ArchiveItem.find(params[:id])

    respond_to do |format|
      if @archive_item.update_attributes(params[:archive_item])
        format.html { redirect_to @archive_item, notice: 'Archive item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @archive_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archive_items/1
  # DELETE /archive_items/1.json
  def destroy
    @archive_item = ArchiveItem.find(params[:id])
    @archive_item.destroy

    respond_to do |format|
      format.html { redirect_to archive_items_url }
      format.json { head :no_content }
    end
  end
end
