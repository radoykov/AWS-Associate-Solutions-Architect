require 'aws-sdk-secretsmanager'
require 'pry'

def get_secret
  client = Aws::SecretsManager::Client.new(region: 'eu-west-1')

  begin
    get_secret_value_response = client.get_secret_value(secret_id: 'MySecret-RuV3HAAeO2Dy')
  rescue StandardError => e
    raise e
  end

  secret = get_secret_value_response.secret_string
  binding.pry
end
