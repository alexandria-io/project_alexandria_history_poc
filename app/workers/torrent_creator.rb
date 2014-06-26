class TorrentCreator

  @queue = :torrent_creator

  def self.perform(archive_data, volume_data)

    archive = Archive.find archive_data['id']

    volume = archive.volumes.find volume_data['id']

    volume_title =  volume['volume_title'] 

    mapped_pages = volume.pages.map do |page|

      tmp_hash = {}

      page.attributes.each_pair do |name, value|

        if ['page_title', 'page_text'].include? name

          if ['page_text'].include? name

            tmp_hash[name] = JSON.parse(value)

          else

            tmp_hash[name] = value

          end
        end
      end

      tmp_hash

    end

    torrent = archive.torrents.create title: volume_title

    torrent.save

    response = HTTParty.post("http://#{Figaro.env.torrent_box}:#{Figaro.env.flochain_port}/create_torrent.json",
      body: {
        archive_title: archive.archive_title,
        volume_title: volume_title,
        pages: mapped_pages
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Torrent-Auth-Token' => Figaro.env.torrent_auth_token
      }
    )

  end
end
