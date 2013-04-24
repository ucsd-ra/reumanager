class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :known_applicant_for
      t.string :known_capacity
      t.string :overall_promise
      t.string :undergraduate_institution
      t.text :body
      t.string :token
      t.datetime :token_created_at
      t.datetime :request_sent_at
      t.datetime :received_at
      t.integer :applicant_id
      t.integer :recommender_id

      t.timestamps
    end
  end
end
