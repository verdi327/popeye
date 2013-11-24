class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def formatted_date
    date = created_at
    date.strftime("%a, %b #{date.day.ordinalize} %Y")
  end
end
