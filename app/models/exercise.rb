class Exercise < ActiveRecord::Base
  belongs_to :workout

  def routine
    "#{sets}x#{reps}"
  end
end
