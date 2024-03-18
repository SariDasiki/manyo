require 'rails_helper'

  RSpec.describe 'ラベルモデル機能', type: :model do
    let(:user) {
        FactoryBot.create(:user)
      }
    describe 'バリデーションのテスト'do
      context 'ラベルの名前が空文字の場合'do
       let!(:label) {
        FactoryBot.build(:label, user: user, name: "")
       } 
        it 'バリデーションに失敗する'do
          expect(label).to be_invalid
        end
      end
 
      context 'ラベルの名前に値があった場合'do
        let!(:second_label) {
         FactoryBot.build(:second_label, user: user, name: "label_2")
        } 
        it 'バリデーションに成功する'do
          expect(second_label).to be_valid
        end
      end
    end
 end

