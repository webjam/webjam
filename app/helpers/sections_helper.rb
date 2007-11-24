module SectionsHelper
  def class_for_section(section, class_name="current")
    section.to_s == @section.to_s ? class_name : nil
  end
  def event_section(event)
    "event_#{event.id}"
  end
end
