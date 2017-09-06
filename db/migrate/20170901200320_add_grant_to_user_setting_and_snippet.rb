class AddGrantToUserSettingAndSnippet < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :grant_id, :integer, :references => "grants"
    add_column :settings, :grant_id, :integer, :references => "grants"
    add_column :snippets, :grant_id, :integer, :references => "grants"
  end
end
