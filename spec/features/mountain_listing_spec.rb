require 'spec_helper'

feature 'mountain listings' %q{
  As a hiker
  I want to be able to pull up a list of mountains I've already summited and mountains I have yet to summit
  So that I can geek out over my peakbagging progress, recall past hikes, and identify mountains I might want to climb in the future
} do 
  # Acceptance Criteria:
  # * I can view a sortable list of all the mountains covered by the app
  # * In the list mountains are marked depending on whether they've been hiked and completed, hiked but not completed (attempted), or not attempted
  # * I can view a list of mountains I have summited
  # * I can view a list of the mountains I have not yet summited
  # * The date of the most recent summit or summit attempt is displayed
  scenario 'user looks at a list of all the mountains on the site'
  
  end

  scenario 
end

end