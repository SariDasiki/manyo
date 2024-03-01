require 'rails_helper'

RSpec.describe "タスク管理機能", type: :system do

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      let!(:task1) { FactoryBot.create(:task, title: 'task_title', created_at:'2030-01-13') }
      let!(:task) { FactoryBot.create(:second_task, title: 'task_title', created_at: '2024-02-24') }
      before do
        visit tasks_path
      end
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
        task_list = all('body tr')
        # データを全部調べ、一番先頭のデータをとってくる
        expect(task_list[1].text).to have_content(task1.created_at)
        # expect(page).to match(/#{task.created_at}.*#{second_task.created_at}/)
      end
    end
   
    context '一覧画面に遷移した場合' do
      let!(:task1) { FactoryBot.create(:task, title: 'task_title') }
      let!(:task2) { FactoryBot.create(:second_task, created_at: '2025-02-24') }
      before do
        visit tasks_path
      end
      it '作成済みのタスク一覧が表示される' do
        task_list = all('body tr')

        expect(task_list.size - 1).to eq Task.count

      end
    end
   
    context '新たにタスクを作成した場合' do
      let!(:task) { FactoryBot.create(:task, title: 'task_title') }

      before do
        visit new_task_path
        fill_in 'task[title]', with: "task_title"
        fill_in 'task[content]', with: "test_ok"
        click_button("登録する")
      end

      it '新しいタスクが一番上に表示される' do
        task_list = all('body tr')
        expect(task_list[1].text).to have_content("test_ok")  
      end
    end

  end
end