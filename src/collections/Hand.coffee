class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
    if @isDealer
      @on('stand', this.dealerPlay, @)

  hit: ->
    @add(@deck.pop())
    @last()


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  dealerPlay: ->
    while @minScore() <= 17
      @hit()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: -> 
    @each (card) ->
      if not card.get 'revealed'
        card.flip()

    finalScores = @scores()

    result = finalScores[0]
    if finalScores[1] > finalScores[0] and finalScores[1] <= 21
      result = finalScores[1]

    result