# frozen_string_literal: true

# the https://stackoverflow.com/questions/88311/how-to-generate-a-random-string-in-ruby
# https://stackoverflow.com/questions/8922275/how-do-i-do-element-wise-comparison-of-two-arrays
require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = []
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    word_array = @word.upcase.split('')
    @letters = params[:letters].split(" ")
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    @found = word['found']
    if word_array.difference(@letters).any?
      @output = "Sorry but #{@word.upcase} can't be built out of #{@letters.join(',')}"
    elsif @found == false
      @output = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    else
      @output = "Congratulations! #{@word.upcase} is a valid English word! "
    end
  end
end
