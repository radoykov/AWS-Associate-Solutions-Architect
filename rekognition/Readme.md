# Create bucket and upload file
```sh
aws s3 mb s3://rekog-example-7667
aws s3 cp elon.png s3://rekog-example-7667
```

# Run ruby code
```sh
bundle install
bundle exec ruby main.rb
# /snap/bin/ruby main.rb
```
