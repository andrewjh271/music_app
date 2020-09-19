# == Schema Information
#
# Table name: albums
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  year       :integer          not null
#  band_id    :integer          not null
#  live       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Album < ApplicationRecord
  validates :title, :year, presence: true
  validates :live, inclusion: { in: [true, false] }

  belongs_to :band
  
  def band_name
    band.name
  end
end
