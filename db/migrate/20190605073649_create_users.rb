class CreateUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :users, id: :uuid do |t|
      t.column :name,           'VARCHAR(127)',       null: false
      #another way -> t.string: name, limit: <optional, default:unlimited>
      t.column :email,          'VARCHAR(127)',       null: false
      t.column :phone_no,       'VARCHAR(127)',       null: false
      t.column :status,         'VARCHAR(127)',       null: false
      t.column :company_name,   'VARCHAR(127)',       null: false
      t.column :password,       'VARCHAR(127)',       null: false

      t.string :user_profile_pic_url

      t.timestamps #created at, and updated at
    end
    execute <<-SQL
      CREATE UNIQUE INDEX users_email_idx ON users(email);
    SQL
  end

  def down
    drop_table table_name :users
  end

end
