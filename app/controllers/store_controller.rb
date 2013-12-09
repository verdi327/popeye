class StoreController < ApplicationController
  def index
  end

  def beginner
    @program = Program.beginner_programs.first
  end
end
