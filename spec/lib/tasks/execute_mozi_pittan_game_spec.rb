# frozen_string_literal: true

require 'rake_helper'

describe 'execute_mozi_pittan_game' do
  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'tasks/execute_mozi_pittan_game'
    Rake::Task.define_task(:environment)
  end

  describe 'execute_game' do
    context '失敗可能回数が1以上の時' do
      context '`半角英文字を1文字入力してください`と出力されること' do
      end

      context 'valid_flgがtrueの場合' do
        it 'process_character_guess_and_resultsが実行されること' do
        end
      end

      context 'valid_flgがfalseの場合' do
        it '`無効な入力です`と出力されること' do
        end
      end

      context '推測する単語を全て言い当てた場合' do
        it '`ゲーム終了`と出力され、exitすること' do
        end
      end
    end

    context '失敗可能回数が0の時' do
      it '`ゲーム終了`と出力され、exitすること' do
      end
    end
  end

  word_to_guess = %w[d o g]
  guessed_status = ['_' * 3]
  failure_limit = 5

  describe 'process_character_guess_and_results' do
    context '推測する単語に入力文字が含まれる場合' do
      input_alphabet = 'o'
      new_failure_limit = process_character_guess_and_results(word_to_guess, input_alphabet, failure_limit,
                                                              guessed_status)
      it '失敗可能回数が変わらないこと' do
        expect(new_failure_limit).to eq(5)
      end
      it '推測ステータスが変化すること' do
        expect(guessed_status).to eq(%w[_ o _])
      end
    end

    context '推測する単語に入力文字が含まれない場合' do
      input_alphabet = 'p'
      new_failure_limit = process_character_guess_and_results(word_to_guess, input_alphabet, failure_limit,
                                                              guessed_status)

      it '失敗可能回数が1減少すること' do
        expect(new_failure_limit).to eq(4)
      end
      it '推測ステータスが変わらないこと' do
        expect(guessed_status).to eq(%w[_ _ _])
      end
    end
  end

  describe 'warn_of_pre_filled_character' do
    guessed_status = %w[d _ _]

    context '推測ステータスに入力文字がない場合' do
      input_alphabet = 'a'

      it '警告文が表示されないこと' do
        expect { warn_of_pre_filled_character(guessed_status, input_alphabet) }
          .not_to output.to_stdout
      end
    end

    context '推測ステータスに入力文字が存在する場合' do
      input_alphabet = 'd'

      it '警告文が表示されること' do
        expect { warn_of_pre_filled_character(guessed_status, input_alphabet) }
          .to output("**************\n既に'a'は入力済みです\n**************\n\n").to_stdout
      end
    end
  end

  describe 'replace_character' do
    context '入力文字が推測する単語の一部に合致する場合' do
      input_alphabet = 'o'
      replace_character(word_to_guess, input_alphabet, guessed_status)

      it '文字の置換が起こること' do
        expect(guessed_status).to eq(%w[_ o _])
      end
    end
  end

  describe 'show_the_result' do
    it '推測ステータスと失敗可能回数が正しく出力されること' do
      expect { show_the_result(failure_limit, guessed_status) }
        .to output("--------------\n_ o _\n5\n--------------\n\n").to_stdout
    end
  end
end
