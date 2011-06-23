class HelpResponsesController < InheritedResources::Base
  respond_to :xml, :json, :html
end