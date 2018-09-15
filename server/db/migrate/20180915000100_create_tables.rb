class CreateTables < ActiveRecord::Migration[5.2]
  def change # rubocop:disable Metrics/AbcSize
    create_table :users do |t|
      t.integer :uid,            null: false, index: { unique: true }
      t.string  :nickname,       null: false
      t.string  :image_url,      null: true
      t.integer :role,           null: false, default: 0, limit: 1
      t.integer :comments_count, null: false, default: 0
      t.integer :likes_count,    null: false, default: 0
      t.string  :remember_token, null: false, index: { unique: true }

      t.timestamps
    end

    create_table :issues do |t|
      t.references :user, foreign_key: true, null: false

      t.string  :subject,        null: false
      t.text    :description,    null: false
      t.integer :comments_count, null: false, default: 0
      t.integer :likes_count,    null: false, default: 0
      t.boolean :secret,         null: false, default: false

      t.timestamps
    end

    create_table :comments do |t|
      t.references :user,  foreign_key: true, null: false
      t.references :issue, foreign_key: true, null: false

      t.text    :content,     null: false
      t.integer :likes_count, null: false, default: 0
      t.boolean :secret,      null: false, default: false

      t.timestamps
    end

    create_table :likes do |t|
      t.references :user,     foreign_key: true, null: false, index: false
      t.references :likeable, polymorphic: true, null: false, index: true

      t.timestamps
    end

    add_index :likes, [:user_id, :likeable_type, :likeable_id], unique: true, name: "index_likes_for_uniqueness"
  end
end
