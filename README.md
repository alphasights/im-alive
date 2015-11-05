# Im::Alive

Post timestamps to a CouchDB database document. Useful for sending heartbeat signals or proving that a certain operation took place when it was supposed to. 

The timestamp information that is written is: 

`{"timestamp" => "2015-02-01 00:00:00 UTC", "js_timestamp" => 1422748800}`

CouchDB documents can be acessed through HTTP Get, no special tooling is required to read the values back out, you can use Curl, do it from JS in a web page, from any programming language you can think of etc etc. 

## Installation

gem install im-alive

## Usage

`im-alive https://username@password.heroku.cloudant.com/backups weekly`

of which 
- `https://username@password.heroku.cloudant.com` is the URL of the CouchDB instance
- `backups` is the name of the CouchDB database. The database will be automatically created if it doesn't exist.
- `weekly` it the name of the document to write the timestamps to. The document is created if it doesn't exist.
