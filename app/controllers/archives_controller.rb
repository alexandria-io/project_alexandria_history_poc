class ArchivesController < ApplicationController

  def index

    @archives = Archive.all

    #client = return_twitter_client
    #tweets = client.user_timeline(@archives.first.title, options = {count: 200, include_rts: true})
    #tweets.each do |tweet|
    #end

    respond_to do |format|

      format.html # index.html.erb

      format.json { render json: @archives }

    end
  end

  def show

    @archive = Archive.find params[:id]

    @volumes = @archive.volumes

    #@archive_start_date = DateTime.strptime(@archive.archive_start_date.to_s,'%s').strftime '%b %d'

    @archive_end_date = DateTime.strptime(@archive.archive_end_date.to_i.to_s,'%s').strftime '%b %d'

    if @archive.florincoin_price.nil? && @archive.florincoin_address.nil?

      @show_spinner = 'true'

    else

      @show_spinner = 'false'

    end

    @tmp_words = []

    @word_count_array = []

    #unless @volumes.empty?

    #  @volumes.first.pages.each do |page|

    #    JSON.parse(page.page_text).each do |tweet|

    #      tweet['tweet_text'].split(' ').each do |word|

    #        @word_count_array.each do |word_count|

    #          if word_count[0] == word

    #            word_count[1] += 1

    #          end
    #        end

    #        if !['the', 'The', 'a', 'A', 'i', 'I', 'to', 'To','for', 'For', 'that', 'That', 'of', 'Of', 'RT', 'and'].include? word

    #          @tmp_words << word

    #          @word_count_array << [word, 1]

    #        end
    #      end
    #    end
    #  end
    #end

    respond_to do |format|

      format.html # show.html.erb

      format.json { render json: @archive }

    end
  end

  def new

    @archive = Archive.new

    respond_to do |format|

      format.html # new.html.erb

      format.json { render json: @archive }

    end
  end

  def edit

    @archive = Archive.find(params[:id])

  end

  def create

    params[:archive][:archive_title] = "#{params[:archive][:archive_term].parameterize}_#{Time.now.to_i}"

    params[:archive][:archive_end_date] = Time.at(Time.now.to_i + params[:archive][:archive_time_length].to_i.months) 

    @archive = Archive.new params[:archive]

    respond_to do |format|

      if @archive.save

        require 'chain_api'

        Resque.enqueue(ArchiveCreationPricer, @archive)

        format.html { redirect_to @archive, notice: 'Archive was successfully created.' }

        format.json { render json: @archive, status: :created, location: @archive }

      else

        format.html { render action: "new" }

        format.json { render json: @archive.errors, status: :unprocessable_entity }

      end
    end
  end

  def update

    @archive = Archive.find(params[:id])

    respond_to do |format|

      if @archive.update_attributes(params[:archive])

        format.html { redirect_to @archive, notice: 'Archive was successfully updated.' }

        format.json { head :no_content }

      else

        format.html { render action: "edit" }

        format.json { render json: @archive.errors, status: :unprocessable_entity }

      end
    end
  end

  def destroy

    @archive = Archive.find(params[:id])

    @archive.destroy

    respond_to do |format|

      format.html { redirect_to archives_url }

      format.json { head :no_content }

    end
  end
end
