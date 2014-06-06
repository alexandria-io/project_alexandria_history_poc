class LibrariansController < ApplicationController
  # GET /librarians
  # GET /librarians.json
  def index
    @librarians = Librarian.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @librarians }
    end
  end

  # GET /librarians/1
  # GET /librarians/1.json
  def show
    @librarian = Librarian.find(params[:id])
    Librarian.delay({run_at: 5.seconds.from_now}).check_for_requested_archives()

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @librarian }
    end
  end

  # GET /librarians/new
  # GET /librarians/new.json
  def new
    @librarian = Librarian.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @librarian }
    end
  end

  # GET /librarians/1/edit
  def edit
    @librarian = Librarian.find(params[:id])
  end

  # POST /librarians
  # POST /librarians.json
  def create
    @librarian = Librarian.new(params[:librarian])

    respond_to do |format|
      if @librarian.save
        format.html { redirect_to @librarian, notice: 'Librarian was successfully created.' }
        format.json { render json: @librarian, status: :created, location: @librarian }
      else
        format.html { render action: "new" }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /librarians/1
  # PUT /librarians/1.json
  def update
    @librarian = Librarian.find(params[:id])

    respond_to do |format|
      if @librarian.update_attributes(params[:librarian])
        format.html { redirect_to @librarian, notice: 'Librarian was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /librarians/1
  # DELETE /librarians/1.json
  def destroy
    @librarian = Librarian.find(params[:id])
    @librarian.destroy

    respond_to do |format|
      format.html { redirect_to librarians_url }
      format.json { head :no_content }
    end
  end
end
