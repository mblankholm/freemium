class CreateSubscriptionAndPlan < ActiveRecord::Migration
  def self.up
    create_table :subscription_plans, :force => true do |t|
      t.column :name, :string, :null => false
      t.column :rate_cents, :integer, :null => false
      t.column :yearly, :boolean, :null => false
    end

    create_table :subscriptions, :force => true do |t|
      t.column :subscribable_id, :integer, :null => false
      t.column :subscribable_type, :string, :null => false
      t.column :subscription_plan_id, :integer, :null => false
      t.column :paid_through, :date, :null => false
      t.column :expire_on, :date, :null => true
      t.column :billing_key, :string, :null => true
      t.column :last_transaction_at, :datetime, :null => true
    end

    add_index :subscriptions, :account_id
    add_index :subscriptions, :account_type
    add_index :subscriptions, :paid_through
  end

  def self.down
    drop_table :subscription_plans
    drop_table :subscriptions
  end
end