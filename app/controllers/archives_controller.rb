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
    @tmp_words = []
    @word_count_array = []
    @archive.records.each do |record|
      record.tweet.tweet_text.split(' ').each do |word|
        if @tmp_words.include? word
          @word_count_array.each do |word_count|
            if word_count[0] == word
              word_count[1] += 1
            end
          end
        else 
          if !['the', 'The', 'a', 'A', 'i', 'I', 'to', 'To','for', 'For', 'that', 'That', 'of', 'Of', 'RT', 'and'].include? word
            @tmp_words << word
            @word_count_array << [word, 1]
          end
        end
      end
    end

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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @archive }
    end
  end

  # GET /archives/1/edit
  def edit
    @archive = Archive.find(params[:id])
    @archive_items = @archive.archive_items
  end

  # POST /archives
  # POST /archives.json
  def create
    @archive = Archive.new params[:archive]

    respond_to do |format|
      if @archive.save
        Resque.enqueue(ArchiveCreationPricer, @archive, params)
        #client = return_twitter_client

        #last_archive_item = @archive
        #term = last_archive_item.archive_term

        #if last_archive_item.archive_type == 'username'
        #  tweets = client.user_timeline(term, options = {count: 200, include_rts: 1})
        #  tweets.each do |tweet|
        #    record = last_archive_item.records.create({
        #      record_type: 'tweet',
        #    })
        #    record.save

        #    #response = HTTParty.post("#{Figaro.env.florincoin_blockchain_ip}tip?token=foobar8&team_id=foobar&team_domain=foobar&service_id=foobar&channel_id=foobar&channel_name=sw_bots&timestamp=foobar.000198&user_id=foobar&user_name=carlos&text=tip&tweet_text=#{Rack::Utils.escape(tweet['text'])}&trigger_word=litecointipper", 
        #    #headers: {
        #    #    'Content-Type' => 'application/json'
        #    #  }
        #    #)

        #    tweet = record.create_tweet({
        #      tweet_text: tweet['text'],
        #      created_date: tweet['created_at']
        #    })
        #  end
        #  
        #  #last_id = tweets.last.id
        #  #5.times do |index| 
        #  #  tweetz = client.user_timeline(term, options = {count: 200, include_rts: 1, max_id: last_id})
        #  #  tweetz.each do |tweet|
        #  #    record = last_archive_item.records.create({
        #  #      record_type: 'tweet',
        #  #    })
        #  #    record.save
        #  #    tweet = record.create_tweet({
        #  #      tweet_text: tweet['text'],
        #  #      created_date: tweet['created_at']
        #  #    })
        #  #  end
        #  #  last_id = tweets.last.id
        #  #end
        #elsif last_archive_item.archive_type == 'search'
        #  tweets = client.search(term, result_type: 'recent').take(200).collect
        #  #last_id = 0
        #  tweets.each do |tweet|
        #    record = last_archive_item.records.create({
        #      record_type: 'tweet',
        #    })
        #    record.save
        #    tweet = record.create_tweet({
        #      tweet_text: "#{tweet.user.screen_name}: #{tweet.text}",
        #      created_date: tweet['created_at']
        #    })
        #    #last_id = tweet.id
        #  end
        #  
        #  #15.times do |index| 
        #  #  tweets = client.search(term, result_type: 'recent', max_id: last_id).take(200).collect
        #  #  tweets.each do |tweet|
        #  #    puts tweet.id
        #  #    record = last_archive_item.records.create({
        #  #      record_type: 'tweet',
        #  #    })
        #  #    record.save
        #  #    tweet = record.create_tweet({
        #  #      tweet_text: tweet['text'],
        #  #      created_date: tweet['created_at']
        #  #    })

        #  #  last_id = tweet.id
        #  #  end
        #  #end
        #end

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
