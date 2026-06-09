require 'aws-sdk-s3'
require 'pry'
require 'securerandom'

bucket_name = ENV['BUCKET_NAME']
region = 'eu-west-1'
puts bucket_name

client = Aws::S3::Client.new

resp = client.create_bucket({
    bucket: bucket_name,
    create_bucket_configuration: {
        location_constraint: region
    }
})

# binding.pry #debug

number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"

number_of_files.times.each do |i|
    puts "i : #{i}"
    filename = "file_#{i}.txt"
    output_file = "/tmp/#{filename}"

    File.open(output_file, "w") do |f|
        f.write SecureRandom.uuid
    end

     File.open(output_file, "rb") do |file|
        client.put_object(
            bucket: bucket_name,
            key: filename,
            body: file
        )
    end
end