require 'mongo'
require 'pry'

Mongo::Logger.logger.level = ::Logger::INFO

client = Mongo::Client.new(
  'mongodb://docadmin:password@mydocumentdb-982383527471.us-east-1.docdb-elastic.amazonaws.com:27017',
  tls: true,
  tlsAllowInvalidHostnames: true,
  database: 'test'
)

db = client.database
collection = client[:people]

def insert_one(collection)
  doc = {
    name: 'Steve',
    hobbies: ['hiking', 'tennis', 'fly fishing'],
    siblings: {
      brothers: 0,
      sisters: 1
    }
  }
  result = collection.insert_one(doc)
  puts result.n
  binding.pry
end

def insert_many(collection)
  docs = [
    {
      _id: 1,
      name: 'Steve',
      hobbies: ['hiking', 'tennis', 'fly fishing'],
      siblings: { brothers: 0, sisters: 1 }
    },
    {
      _id: 2,
      name: 'Sally',
      hobbies: ['skiing', 'stamp collecting'],
      siblings: { brothers: 1, sisters: 0 }
    }
  ]
  result = collection.insert_many(docs)
  puts result.inserted_count
  binding.pry
end

def query_collection(client)
  collection = client[:people]
  collection.find.each do |document|
    puts document.inspect
  end
  binding.pry
end

# insert_one(collection)
# insert_many(collection)
# query_collection(client)
