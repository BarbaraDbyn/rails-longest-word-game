class GamesController < ApplicationController
  require 'json'
  require 'net/http'
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    # %w[Y Z D U Q E Z Y Q I]
  end

  def score
    @word = params[:word]
    @random = params[:random_letter]
    word_letter = @word.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @english_word = JSON.parse(response)
    # filepath = "https://wagon-dictionary.herokuapp.com/#{@word}"
    # good_word = File.read(filepath)
    # @word = JSON.parse(good_word)
    if !word_letter.include?(@random)
      @score = "Sorry but #{@word.upcase} can't be built out of #{@random}"
    elsif @english_word[:found] != true
      @score = "Sorry but #{@word.upcase} does not seem to be an English word..."
    elsif @english_word[:found] == true
      @score = "Congratulations! #{@word.upcase} is a valid English word!"
    end
  end
end
