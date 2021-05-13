# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  descripction :text
#  due_date     :date
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint           not null
#
# Indexes
#
#  index_tasks_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Task < ApplicationRecord
  belongs_to :category
end
