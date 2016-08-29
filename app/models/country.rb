# frozen_string_literal: true
require 'elasticsearch/model'

class Country < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :name, type: :string
      indexes :phone_code, type: :string
    end
  end
end

# Delete the previous articles index in Elasticsearch
Country.__elasticsearch__.client.indices.delete index: Country.index_name rescue nil

# Create the new index with the new mapping
Country.__elasticsearch__.client.indices.create index: Country.index_name, body:
                                                {
                                                  settings: Country.settings.to_hash,
                                                  mappings: Country.mappings.to_hash
                                                }
Country.import
