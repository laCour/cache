require 'block_io'

begin
  BlockIo.set_options :api_key=> ENV['BLOCKIO_KEY'], :pin => ENV['BLOCKIO_PIN'], :version => 2
rescue TypeError
  raise 'Block.io key or pin environment variables not set.'
else
  Rails.logger.warn 'Unable to reach block.io.'
end