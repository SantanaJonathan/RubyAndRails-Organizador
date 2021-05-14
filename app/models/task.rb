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
#  owner_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_category_id  (category_id)
#  index_tasks_on_owner_id     (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (owner_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user #conectado a la relacion con participantes(user)

  validates :participating_users, presence: true

  #validar que esten los campos llenos
  validates :name, :descripction, presence: true
  #validar la unicidad de los datos// case_.. para que no djen pasar entre mayuscula y minuscula
  validates :name, uniqueness: {case_insensitive: false}
    
  #validacion personalizada para la due_date(fecha de vencimiento)
  validate :due_date_validity

  def due_date_validity
    return if due_date.blank?#si esta en blanco
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end

end
