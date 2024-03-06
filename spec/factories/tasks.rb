FactoryBot.define do
  factory :task do
    title       { "first_task" }
    content { '顧客へ営業のメールを送る。' }
    priority { '中' }
    status { '未着手' }
    created_at  { "2022-02-18" }
    deadline_on { "2024-05-18" }
  end

  factory :second_task, class: Task do
    title       { "second_task" }
    content { '顧客へ営業のメールを送る。' }
    priority { '高' }
    status { '着手中' }
    created_at  { "2022-02-17" }
    deadline_on { "2024-05-17" }
  end
  factory :third_task, class: Task do
    title       { "third_task" }
    content { '顧客へ営業のメールを送る。' }
    priority { '低' }
    status { '完了' }
    created_at  { "2022-02-16" }
    deadline_on { "2024-05-16" }
  end
end
