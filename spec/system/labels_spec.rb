require 'rails_helper'

RSpec.describe 'ラベル管理機能', type: :systemdo
  describe '登録機能'do
    context 'ラベルを登録した場合'do
      let!(:user) {
       FactoryBot.create(:user)
     }
     let!(:label) {
        FactoryBot.create(:label, user: user)
       }
       before do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button("ログイン")
        page.all("a.nav-item")[3].click
        fill_in 'label[name]', with: "label_1"
        click_button("登録する")
      end  
     it '登録したラベルが表示される'do
     page.all("a.nav-item")[6].click
       expect(text).to have_content("label_1")   
     end
    end
   end
   describe '一覧表示機能'do
     context '一覧画面に遷移した場合'do
     let!(:user) {
      FactoryBot.create(:user)
    }  
     let!(:label) {
        FactoryBot.create(:label, user: user)
       }
       before do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button("ログイン")
        page.all("a.nav-item")[2].click
       end
      it '登録済みのラベル一覧が表示される'do
       expect(text).to have_content("label_1") 
      end
     end
   end




