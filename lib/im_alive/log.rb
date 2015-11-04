require 'couchrest'

module ImAlive
  class Log
    def initialize(db, document_path)
      @db = db
      @document_path = document_path
    end

    def send
      client.put(document_url, payload)
    end

    private

    attr_reader :db, :document_path

    def document_url
      "#{db}/#{document_path}"
    end


    def client
      CouchRest
    end

    def payload
      timestamps = {
        "timestamp"=> Time.now.to_s,
        "js_timestamp" => Time.now.to_i,
      }
      timestamps.merge!("_rev" => rev) if rev
      timestamps
    end

    def rev
      payload = client.get(document_url)
      payload['_rev']
    rescue RestClient::ResourceNotFound
      nil
    end

  end
end
