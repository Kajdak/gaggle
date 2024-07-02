class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs, id: :uuid do |t|
      t.string :ip, null: false
      t.string :input

      t.timestamps
    end
  end
end
