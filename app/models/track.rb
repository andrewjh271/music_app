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
class Track < ApplicationRecord
  validates :title, :ord, presence: true
  validates :ord, uniqueness: { scope: :album_id }
  validates :bonus, inclusion: { in: [true, false] }

  belongs_to :album
  has_one :band, through: :album
  has_many :notes, dependent: :destroy

  def album_title
    album.title
  end

  def band_name
    album.band_name
  end
end
