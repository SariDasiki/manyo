FactoryBot.define do
  factory :task do
    title       { "first_task" }
    content { '顧客へ営業のメールを送る。' }
    created_at  { "2022-02-18" }
  end
  factory :second_task, class: Task do
    title       { "second_task" }
    content { '顧客へ営業のメールを送る。' }
    created_at  { "2022-02-17" }
  end
  factory :third_task, class: Task do
    title       { "third_task" }
    content { '顧客へ営業のメールを送る。' }
    created_at  { "2022-02-16" }
  end
end
