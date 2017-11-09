require 'couchrest'

module ImAlive
  class Log
    def initialize(db_uri, document_id)
      @db_uri = db_uri
      @document_id = document_id
    end

    def send
      doc = begin
        db.get!(document_id)
      rescue CouchRest::NotFound
        {'_id' => document_id}
      end
      doc.merge!(timestamps)
      db.save_doc(doc)
    end

    private

    attr_reader :db_uri, :document_id

    def db
      @db ||= CouchRest.database!(db_uri)
    end

    def timestamps
      {
        "timestamp" => Time.now.utc.to_s,
        "js_timestamp" => Time.now.utc.to_i,
      }
    end

  end
end
