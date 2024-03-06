require 'rails_helper'

RSpec.describe "タスク管理機能", type: :system do
  describe '一覧表示機能'do
    describe 'ソート機能'do
      let!(:first_task) { FactoryBot.create(:task, title: 'first_task_title') }
      let!(:second_task) { FactoryBot.create(:second_task, title: "second_task_title") }
      let!(:third_task) { FactoryBot.create(:third_task, title: "third_task_title") }

      context '「終了期限」というリンクをクリックした場合'do
        before do
          visit tasks_path
        end
     
        it "終了期限昇順に並び替えられたタスク一覧が表示される"do
          click_link("終了期限")
          sleep 0.1
          task_list = all('body tr')
          # 複数のテストデータの並び順を確認する
          expect(task_list[1].text).to have_content(third_task.title)
        end
      end

      context '「優先度」というリンクをクリックした場合'do
        before do
          visit tasks_path
        end
      
        it "優先度の高い順に並び替えられたタスク一覧が表示される" do
          click_link("優先度")
          task_list = all('body tr')
          # 複数のテストデータの並び順を確認する
          expect(task_list[1].text).to have_content(first_task.title)
        end
      end
    end

    describe '検索機能'do
      let!(:first_task) { FactoryBot.create(:task, title: 'first_task_title') }
      let!(:second_task) { FactoryBot.create(:second_task, title: "second_task_title") }
      let!(:third_task) { FactoryBot.create(:third_task, title: "third_task_title") }

      context 'タイトルであいまい検索をした場合'do
        before do
          visit tasks_path
        end

        it "検索ワードを含むタスクのみ表示される"do
          fill_in 'search[title]', with: 'first'
          click_button("検索する")
          expect(page).to have_content(first_task.title)
        end
      end

      context 'ステータスで検索した場合'do
        before do
          visit tasks_path
        end
        it "検索したステータスに一致するタスクのみ表示される" do
          select "完了"
          click_button("検索する")

          expect(page).to have_content(third_task.title)
        end
      end

      context 'タイトルとステータスで検索した場合'do
        before do
          visit tasks_path
        end  

        it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
          fill_in 'search[title]', with: 'first'
          select "未着手"
          click_button("検索する")
          expect(page).to have_content(first_task.title)
        end

      end
    end
  end

end

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

  