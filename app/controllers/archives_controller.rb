class ArchivesController < ApplicationController
  # GET /archives
  # GET /archives.json
  def index
    @archives = Archive.all
    #client = return_twitter_client
    #tweets = client.user_timeline(@archives.first.title, options = {count: 200, include_rts: true})
    #tweets.each do |tweet|
    #  puts tweet['created_at']
    #end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @archives }
    end
  end

  # GET /archives/1
  # GET /archives/1.json
  def show
    @archive = Archive.find params[:id]
    @archive_items = @archive.archive_items
    #@records = @archive.records

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @archive }
    end
  end

  # GET /archives/new
  # GET /archives/new.json
  def new
    @archive = Archive.new
    @archive_item = @archive.archive_items.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @archive }
    end
  end

  # GET /archives/1/edit
  def edit
    @archive = Archive.find(params[:id])
  end

  # POST /archives
  # POST /archives.json
  def create
    @archive = Archive.new params[:archive]

    respond_to do |format|
      if @archive.save
        client = return_twitter_client

        last_archive_item = @archive.archive_items.last
        term = last_archive_item.item_term

        if last_archive_item.item_type == 'username'
          tweets = client.user_timeline(term, options = {count: 200, include_rts: 1})
          tweets.each do |tweet|
            record = last_archive_item.records.create({
              record_type: 'tweet',
            })
            record.save
            tweet = record.create_tweet({
              tweet_text: tweet['text'],
              created_date: tweet['created_at']
            })
          end
          
          last_id = tweets.last.id
          15.times do |index| 
            tweetz = client.user_timeline(term, options = {count: 200, include_rts: 1, max_id: last_id})
            tweetz.each do |tweet|
              record = last_archive_item.records.create({
                record_type: 'tweet',
              })
              record.save
              tweet = record.create_tweet({
                tweet_text: tweet['text'],
                created_date: tweet['created_at']
              })
            end
            last_id = tweets.last.id
          end
        elsif last_archive_item.item_type == 'search'
          tweets = client.search(term, result_type: 'recent').take(200).collect
          #last_id = 0
          tweets.each do |tweet|
            record = last_archive_item.records.create({
              record_type: 'tweet',
            })
            record.save
            tweet = record.create_tweet({
              tweet_text: "#{tweet.user.screen_name}: #{tweet.text}",
              created_date: tweet['created_at']
            })
            #last_id = tweet.id
          end
          
          #15.times do |index| 
          #  tweets = client.search(term, result_type: 'recent', max_id: last_id).take(200).collect
          #  tweets.each do |tweet|
          #    puts tweet.id
          #    record = last_archive_item.records.create({
          #      record_type: 'tweet',
          #    })
          #    record.save
          #    tweet = record.create_tweet({
          #      tweet_text: tweet['text'],
          #      created_date: tweet['created_at']
          #    })

          #  last_id = tweet.id
          #  end
          #end
        end

        format.html { redirect_to @archive, notice: 'Archive was successfully created.' }
        format.json { render json: @archive, status: :created, location: @archive }
      else
        format.html { render action: "new" }
        format.json { render json: @archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /archives/1
  # PUT /archives/1.json
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

  # DELETE /archives/1
  # DELETE /archives/1.json
  def destroy
    @archive = Archive.find(params[:id])
    @archive.destroy

    respond_to do |format|
      format.html { redirect_to archives_url }
      format.json { head :no_content }
    end
  end
end
