require 'elasticsearch/model'

class Country < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end

# Delete the previous articles index in Elasticsearch
Country.__elasticsearch__.client.indices.delete index: Country.index_name

# Create the new index with the new mapping
Country.__elasticsearch__.client.indices.create index: Country.index_name, body:
                                                {
                                                  settings: Country.settings.to_hash,
                                                  mappings: Country.mappings.to_hash
                                                }
Country.import
