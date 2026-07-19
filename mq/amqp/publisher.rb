require 'bunny'

connection_string = "amqps://b-0e07e341-5d7e-4766-86a3-8ba7ed62b6b4.mq.eu-west-1.on.aws:5671"
connection = Bunny.new(connection_string)
connection.start

channel = connection.create_channel
queue = channel.queue('hello')
exchange = channel.default_exchange

begin
  exchange.publish("Hello World!", routing_key: queue.name)
  channel.close
  connection.close
rescue => e
  puts e.inspect
  channel.close if channel
  connection.close if connection
  exit(0)
end
