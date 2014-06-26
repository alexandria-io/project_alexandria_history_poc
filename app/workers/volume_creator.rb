class VolumeCreator

  @queue = :volume_creator

  def self.perform(archive_data)

    puts 'Volume Creator'

    archive = Archive.find archive_data['id']

    volumes = archive.volumes

    volume = archive.volumes.create volume_title: "#{archive_data['archive_title']}_volume_#{volumes.nil? ? '1' : (volumes.count + 1)}" 

    Page.delay({run_at: 5.seconds.from_now}).write_page(archive, archive.volumes.last)

  end
end
