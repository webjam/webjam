class AddEventsMapIframeUrlMapUrl < ActiveRecord::Migration
  def self.up
    add_column :events, :map_iframe_url, :string
    add_column :events, :map_url, :string
    Event.update_all({:map_iframe_url => "http://www.openstreetmap.org/export/embed.html?bbox=151.20587,-33.86999,151.21233,-33.86512&layer=mapnik", :map_url => "http://www.openstreetmap.org/?lat=-33.86756&lon=151.20909&zoom=17&lay"})
  end

  def self.down
    remove_column :events, :map_url
    remove_column :events, :map_iframe_url
  end
end
