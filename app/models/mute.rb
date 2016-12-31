class Mute < ActiveRecord::Base
  belongs_to :muting_user,  class_name: "User"
  belongs_to :muted_user,   class_name: "User"
end
