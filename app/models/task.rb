class Task < ApplicationRecord
  belongs_to :user
  
  has_many :task_labels
  has_many :labels, through: :task_labels

  validates :title, presence:true
  validates :content, presence: true
  validates :deadline_on, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum priority: {
   低: 0,
   中: 1,
   高: 2,
  },
   _prefix: true
  enum status: {
    未着手: 0,
    着手中: 1,
    完了: 2,
  }

  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") }
  scope :status_search, -> (status) { where(status: status) }
  
  scope :sort_deadline_on, -> (deadline_on) {
    deadline_on ? order(deadline_on: :asc) : self
  }
  scope :sort_priority, -> (priority) {
    priority ? order(priority: :desc) : self # 呼び出し元のデータを返す
  }

  scope :label_tag, -> (label) { joins(:labels).where(labels: {id: label}) }
  # タスクテーブルにラベルテーブルのデータをくっつけてから、検索機能を作っている
# PGには検索用のみが必要で、ユーザーには名前:表示用がいるから、id:検索用で分けて調べた
end
