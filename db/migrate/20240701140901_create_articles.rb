class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.uuid :id
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
