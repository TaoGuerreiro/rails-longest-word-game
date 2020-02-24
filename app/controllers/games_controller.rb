require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    8.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @word = hashing_the_word(params[:word])
    @grid = hashing_the_grid(params[:letters])

    grid_test = in_the_grid?(@word, @grid)
    english_test = english?(params[:word])

    @win_conditions = result(english_test, grid_test)

    points_to_add = scoring(english_test, grid_test) ? 1 : 0
    save_score(points_to_add)

    @score = session[:total_score]
  end

  private

  def save_score(points_to_add)
    session[:total_score] = 0 unless session[:total_score].present?

    session[:total_score] += points_to_add
  end

  def hashing_the_grid(grid)
    grid_hash = Hash.new 0
    grid.chars.each { |letter| grid_hash[letter] += 1 }
    grid_hash
  end

  def hashing_the_word(word)
    word_hash = Hash.new 0
    word.strip.chars.each { |letter| word_hash[letter] += 1 }
    word_hash
  end

  def in_the_grid?(hash_word, hash_grid)
    return false if hash_word.empty?
    hash_word.each do |letter, value|
      if hash_grid[letter]
        return false unless hash_grid[letter] >= value
      else
        return false
      end
    end
    true
  end

  def english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.gsub(" ","")}"
    dico = open(url).read
    api_word = JSON.parse(dico)
    api_word['found']
  end

  def result(english_test, grid_test)
    if english_test == false
      'This is not an english word! you loose!'
    elsif grid_test == false
      'Some letters are not in the grid! you loose!'
    else
      'you win! well done'
    end
  end

  def scoring(english_test, grid_test)
    if english_test == false
      false
    elsif grid_test == false
      false
    else
      true
    end
  end
end



