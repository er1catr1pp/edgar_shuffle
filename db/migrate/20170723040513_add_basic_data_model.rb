class AddBasicDataModel < ActiveRecord::Migration[5.1]
  def change

    # a user's connected account
    # (e.g. a twitter account or facebook page)
    create_table :accounts do |t|

      t.string  :username
      t.string  :avatar
      t.integer :user_id
      t.integer :provider_id

      t.timestamps
    end

    add_index :accounts, [:user_id]
    add_index :accounts, [:provider_id]

    # content categories
    create_table :categories do |t|

      t.string    :name
      t.string    :color
      t.boolean   :is_shuffled, :default => false
      t.datetime  :last_unshuffled_time
      t.integer   :user_id

      t.timestamps
    end

    add_index :categories, [:user_id]

    # a piece of content that may be 
    # distributed 0 or more times via
    # 0 or more accounts
    create_table :contents do |t|

      t.text      :text
      t.string    :image
      t.integer   :category_id

      t.timestamps null: false

    end

    # microsecond timestamps are required to protect against ordering
    # issues for contents created within the same second during seed
    change_column :contents, :created_at, :datetime, limit: 6
    change_column :contents, :updated_at, :datetime, limit: 6

    add_index :contents, [:category_id]

    # join table that contains which contents
    # are distributed via which accounts
    create_table :distributions do |t|

      t.integer :account_id
      t.integer :content_id

      t.timestamps
    end

    add_index :distributions, [:account_id]
    add_index :distributions, [:content_id]

    # a piece of content that has or is scheduled
    # to be distributed via a particular account
    create_table :posts do |t|

      t.datetime  :distribution_time
      t.integer :distribution_id
      t.integer :schedule_assignment_id

      t.timestamps null: false
    end

    change_column :posts, :created_at, :datetime, limit: 6
    change_column :posts, :updated_at, :datetime, limit: 6

    add_index :posts, [:distribution_id]
    add_index :posts, [:schedule_assignment_id]


    # social media provider (e.g. Facebook, Twitter)
    create_table :providers do |t|

      t.string  :name
      t.string  :icon

      t.timestamps
    end

    # recurring weekday/time at which to send content
    # from the associated category
    create_table :schedules do |t|

      # numbered weekday in UTC from 0 (sun) to 6 (sat)
      t.integer :send_on 

      # seconds after midnight UTC
      t.integer :send_at

      t.integer :category_id

      t.timestamps
    end

    add_index :schedules, [:category_id]

    # which accounts are to be posted to for a given schedule
    create_table :schedule_assignments do |t|

      t.integer :account_id 
      t.integer :schedule_id

      t.timestamps
    end

    add_index :schedule_assignments, [:account_id]
    add_index :schedule_assignments, [:schedule_id]

    # an edgar_shuffle customer
    create_table :users do |t|

      t.string  :first_name
      t.string  :last_name

      # rails time zone name like "Pacific Time (US & Canada)" 
      t.string  :time_zone

      t.timestamps
    end

  end
end
