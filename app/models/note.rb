# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  user_id    :integer          not null
#  track_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Note < ApplicationRecord
  validates :content, presence: true

  belongs_to :author,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :track

  def author_email
    author.email
  end
end
