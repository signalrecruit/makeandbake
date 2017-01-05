if Rails.env.production?
	CarrierWave.configure do |config|
		# config.fog_provider = 'fog/aws'
		config.fog_credentials = {
			#Configuration for Amazon S3
			:provider		=> 'AWS',
			:aws_access_key_id		=> ENV['AWS_ACCESS_KEY_ID'],
			:aws_secret_access_key 	=> ENV['AWS_SECRET_ACCESS_KEY']
		}
		config.fog_directory= ENV['S3_BUCKET_NAME']
	end
end

# if Rails.env.test? || Rails.env.cucumber?
#   CarrierWave.configure do |config|
#     config.storage = :file
#     config.enable_processing = false
#   end

#   # make sure our uploader is auto-loaded
#   ImageUploader
#   ShopImageUploader
#   AttachmentUploader


#   # use different dirs when testing
#   CarrierWave::Uploader::Base.descendants.each do |klass|
#     next if klass.anonymous?
#     klass.class_eval do
#       def cache_dir
#         "#{Rails.root}/spec/support/uploads/tmp"
#       end

#       def store_dir
#         "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
#       end
#     end
#   end
# end