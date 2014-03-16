
class ServerLocation < ActiveRecord::Base
  self.table_name = 'server_location'
end

class Locator < ActiveRecord::Base
  self.table_name = 'locator'
  validates :resource, :ro, :rw, :dbname, :server_location_id, presence: true
end
