require 'aws-sdk-s3' 
Aws.config.update({    
   region: ENV['AWS_S3_REGION'],    
   credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID_IAM'], ENV['AWS_SECRET_ACCESS_KEY_IAM'])  })
S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['ASSET_S3_BUCKET'])
