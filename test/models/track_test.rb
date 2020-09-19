# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  ord        :integer          not null
#  lyrics     :text
#  bonus      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer          not null
#
require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
