require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'バリデーションのテスト'do
    context 'タスクのタイトルが空文字の場合'do
      let!(:without_title) {
        Task.create(title: '', content: "hello")
      }

      it 'バリデーションに失敗する'do
        expect(without_title).to be_invalid
      end
    end

    context 'タスクの説明が空文字の場合' do
      let!(:without_content) {
        Task.create(title: "Say,Hello", content: '')
      }

      it 'バリデーションに失敗する'do
        expect(without_content).to be_invalid
      end
    end

    context 'タスクのタイトルと説明に値が入っている場合' do
      let!(:with_title_content) {
        Task.create(title: "Yes,Hello", content: 'Goodbye')
      }

      it 'タスクを登録できる'do
        expect(with_title_content).to be_valid
      end 
    end
  end

end

