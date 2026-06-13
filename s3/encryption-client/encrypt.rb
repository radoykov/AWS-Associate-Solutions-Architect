require 'openssl'
require 'aws-sdk-s3'

# Client-side encryption key. RSA key pair; 2048-bit minimum (1024 is weak).
encryption_key = OpenSSL::PKey::RSA.new(2048)

bucket     = 'my-ar'
object_key = 'hello.txt'

# Encryption client: encrypts locally before upload, decrypts locally on download.
s3 = Aws::S3::EncryptionV2::Client.new(
  region:                    'eu-west-1',
  encryption_key:            encryption_key,
  key_wrap_schema:           :rsa_oaep_sha1,      # :aes_gcm if you use a symmetric key
  content_encryption_schema: :aes_gcm_no_padding,
  security_profile:          :v2                  # :v2_and_legacy to also read older objects
)

# Round-trip: encrypted on put, decrypted on get — all client-side.
s3.put_object(bucket: bucket, key: object_key, body: 'handshake')
puts s3.get_object(bucket: bucket, key: object_key).body.read
#=> 'handshake'

# A plain client (no encryption materials) sees only the ciphertext.
puts Aws::S3::Client.new(region: 'eu-west-1')
       .get_object(bucket: bucket, key: object_key).body.read