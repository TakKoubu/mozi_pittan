# frozen_string_literal: true

namespace :execute_mozi_pittan_game do
  desc '文字合わせゲームの起動および実行'
  task execute_game: :environment do
    puts 'もじピッタンゲーム'

    failure_limit = 5
    animals = %w[dog cat elephant lion giraffe dolphin tiger penguin koala kangaroo]
    word_to_guess = animals[rand(0..9)].chars
    guessed_status = Array.new(word_to_guess.size, '_')

    while failure_limit.positive?
      puts "半角英文字を1文字入力してください\n\n"

      input_alphabet = $stdin.gets.chomp.downcase
      valid_flg = input_alphabet.match?(/^[a-z]$/)
      if valid_flg
        failure_limit = process_character_guess_and_results(word_to_guess, input_alphabet, failure_limit,
                                                            guessed_status)
      else
        (puts '無効な入力です')
      end
      break if word_to_guess == guessed_status
    end

    puts 'ゲーム終了'
    exit
  end
end

# 文字の推測の処理と結果表示
def process_character_guess_and_results(word_to_guess, input_alphabet, failure_limit, guessed_status)
  if word_to_guess.include?(input_alphabet)
    warn_of_pre_filled_character(guessed_status, input_alphabet)
    replace_character(word_to_guess, input_alphabet, guessed_status)
  else
    failure_limit -= 1
  end
  show_the_result(failure_limit, guessed_status)
  failure_limit
end

# 入力済みの文字への警告文の表示
def warn_of_pre_filled_character(guessed_status, input_alphabet)
  return unless guessed_status.include?(input_alphabet)

  puts "**************\n"
  puts "既に'#{input_alphabet}'は入力済みです\n"
  puts "**************\n\n"
end

# 文字の置き換え
def replace_character(word_to_guess, input_alphabet, guessed_status)
  matched_indexes = word_to_guess.each_index.select { |idx| word_to_guess[idx] == input_alphabet }
  matched_indexes.each { |idx| guessed_status[idx] = input_alphabet }
end

# 現在の予測状態と残り入力可能回数の表示
def show_the_result(failure_limit, guessed_status)
  puts "--------------\n"
  puts "#{guessed_status.join}\n"
  puts "#{failure_limit}\n"
  puts "--------------\n\n"
end
