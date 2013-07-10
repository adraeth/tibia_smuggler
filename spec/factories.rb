FactoryGirl.define do
  factory :user do
    name     'Michael Hartl'
    email    'michael@example.com'
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :news do
    date_to_show  Time.now
    title         'Default title'
    content       'Default content for a TibiaSmuggler news'
  end

  factory :login_attempt do
    ip      '127.0.0.1'
    login   'user@example.com'
  end

  factory :world_type do
    name  'Testional-PvP'
    initialize_with { WorldType.find_or_create_by_name(name) }
  end

  factory :world do
    name      'Yalahar'
    location  'EU'
    account   1
    blocked_for_incoming  false
    blocked_for_outgoing  false
    amount    1_000_000
    rate      1.2
    association :world_type
  end

  factory :rate do
    association     :from_world_type, factory: :world_type
    association     :to_world_type, factory: :world_type
    rate            1.0
    reducible       true
    reduction_step  0.05
  end

  factory :permission do
    name  'can_test_permissions'
  end

  factory :order_status do
    text  'Testing'
  end

  factory :order do
    user
    order_status
    association     :world_from, factory: :world, name: 'Orderya'
    association     :world_to, factory: :world, name: 'Orderia'
    amount_to       50_000
    character_from  'Korni'
    character_to    'Mystie'
  end
end