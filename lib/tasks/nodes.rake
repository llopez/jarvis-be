namespace :nodes do
  desc 'Nodes::Monit'
  task monit: :environment do
    loop do
      Node.where(ping_at: { '$lte': Time.current - 5.seconds })
          .update_all(status: 'offline')
      sleep(5)
    end
  end

  desc 'Nodes::Sync'
  task sync: :environment do
    logger = Logger.new('log/mqtt.log')

    uri = URI.parse ENV['CLOUDMQTT_URL']

    conn_opts = {
      remote_host: uri.host,
      remote_port: uri.port,
      username: uri.user,
      password: uri.password
    }

    MQTT::Client.connect(conn_opts) do |c|
      c.get('/jarvis/ping') do |topic, message|
        logger.debug "#{topic}: #{message}"
        puts "#{topic}: #{message}"
        data = JSON.parse(message, symbolize_names: true)
        # 1) Iterate Rules and see if something need to be executed
        # 2) Save to mongo
        node = Node.find_or_initialize_by data.slice(:chipid)
        node.ip = data[:ip]
        node.status = 'online'
        node.ping_at = Time.current
        node.save
        data[:pins].each do |pin_data|
          pin = node.pins.find_or_initialize_by pin_data.slice(:number)
          pin.mode = pin_data[:mode]
          pin.type = pin_data[:type]
          pin.save
        end
      end
    end
  end
end
