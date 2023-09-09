require 'rails_helper'
require 'rake'

describe 'rake/tasks/execute_mozi_pittan_game' do
  before(:all) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'tasks/execute_mozi_pittan_game'
    Rake::Task.define_task(:environment)
  end

  入力値 = ['c','c','a','a','t']
  入力値 = ['q','q','q','q','q']

  describe 'execute_game' do
    context 'failure_limitが1以上の時' do
      context '`半角英文字を1文字入力してください`と出力されること' do
      end
      
      context 'valid_flgが有効の場合' do
        it 'process_character_guess_and_resultsが実行されること' do
        end
      end

      context 'valid_flgが無効の場合' do
        it '`無効な入力です`と出力されること' do
        end
      end
  
      context 'word_to_guessを全て言い当てた場合' do
        it '`ゲーム終了`と出力されexitすること' do
        end
      end
    end

    context 'failure_limitが0の時' do
      it 'loopから抜け出し、ゲーム終了と出力されること' do
      end
    end
  end

  describe 'process_character_guess_and_results' do
    context 'word_to_guessにinput_alphabetが含まれる場合' do
      it 'failure_limitの数は変化しないこと' do
      end
      it 'failure_limitを返すこと' do
      end
    end

    context 'word_to_guessにinput_alphabetが含まれない場合' do
      it 'failure_limitの数が1減少すること' do
      end
      it 'failure_limitを返すこと' do
      end
    end
  end

  describe 'warn_of_pre_filled_character' do
    context 'guessed_statusにinput_alphabetが含まれない場合' do
      it 'returnし、警告文は表示されないこと' do
      end
      it '既にinput_alphabetは入力済みですと出力されること' do
      end
    end
  end

  describe 'replace_character' do
    context 'input_alphabetがword_to_guessの一部に合致する場合' do
      it '正常に文字の入れ替えが起こること' do
      end
    end

    context 'input_alphabetがword_to_guessに合致しない場合' do
      it '文字の入れ替えは起きないこと' do
      end
    end
  end

  describe 'show_the_result' do
    it 'guessed_statusとfailure_limitが出力されること' do
    end
  end
end
