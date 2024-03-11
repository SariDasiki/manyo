FactoryBot.define do
  factory :user do
    name { 'eeee' }
    email { 'eeee@gmail.com' }
    password { 'eeee@gmail.com' }
    admin { 'true' }
  end

  factory :second_user, class: User do
    name { 'ffff' }
    email { 'ffff@gmail.com' }
    password { 'ffff@gmail.com' }
    admin { 'false' }
  end

  factory :third_user, class: User do
    name { 'hhhh' }
    email { 'hhhh@gmail.com' }
    password { 'hhhh' }
    admin { 'false' }
  end

  factory :fourth_user, class: User do
    name { 'hhhh' }
    email { 'hhhh@gmail.com' }
    password { 'hhhh@gmail.com' }
    admin { 'false' }
  end

  factory :fifth_user, class: User do
    name { 'cccc' }
    email { 'cccc@gmail.com' }
    password { 'cccc@gmail.com' }
    admin { 'false' }
  end
end
