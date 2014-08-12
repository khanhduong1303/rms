class PublicFunction < ActiveRecord::Base
  def self.data_json status, message, total, results=nil
    return {:status => status, :message => message, :total => total, :data => results}
  end
end
