## Create a new s3 bucket

```md
aws s3 mb s3://checksum.example.ar
```

## Create a file that we will do a checksum on 

```
echo "Hello World" > myfile.txt
```

## Get a checksum of a file for md5

```md
md5sum myfile.txt
# e59ff97941044f85df5297e1c302d260  myfile.txt
```

## Upload our file and look at its etag

```
aws s3 cp myfile.txt s3://checksum.example.ar
aws s3api head-object --bucket checksum.example.ar --key myfile.txt
```

## Lets uplad a file with different type of checksum

```sh
sudo apt-get install rhash
rhash --crc32 --simple myfile.txt
```

```
bundle exec ruby crc.rb
```

```sh
aws s3api put-object \
--bucket checksum.example.ar \
--key myfilecrc32.txt \
--body myfile.txt \
--checksum-algorithm="SHA1" \
--checksum-sha1=$(openssl dgst -sha1 -binary myfile.txt | openssl enc -base64)

```