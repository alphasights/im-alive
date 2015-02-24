require 'spec_helper'

describe Log do
 before do
   VCR.insert_cassette 'send'
 end

 after do
   VCR.eject_cassette
 end

 it 'sends the correct payload to the specfied url', :vcr do
   logger = Log.new(task: 'pistachio-slice', app: 'polly-production', url: 'http://document.store/polly')

   logger.send
 end
end
