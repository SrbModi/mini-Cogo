

class CreateBookings < ActiveRecord::Migration[5.0]
  def up
    create_table :bookings, id: :uuid do |t|
      t.references :user,              type: :uuid, null: false, index: { name: :'user_id_idx' }
      t.references :origin_port,       type: :uuid, null: false, index: { name: :'origin_port_id_idx' }
      t.references :destination_port,  type: :uuid, null: false, index: { name: :'destination_port_id_idx' }
      t.integer :result_id,                               null: false
      t.integer :price,                                   null: false
      t.column :status,   'VARCHAR(32)',                  null: false
      t.column :currency, 'VARCHAR(4)',                   null: false

      t.timestamps
    end
    add_foreign_key(:bookings, :users, column: :user_id)
    add_foreign_key(:bookings, :locations, column: :origin_port_id)
    add_foreign_key(:bookings, :locations, column: :destination_port_id)
  end

  def down
    drop_table :bookings
  end
end