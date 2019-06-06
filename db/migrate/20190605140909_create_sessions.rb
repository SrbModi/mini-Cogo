class CreateSessions < ActiveRecord::Migration[5.0]
  def up
    create_table :sessions, id: :uuid do |t|
      t.references :user,       type: :uuid, null: false, index: { name: :'user_idx' }
      t.datetime :expiry_time,                                null: false
      t.column :token, 'VARCHAR(20)',       null: false

      t.timestamps
    end

    add_foreign_key(:sessions, :users, column: :user_id) #(:from, :to, :foreign key)
  end

  def down
    drop_table :sessions
  end
end