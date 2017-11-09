require 'spec_helper'

module ImAlive
  describe Log do
    it 'sends the correct payload to the specfied url' do
      rest_client = MiniTest::Mock.new
      url = 'http://document.store/backups'
      logger = Log.new(url, 'polly')

      Timecop.freeze Time.utc(2015, 02, 1, 0, 0, 0) do
        logger.stub :db, rest_client do
          rest_client.expect :get!, {}, ['polly']
          rest_client.expect :save_doc, {}, [{"timestamp" => "2015-02-01 00:00:00 UTC", "js_timestamp" => 1422748800}]

          logger.send

          rest_client.verify
        end
      end
    end
  end
end
