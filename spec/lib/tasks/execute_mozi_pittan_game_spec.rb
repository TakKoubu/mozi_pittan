# frozen_string_literal: true

require 'rake_helper'
require 'stringio'

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
    context '失敗可能回数が0になるまで失敗した場合' do
      before { allow($stdin).to receive(:gets).and_return('b') }
      subject(:task) { Rake.application['execute_mozi_pittan_game:execute_game'] }

      it '`ゲーム終了`と出力され、exitすること' do
        expect { task.invoke }.to output(/ゲーム終了/).to_stdout.and raise_error(SystemExit)
      end
    end
  end

  describe 'validate_and_process_input' do
    subject { validate_and_process_input(word_to_guess, failure_limit, guessed_status) }

    context '推測する単語を全て言い当てた場合' do
      let!(:word_to_guess) { %w[d o g] }
      let!(:guessed_status) { word_to_guess }

      it '失敗可能回数も推測ステータスもこれ以上変化しなくなること' do
        expect { subject }.not_to(change { failure_limit })
        expect { subject }.not_to(change { guessed_status })
      end
    end

    context '失敗可能回数が0の場合' do
      let(:failure_limit) { 0 }

      it '失敗可能回数の変化はしないこと' do
        expect { subject }.not_to(change { failure_limit })
      end
    end
  end

  describe 'warn_of_invalid_input' do
    subject { warn_of_invalid_input(valid_flg) }
    let(:warnig_message) { "**************\n無効な入力です\n半角英文字を入力してください\n**************\n\n" }
    let(:valid_flg) { false }

    it '`無効な入力です`と出力されること' do
      expect { subject }.to output(warnig_message).to_stdout
    end
  end

  describe 'process_character_guess_and_indicate_results' do
    subject do
      process_character_guess_and_indicate_results(word_to_guess, input_alphabet, failure_limit, guessed_status)
    end
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
      let(:warnig_message) { "**************\n既に'd'は入力済みです\n**************\n\n" }

      it '警告文が表示されること' do
        expect { subject }.to output(warnig_message).to_stdout
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
    let(:result_message) { "--------------\n_o_\n5\n--------------\n\n" }
    subject { show_the_result(failure_limit, guessed_status) }

    it '推測ステータスと失敗可能回数が正しく出力されること' do
      expect { subject }.to output(result_message).to_stdout
    end
  end
end
