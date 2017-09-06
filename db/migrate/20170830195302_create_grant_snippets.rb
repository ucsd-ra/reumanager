class CreateGrantSnippets < ActiveRecord::Migration[5.1]
  def change
    create_table :grant_snippets do |t|
      t.text :general_desc
      t.text :highlights
      t.text :eligibility
      t.references :grant, foreign_key: true

      t.timestamps
    end
  end
end
