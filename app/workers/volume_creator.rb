class VolumeCreator

  @queue = :volume_creator

  def self.perform(archive_data)

    puts 'Volume Creator'

    archive = Archive.find archive_data['id']

    volumes = archive.volumes

    if volumes.count == 1 && volumes.first.pages.count <= 4

      volume = archive.volumes.first 

    else

      volume = archive.volumes.create volume_title: "#{archive_data['archive_title']}_volume_#{volumes.count + 1}" 

      volume.save

    end

    Page.delay({run_at: 5.seconds.from_now}).write_page(archive, volume)

  end
end
