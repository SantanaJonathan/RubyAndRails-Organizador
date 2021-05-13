# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
    has_many :tasks

    #validar que esten los campos llenos
    validates :name, :description, presence: true
    #validar la unicidad de los datos// case_.. para que no djen pasar entre mayuscula y minuscula
    validates :name, uniqueness: {case_insensitive: false}
    
end
