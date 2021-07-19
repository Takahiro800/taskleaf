require 'rails_helper'

describe 'タスク管理機能', type: :system do
	describe '一覧表示機能' do
		before do
			# ユーザーAを作成しておく
			user_a = FactoryBot.create(:admin_user, name: 'ユーザーA', email: 'a@example.com')
			# 作成者がユーザーAであるタスクを作成しておく
			FactoryBot.create(:task, name: '最初のタスク', user: user_a)
		end

		context 'ユーザーAがログインしているとき' do
			before do
				# ユーザーAでログインする
			end

			it 'ユーザーAが作成したタスクが表示される' do
				# 作成済みのタスクの名称が画面上に表示されていることを確認
			end
		end
	end
end