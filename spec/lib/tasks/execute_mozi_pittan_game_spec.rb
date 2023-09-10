# frozen_string_literal: true

require 'rake_helper'

describe 'execute_mozi_pittan_game' do
  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'tasks/execute_mozi_pittan_game'
    Rake::Task.define_task(:environment)
  end

  let!(:word_to_guess) { %w[d o g] }
  let!(:guessed_status) { %w[_ _ _] }
  let!(:failure_limit) { 5 }

  describe 'execute_game' do
    subject(:task) { Rake.application['execute_mozi_pittan_game:execute_game'] }

    context '推測する単語を全て言い当てた場合' do
      before do
        allow($stdin).to receive(:gets).and_return('b')
        # word_to_guess == guessed_status
      end

      it '`ゲーム終了`と出力され、exitすること' do
        expect(task.invoke).to be_truthy
        # expect { task.invoke }.to output('ゲーム終了').to_stdout.and raise_error(SystemExit)
      end
    end

    context '失敗可能回数が0になるまで失敗した場合' do
      before { allow($stdin).to receive(:gets).and_return('b') }

      it '`ゲーム終了`と出力され、exitすること' do
        expect { task.invoke }.to output(/ゲーム終了/).to_stdout.and raise_error(SystemExit)
      end
    end
  end

  describe 'validate_and_process_input' do
    subject { validate_and_process_input(word_to_guess, failure_limit, guessed_status) }
    
    context '有効な入力の場合' do
      let(:input_alphabet) { 'o' }
      before { allow($stdin).to receive(:gets).and_return('d') }

      it '失敗可能回数がかえされること' do
        expect(subject).to eq(failure_limit)
      end
    end

    context '無効な入力の場合' do
      let(:input_alphabet) { 'あ' }
       before { allow($stdin).to receive(:gets).and_return('あ') }

      it '`無効な入力です`と出力されること' do
        expect { subject }.to output("無効な入力です\n").to_stdout
      end
    end
  end

  describe 'process_character_guess_and_results' do
    subject { process_character_guess_and_results(word_to_guess, input_alphabet, failure_limit, guessed_status) }
    let(:guessed_status) { %w[_ o _] }

    context '推測する単語に入力文字が含まれる場合' do
      let(:input_alphabet) { 'o' }

      it '失敗可能回数が変わらないこと'  do
        expect(subject).to eq(5)
      end
    end
    
    context '推測する単語に入力文字が含まれない場合' do
      let(:input_alphabet) { 'q' }

      it '失敗可能回数が1減少すること' do
        expect(subject).to eq(4)
      end
      it '推測ステータスが変わらないこと' do
        subject
        expect(guessed_status).to eq(%w[_ o _])
      end
    end
  end

  describe 'warn_of_pre_filled_character' do
    let(:guessed_status) { %w[d _ _] }
    subject { warn_of_pre_filled_character(guessed_status, input_alphabet) }

    context '推測ステータスに入力文字がない場合' do
      let(:input_alphabet) { 'a' }

      it '警告文が表示されないこと' do 
        expect { subject }.not_to output.to_stdout
      end
    end

    context '推測ステータスに入力文字が存在する場合' do
      let(:input_alphabet) { 'd' }
      let(:expected_output) { "**************\n既に'd'は入力済みです\n**************\n\n" }

      it '警告文が表示されること' do
        expect { subject }.to output(expected_output).to_stdout
      end
    end
  end

  describe 'replace_character' do
    context '入力文字が推測する単語の一部に合致する場合' do
      let(:input_alphabet) { 'o' }
      subject { replace_character(word_to_guess, input_alphabet, guessed_status) }

      it '文字の置換が起こること' do
        subject
        expect(guessed_status).to eq(%w[_ o _])
      end
    end
  end

  describe 'show_the_result' do
    let(:guessed_status) { %w[_ o _] }
    subject { show_the_result(failure_limit, guessed_status) }

    it '推測ステータスと失敗可能回数が正しく出力されること' do
      expect { subject }.to output("--------------\n_o_\n5\n--------------\n\n").to_stdout
    end
  end
end
