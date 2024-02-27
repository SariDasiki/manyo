require 'rails_helper'

RSpec.describe "タスク管理機能", type: :system do

  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        # ここで新規作成ページに入れたいデータを入れる
        visit tasks_path(task)
        fill_in 'task[title]', with: "書類作成"
        fill_in 'task[content]', with: "企画書を作成。"
        expect(page).to have_content '企画書を作成'
      end
    end
  end

  describe '一覧表示機能'do
    context '一覧画面に遷移した場合'do
      it '登録したタスクが表示される'do
        Task.create!(title: '書類作成', content: '企画書を作成する。')
        visit tasks_path(@task)
        expect(page).to have_content '書類作成'
      end
    end
  end

  describe '詳細表示機能'do
    context '任意のタスク詳細画面に遷移した場合'do
      it '登録したタスクが表示される'do
         visit task_path(@task)
         expect(page).to have_content '書類作成'
      end
    end
  end

end