class VolumesController < ApplicationController

  def index
    puts params

    archive = Archive.find params[:archive_id]

    puts "Start Date: #{params['start_date'].to_time()}"
    puts "End Date: #{params['end_date'].to_time()}"

    #volumes = archive.volumes.where('volume_start_date > ?', params['start_date'].to_time()).where('volume_end_date < ?', params['end_date'].to_time())
    volumes = archive.volumes.where('volume_end_date < ?', params['end_date'].to_time())

    volumes.each do |volume|

      puts "volume_start_date: #{volume.volume_start_date}"

    end

    respond_to do |format|

      format.json { render json: volumes }

    end
  end

  def show

    @volume = Volume.first

    respond_to do |format|

      format.json { render json: @volume }

    end
  end

  def new

    @volume = Volume.new

    respond_to do |format|

      format.html # new.html.erb

      format.json { render json: @volume }

    end
  end

  def edit

    @volume = Volume.find(params[:id])

  end

  def create

    @volume = Volume.new(params[:volume])

    respond_to do |format|

      if @volume.save

        format.html { redirect_to @volume, notice: 'Volume was successfully created.' }

        format.json { render json: @volume, status: :created, location: @volume }

      else

        format.html { render action: "new" }

        format.json { render json: @volume.errors, status: :unprocessable_entity }

      end
    end
  end

  def update

    @volume = Volume.find(params[:id])

    respond_to do |format|

      if @volume.update_attributes(params[:volume])

        format.html { redirect_to @volume, notice: 'Volume was successfully updated.' }

        format.json { head :no_content }

      else

        format.html { render action: "edit" }

        format.json { render json: @volume.errors, status: :unprocessable_entity }

      end
    end
  end

  def destroy

    @volume = Volume.find(params[:id])

    @volume.destroy

    respond_to do |format|

      format.html { redirect_to volumes_url }

      format.json { head :no_content }

    end
  end
end
