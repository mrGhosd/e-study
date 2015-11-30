class Api::ApiController < ApplicationController
  include JsonWebToken
  include SessionConcern
  respond_to :json
  
end
