class ArchivesController < ApplicationController
  # GET /archives
  # GET /archives.json
  def index
    @archives = Archive.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @archives }
    end
  end

  # GET /archives/1
  # GET /archives/1.json
  def show
    @archive = Archive.find params[:id]
    @records = @archive.records

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
  end

  # POST /archives
  # POST /archives.json
  def create
    @archive = Archive.new params[:archive]

    respond_to do |format|
      if @archive.save

        # TODO Abstact all this into a Gem/Module/Class
        require 'open-uri'
        require 'base64'
        bearer_token = HTTParty.post("#{Figaro.env.twitter_api_url_root}oauth2/token/",
          headers: { 
            'Authorization' => "Basic #{Base64.strict_encode64("#{URI::encode(Figaro.env.twitter_api_key)}:#{URI::encode(Figaro.env.twitter_api_secret)}")}",
            'Content-Type' => 'application/x-www-form-urlencoded;charset=UTF-8',
          },
          body: { 'grant_type' => 'client_credentials' }
        )

        if bearer_token['token_type'] == 'bearer'
          tweets = HTTParty.get("#{Figaro.env.twitter_api_url_root}1.1/statuses/user_timeline.json?count=100&screen_name=#{@archive.title}",
            headers: { 
              'Authorization' => "Bearer #{bearer_token['access_token']}"
            }
          )

          tweets.each do |tweet|
            record = @archive.records.create({
              record_type: 'tweet',
              record_text: tweet['text']
            })
            record.save
          end

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
