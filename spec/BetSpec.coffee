assert = chai.assert

describe "bet model", ->

  it "should create a card collection", ->
    bet = new Bet()
    assert.strictEqual typeof bet, 'object'

  it 'should increment its amount', ->
    bet = new Bet()
    bet.increase()
    assert.strictEqual bet.get('amount'), 10
    otherBet = new Bet({amount: 20, incrementer: 5})
    otherBet.increase()
    assert.strictEqual otherBet.get('amount'), 25

  it 'should decrement its amount', ->
    bet = new Bet()
    bet.decrease()
    assert.strictEqual bet.get('amount'), 0
    bet.increase()
    bet.increase()
    bet.decrease()
    assert.strictEqual bet.get('amount'), 10

    otherBet = new Bet({amount: 20, incrementer: 5})
    otherBet.decrease()
    assert.strictEqual otherBet.get('amount'), 15

  it 'should calculate amounts on finishBet', ->
    bet = new Bet({amount: 500})
    bet.finishBet(true, 50, 2)
    assert.strictEqual bet.get('amount'), 600

    bet = new Bet({amount: 500})
    bet.finishBet(false, 50, 2)
    assert.strictEqual bet.get('amount'), 500

    bet = new Bet({amount: 500})
    bet.finishBet(true, 50, 1)
    assert.strictEqual bet.get('amount'), 550
