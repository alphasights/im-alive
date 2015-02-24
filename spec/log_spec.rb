require 'spec_helper'

module ImAlive
  describe Log do
    it 'sends the correct payload to the specfied url' do
      rest_client = MiniTest::Mock.new
      url = 'http://document.store/polly'
      logger = Log.new(task: 'pistachio-slice', app: 'polly-production', url: url)

      Timecop.freeze '1st Feb 2015' do
        logger.stub :client, rest_client do
          rest_client.expect :get, {'_rev' => '1234'}.to_json, [url]
          rest_client.expect :put, true, [url, {'_rev' => '1234', app: "polly-production", timestamp: "2015-02-01 00:00:00 +0000", js_timestamp: 1422748800, task: "pistachio-slice"}.to_json]

          logger.send

          rest_client.verify
        end
      end
    end
  end
end
