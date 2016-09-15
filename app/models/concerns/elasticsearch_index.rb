module ElasticsearchIndex

  def rebuild_index
    delete_index
    create_new_index
    import_index
  end


  private

  def delete_index
    self.__elasticsearch__.client.indices.delete index: self.index_name rescue nil
  end

  def create_new_index
    self.__elasticsearch__.client.indices.create index: self.index_name,
                                                   body: { settings: self.settings.to_hash,
                                                           mappings: self.mappings.to_hash } rescue nil
  end

  def import_index
    self.import rescue nil
  end
end
