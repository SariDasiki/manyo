require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'scope title_like(title)'do
    context 'scopeメソッドでタイトルのあいまい検索をした場合'do
      before do
        # 事前データ準備
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
      end
      
      it "検索ワードを含むタスクが絞り込まれる"do
        result = Task.title_like("first")
        # 検索されたデータの数を確認
        expect(result.size).to eq 1
        # 検索されたものと検索されなかったものを確認
        expect(result[0].title).to include "first"
      
      end
    end
  end

  describe 'scope status_search(status)'do
    context 'scopeメソッドでステータスで検索をした場合'do
      before do
        # 事前データ準備
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
      end
      
      it "指定のステータス含むタスクが絞り込まれる"do
        result = Task.status_search("完了")
        # 検索されたデータの数を確認
        expect(result.size).to eq 1
        # 検索されたものと検索されなかったものを確認
        expect(result[0].title).to include "third"
      
      end
    end
  end

  describe 'scope sort_deadline_on(deadline_on)'do
    context 'scopeメソッドでステータスで検索をした場合'do
      before do
        # 事前データ準備
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
      end
      
      it "終了期限の昇順でソートされる"do
        result = Task.sort_deadline_on(true)
        # 検索されたデータの数を確認
        expect(result.size).to eq 3
        # 検索されたものと検索されなかったものを確認
        expect(result[0].title).to include "third"
      
      end
    end
  end

  describe 'scope sort_priority(priority)'do
    context 'scopeメソッドで優先度並び替えた場合'do
      before do
        # 事前データ準備
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
      end
      
      it "優先度の降順でソートされる"do
        result = Task.sort_priority(true)
        # 検索されたデータの数を確認
        expect(result.size).to eq 3
        # 先頭が優先度 高になっているのを確認
        expect(result[0].priority).to eq "高"
      
      end
    end
  end
  
  describe 'バリデーションのテスト'do
    context 'タスクのタイトルが空文字の場合'
      let(:task) {
        FactoryBot.build(:task, title: "")
      }
    
      it 'バリデーションに失敗する'do
        expect(task).to be_invalid
      end

    context 'タスクの説明が空文字の場合' do
      let(:task) {
        FactoryBot.build(:task, content: "")
      }

      it 'バリデーションに失敗する'do
        expect(task).to be_invalid
      end
      
    end

    context 'タスクのタイトルと説明に値が入っている場合' do
      let(:task) {
        FactoryBot.build(:task)
      }

      it 'タスクを登録できる'do
        expect(task).to be_valid
      end 
    end
  end

end

