class LibrariansController < ApplicationController

  def index

    @librarians = Librarian.all

    respond_to do |format|

      format.html # index.html.erb

      format.json { render json: @librarians }

    end
  end

  def show

    Librarian.delay({run_at: 5.seconds.from_now}).check_for_requested_archives()

    respond_to do |format|

      format.html # show.html.erb

    end
  end

  def new

    @librarian = Librarian.new

    respond_to do |format|

      format.html # new.html.erb

      format.json { render json: @librarian }

    end
  end

  def edit

    @librarian = Librarian.find(params[:id])

  end

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

  def destroy

    @librarian = Librarian.find(params[:id])

    @librarian.destroy

    respond_to do |format|

      format.html { redirect_to librarians_url }

      format.json { head :no_content }

    end
  end
end
