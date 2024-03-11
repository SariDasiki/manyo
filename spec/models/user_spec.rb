require 'rails_helper'

RSpec.describe User, type: :model do

   describe 'バリデーションのテスト'do
     context 'ユーザの名前が空文字の場合'do
      let!(:second_user) {
        FactoryBot.build(:second_user, name: "", email: "ffff@gmail.com", password: "ffff@gmail.com", admin: "false")
      }
      it 'バリデーションに失敗する'do
      expect(second_user).to be_invalid
      end
     end

     context 'ユーザのメールアドレスが空文字の場合'do
       let!(:second_user) {
        FactoryBot.build(:second_user, name: "ffff", email: "", password: "ffffgmail.com", admin: "false")
       }
        it 'バリデーションに失敗する'do
         expect(second_user).to be_invalid
        end
     end

     context 'ユーザのパスワードが空文字の場合'do
        let!(:second_user) {
         FactoryBot.build(:second_user, name: "ffff", email: "ffffgmail.com", password: "", admin: "false")
         }
          it 'バリデーションに失敗する'do
           expect(second_user).to be_invalid
          end
        end

     context 'ユーザのメールアドレスがすでに使用されていた場合'do
      let!(:user) {
        FactoryBot.create(:user, email: "ffff@gmail.com")
        }
        let!(:second_user) {
        FactoryBot.build(:second_user, email: "ffff@gmail.com")
        }
       it 'バリデーションに失敗する'do
        expect(second_user).to be_invalid
       end
      end

     context 'ユーザのパスワードが6文字未満の場合'do
       let!(:fourth_user) {
       FactoryBot.build(:fourth_user, name: "hhhh", email: "hhhhgmail.com", password: "hhhh", admin: "false")
       }
         it 'バリデーションに失敗する'do
         expect(fourth_user).to be_invalid
         end
     end

     context 'ユーザの名前に値があり、メールアドレスが使われていない値で、かつパスワードが6文字以上の場合'do
       let!(:third_user) {
         FactoryBot.build(:third_user, name: "hhhh", email: "jjjjgmail.com", password: "hhhh@gmail.com", admin: "false")
         }
          it 'バリデーションに成功する'do
           expect(third_user).to be_valid
          end
       end
    end
  end

