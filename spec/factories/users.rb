FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { '1a1a1a' }
    password_confirmation { '1a1a1a' }
    last_name_full { Gimei.last.kanji }
    first_name_full { Gimei.first.kanji }
    last_name_kana { Gimei.last.katakana }
    first_name_kana { Gimei.first.katakana }
    birthday { '1993-04-13' }
  end
end
