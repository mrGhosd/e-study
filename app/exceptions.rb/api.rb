module Api
  class Error < ::Exception

    attr_reader :status
    attr_reader :addition

    def initialize(message, status, addition = false)
      super(message)
      @status = status
      @addition = addition
    end
  end
end
