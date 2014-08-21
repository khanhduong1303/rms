class PublicFunction < ActiveRecord::Base
  def self.data_json status, message, total, results=nil
    return {:status => status, :message => message, :total => total, :results => results}
  end
end
