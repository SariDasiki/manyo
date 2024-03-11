require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
   describe '登録機能'do
     context 'ユーザを登録した場合'do
      let!(:second_user) { FactoryBot.create(:second_user) }
     
      before do
       visit new_user_path
       fill_in 'user[name]', with: "ffff"
       fill_in 'user[email]', with: "ffff@gmail.com"
       fill_in 'user[password]', with: "ffff@gmail.com"
       fill_in 'user[password_confirmation]', with: "ffff@gmail.com"
       click_button("登録する")
      end
     
       it 'タスク一覧画面に遷移する'do
        expect(current_path).to eq users_path
       end
    end
     context 'ログインせずにタスク一覧画面に遷移した場合'do
       before do
        visit tasks_path
       end
        it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
          expect(page).to have_content("ログインしてください")  
        end
     end
   end
      
   describe 'ログイン機能'do
     context '登録済みのユーザでログインした場合'do
        let!(:second_user) { 
          FactoryBot.create(:second_user)
        }
        let!(:fourth_user) { 
          FactoryBot.create(:fourth_user)
        }
       before do
         visit new_session_path
         fill_in 'session[email]', with: "ffff@gmail.com"
         fill_in 'session[password_digest]', with: "ffff@gmail.com"
         click_button("ログイン")
       end
         it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される'do
           expect(page).to have_content("ログインしました")  
         end
         it '自分の詳細画面にアクセスできる'do
           click_link("アカウント設定")
           expect(page).to have_content("アカウント詳細ページ") 
         end
         it '他人のユーザー詳細画面にアクセスすると、タスク一覧画面に遷移する'do
          visit user_path(fourth_user)
          expect(current_path).to eq tasks_path
         end
         it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される'do
          click_link("ログアウト")
          expect(page).to have_content("ログアウトしました")   
         end
     end
  end

  describe '管理者機能'do
    context '管理者がログインした場合'do

    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:second_user) } 
     
    before do
      visit new_session_path
      fill_in 'session[email]', with: user.email
      fill_in 'session[password_digest]', with: user.email
      click_button("ログイン")
    end

    it 'ユーザ一覧画面にアクセスできる'do
      click_link("ユーザー一覧")
      expect(current_path).to eq admin_users_path
    end

    it '管理者を登録できる'do
      click_link("ユーザーを登録する")

      fill_in 'user[name]', with: "user"
      fill_in 'user[email]', with: "user@gmail.com"
      fill_in 'user[password]', with: "user@gmail.com"
      fill_in 'user[password_confirm]', with: "user@gmail.com"
      check 'user[admin]'

      click_button("登録する")
      expect(current_path).to eq admin_users_path
      expect(page).to have_content("アカウントを登録しました")  
    end
      
    it 'ユーザ詳細画面にアクセスできる'do
      visit admin_users_path
      first('tr td:nth-child(4)').click
      # click_link("詳細")
      expect(current_path).to eq admin_user_path(user)
    end

    it 'ユーザ編集画面から、自分以外のユーザを編集できる'do
      click_link("ユーザー一覧")
      first('tr td:nth-child(5)').click
      fill_in 'user[name]', with: "user"
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirm]', with: user.password
      click_button("更新する")
      expect(current_path).to eq admin_users_path
      expect(page).to have_content("ユーザを更新しました")
    end

    it 'ユーザを削除できる'do
      click_link("ユーザー一覧")
      accept_confirm do
        page.all("a.destroy-user")[1].click
      end

      expect(page).to have_content "ユーザーを削除しました" 
      expect(current_path).to eq admin_users_path 
    end
  end
    end
    context '一般ユーザがユーザ一覧画面にアクセスした場合'do
     let!(:second_user) { FactoryBot.create(:second_user) }
     
       before do
         visit new_session_path
         fill_in 'session[email]', with: second_user.email
         fill_in 'session[password_digest]', with: second_user.password
         click_button("ログイン")
         visit admin_users_path
       end
       it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do

         expect(current_path).to eq tasks_path
         expect(page).to have_content("管理者以外アクセスできません")
       end
    end
  end

