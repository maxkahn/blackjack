window.playerWins = false
window.betMoneyAmount = 0

class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button">New Game</button>
    <div class = "end-game-message"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="bet-container">
      <div class="player-money-container"></div>
      <div class="player-bet-container"></div>
    </div>
    <div class="history-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()
      @model.set 'betOpen', false
    'click .stand-button': -> 
      @model.get('dealerHand').dealerPlay()

      playerScore = @model.get('playerHand').stand()
      dealerScore = @model.get('dealerHand').stand()

      playerWins = false
      if playerScore > 21
        playerWins = false
      else if dealerScore > 21
        playerWins = true
      else if playerScore == dealerScore
        playerWins = false
      else if playerScore > dealerScore
        playerWins = true
      else
        playerWins = false
      window.playerWins = playerWins

      multiplier = @model.get('winMultiplier')
      @model.get('playerMoney').finishBet(playerWins, @model.get('betMoney').get('amount'), multiplier)
      if playerWins
        window.betMoneyAmount = @model.get('betMoney').get('amount') * multiplier
      else
        window.betMoneyAmount = @model.get('betMoney').get('amount')
      @model.get('betMoney').set('amount', 0)

      if playerWins
        console.log 'Player wins!'
        $('.end-game-message').removeClass('end-game-message').addClass('win')
        $('.win').text('You Win!')
      else
        console.log 'Dealer wins'
        $('.end-game-message').removeClass('end-game-message').addClass('loss')
        $('.loss').text('You Lose!')

    'click .new-game-button': ->
      tmpPlayerHand = @model.get('playerHand').clone()
      tmpDealerHand = @model.get('dealerHand').clone()
      
      deck = @model.get('deck')
      if @model.get('deck').length < 10
        deck = new Deck()
        @model.set 'deck', deck
      @model.set 'playerHand', deck.dealPlayer()
      @model.set 'dealerHand', deck.dealDealer()
      @render()
      $('.end-game-message').removeClass('win loss').addClass('end-game-message')
      @model.set 'betOpen', true

      @model.get('historyGames').add(new Game({playerHand: tmpPlayerHand, dealerHand: tmpDealerHand, score: window.betMoneyAmount, win: window.playerWins}))

    'click .add-button': -> 
      if @model.get('betOpen')
        playerMoney = @model.get 'playerMoney'
        betMoney = @model.get 'betMoney'
        if 0 < playerMoney.get 'amount'
          betMoney.increase()
          playerMoney.decrease()
    'click .remove-button': -> 
      if @model.get('betOpen')
        playerMoney = @model.get 'playerMoney'
        betMoney = @model.get 'betMoney'
        if 0 < betMoney.get 'amount'
          playerMoney.increase()
          betMoney.decrease()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-money-container').html new MoneyView(model: @model.get 'playerMoney').el
    @$('.player-bet-container').html new BetView(model: @model.get 'betMoney').el
    @$('.history-container').html new HistoryGamesView(collection: @model.get 'historyGames').el

