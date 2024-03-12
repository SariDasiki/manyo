require 'rails_helper'

# RSpec.describe 'ユーザ管理機能', type: :system do
#    describe '登録機能'do
#      context 'ユーザを登録した場合'do
#       let!(:second_user) { FactoryBot.create(:second_user) }
     
#       before do
#        visit new_user_path
#        fill_in 'user[name]', with: "ffff"
#        fill_in 'user[email]', with: "ffff@gmail.com"
#        fill_in 'user[password]', with: "ffff@gmail.com"
#        fill_in 'user[password_confirmation]', with: "ffff@gmail.com"
#        click_button("登録する")
#       end
     
#        it 'タスク一覧画面に遷移する'do
#         expect(current_path).to eq users_path
#        end
#     end
#      context 'ログインせずにタスク一覧画面に遷移した場合'do
#        before do
#         visit tasks_path
#        end
#         it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
#           expect(page).to have_content("ログインしてください")  
#         end
#      end
#    end
      
#    describe 'ログイン機能'do
#      context '登録済みのユーザでログインした場合'do
#         let!(:second_user) { 
#           FactoryBot.create(:second_user)
#         }
#         let!(:fourth_user) { 
#           FactoryBot.create(:fourth_user)
#         }
#        before do
#          visit new_session_path
#          fill_in 'session[email]', with: "ffff@gmail.com"
#          fill_in 'session[password_digest]', with: "ffff@gmail.com"
#          click_button("ログイン")
#        end
#          it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される'do
#            expect(page).to have_content("ログインしました")  
#          end
#          it '自分の詳細画面にアクセスできる'do
#            click_link("アカウント設定")
#            expect(page).to have_content("アカウント詳細ページ") 
#          end
#          it '他人のユーザ詳細画面にアクセスすると、タスク一覧画面に遷移する'do
#           visit user_path(fourth_user)
#           expect(current_path).to eq tasks_path
#          end
#          it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される'do
#           click_link("ログアウト")
#           expect(page).to have_content("ログアウトしました")   
#          end
#      end
#   end

#   describe '管理者機能'do
#     context '管理者がログインした場合'do

#     let!(:user) { FactoryBot.create(:user) }
#     let!(:second_user) { FactoryBot.create(:second_user) } 
     
#     before do
#       visit new_session_path
#       fill_in 'session[email]', with: user.email
#       fill_in 'session[password_digest]', with: user.email
#       click_button("ログイン")
#     end

#     it 'ユーザ一覧画面にアクセスできる'do
#       click_link("ユーザ一覧")
#       expect(current_path).to eq admin_users_path
#     end

#     it '管理者を登録できる'do
#       click_link("ユーザを登録する")

#       fill_in 'user[name]', with: "user"
#       fill_in 'user[email]', with: "user@gmail.com"
#       fill_in 'user[password]', with: "user@gmail.com"
#       fill_in 'user[password_confirm]', with: "user@gmail.com"
#       check 'user[admin]'

#       click_button("登録する")
#       expect(current_path).to eq admin_users_path
#       expect(page).to have_content("アカウントを登録しました")  
#     end
      
#     it 'ユーザ詳細画面にアクセスできる'do
#       visit admin_users_path
#       first('tr td:nth-child(4)').click
#       # click_link("詳細")
#       expect(current_path).to eq admin_user_path(user)
#     end

#     it 'ユーザ編集画面から、自分以外のユーザを編集できる'do
#       click_link("ユーザ一覧")
#       first('tr td:nth-child(5)').click
#       fill_in 'user[name]', with: "user"
#       fill_in 'user[password]', with: user.password
#       fill_in 'user[password_confirm]', with: user.password
#       click_button("更新する")
#       expect(current_path).to eq admin_users_path
#       expect(page).to have_content("ユーザを更新しました")
#     end

#     it 'ユーザを削除できる'do
#       click_link("ユーザ一覧")
#       accept_confirm do
#         page.all("a.destroy-user")[1].click
#       end

#       expect(page).to have_content "ユーザを削除しました" 
#       expect(current_path).to eq admin_users_path 
#     end
#   end
#     end
#     context '一般ユーザがユーザ一覧画面にアクセスした場合'do
#      let!(:second_user) { FactoryBot.create(:second_user) }
     
#        before do
#          visit new_session_path
#          fill_in 'session[email]', with: second_user.email
#          fill_in 'session[password_digest]', with: second_user.password
#          click_button("ログイン")
#          visit admin_users_path
#        end
#        it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do

#          expect(current_path).to eq tasks_path
#          expect(page).to have_content("管理者以外アクセスできません")
#        end
#     end
  # end

  require 'rails_helper'

RSpec.describe 'step4', type: :system do
  let!(:user) { User.create(name: 'user_name', email: 'user@email.com', password: 'password') }
  let!(:admin) { User.create(name: 'admin_name', email: 'admin@email.com', password: 'password', admin: true) }

  describe '画面設計要件' do
  describe '機能要件' do
    describe '11.要件で示した条件通りにフラッシュメッセージを表示させること' do
      context 'アカウントの更新に成功した場合' do
        before do
          visit new_session_path
          sleep 0.5
          find('input[name="session[email]"]').set(user.email)
          find('input[name="session[password]"]').set(user.password)
          click_button 'ログイン'
          sleep 0.5
        end
      end
      end
    
      context 'ユーザの登録に成功した場合' do
        before do
          visit new_session_path
          sleep 0.5
          find('input[name="session[email]"]').set(admin.email)
          find('input[name="session[password]"]').set(admin.password)
          click_button 'ログイン'
          sleep 0.5
        end
        it '「ユーザを登録しました」というフラッシュメッセージを表示させること' do
          visit new_admin_user_path
          sleep 0.5
          find('input[name="user[name]"]').set('new_user_name')
          find('input[name="user[email]"]').set('new_user@email.com')
          find('input[name="user[password]"]').set('new_password')
          find('input[name="user[password_confirmation]"]').set('new_password')
          click_button '登録する'
          expect(page).to have_content 'ユーザを登録しました'
        end
      end
      
      context 'ユーザを削除した場合' do
        before do
          visit new_session_path
          sleep 0.5
          find('input[name="session[email]"]').set(admin.email)
          find('input[name="session[password]"]').set(admin.password)
          click_button 'ログイン'
          sleep 0.5
        end
        it '「ユーザを削除しました」というフラッシュメッセージを表示させること' do
          visit admin_users_path
          sleep 0.5
          click_link '削除', href: admin_user_path(user)
          sleep 0.5
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content 'ユーザを削除しました'
        end
      end
    end

    describe '13.ユーザとタスクにアソシエーションを組み、タスク一覧画面に自分が作成したタスクのみ表示させること' do
      let!(:second_user) { User.create(name: 'second_user_name', email: 'second_user@email.com', password: 'password') }
      before do
        visit new_session_path
        sleep 0.5
        find('input[name="session[email]"]').set(user.email)
        find('input[name="session[password]"]').set(user.password)
        click_button 'ログイン'
        sleep 0.5
      end
      it 'ユーザとタスクにアソシエーションを組み、タスク一覧画面に自分が作成したタスクのみ表示させること' do
        5.times do |n|
          Task.create(title: "task_title_#{n}", content: "task_content_#{n}", deadline_on: Date.today, priority: 0, status: 0, user_id: user.id)
          Task.create(title: "second_user_task_title_#{n}", content: "task_content_#{n}", deadline_on: Date.today, priority: 0, status: 0, user_id: second_user.id)
        end
        visit tasks_path
        5.times do |n|
          expect(page).to have_content "task_title_#{n}"
          expect(page).not_to have_content "second_user_task_title_#{n}"
        end
      end
    end

    describe '14.ログインをせずにログイン画面とアカウント登録画面以外にアクセスした場合、ログインページに遷移させ「ログインしてください」というフラッシュメッセージを表示させること' do
      let!(:task){Task.create(title: 'task_title', content: 'task_content', deadline_on: Date.today, priority: 0, status: 0, user_id: user.id)}
      
      it 'アカウント編集画面にアクセスした場合' do
        visit edit_user_path(user)
        sleep 0.5
        expect(current_path).to eq new_session_path
        expect(page).to have_content 'ログインしてください'
      end
    end

    describe '17.ユーザを削除した際、そのユーザに紐づいているすべてのタスクが削除されること' do
      before do
        visit new_session_path
        sleep 0.5
        find('input[name="session[email]"]').set(admin.email)
        find('input[name="session[password]"]').set(admin.password)
        click_button 'ログイン'
        sleep 0.5
      end
      it 'ユーザを削除した際、そのユーザに紐づいているすべてのタスクが削除されること' do
        10.times do
          Task.create(title: 'task_title', content: 'task_content', deadline_on: Date.today, priority: 0, status: 0, user_id: user.id)
        end
        visit admin_users_path
        sleep 0.5
        click_link '削除', href: admin_user_path(user)
        sleep 0.5
        page.driver.browser.switch_to.alert.accept
        sleep 0.5
        expect(Task.all.count).to eq 0
      end
    end
  end
end

