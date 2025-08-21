require 'yaml'

class AddNewGenders < ActiveRecord::Migration[8.0]
  def up
    genders = YAML.load_file(Rails.root.join('test', 'fixtures', 'genders.yml'))
    genders.each do |gender|
      next unless gender[1]['id'] && gender[1]['id'].to_i >= 4
      Gender.find_or_create_by(label: gender[1]['label'])
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
