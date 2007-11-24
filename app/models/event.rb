class Event < ActiveRecord::Base
  has_many :rsvps
  has_many :jams
  has_many :jam_proposals

  def self.find_upcoming(*options)
    with_scope(:find => {:conditions => ['held_at >= ?', Time.now.utc]}) { find(*options) }
  end
  def self.find_past(*options)
    with_scope(:find => {:conditions => ['held_at < ?', Time.now.utc]}) { find(*options) }
  end
  def upcoming?
    self.held_at >= Time.now.utc
  end
  def past?
    !upcoming?
  end
  def to_s
    "#{city} (#{held_at.to_date.to_s(:short)})"
  end

  %w(rsvps jams).each do |assoc_name|
    eval <<-CODE
    def #{assoc_name.singularize}_status
      if #{assoc_name}_closed?
        :closed
      elsif #{assoc_name}_full?
        :full
      else
        :open
      end
    end
    def #{assoc_name}_closed?
      (start_on = #{assoc_name.singularize}_registration_starts_on) && start_on.to_time < Time.now.utc
    end
    def #{assoc_name}_full?
      #{assoc_name}.count >= #{assoc_name.singularize}_slots
    end
    def #{assoc_name}_open?
      !#{assoc_name}_closed? && !#{assoc_name}_full?
    end
CODE
  end
end