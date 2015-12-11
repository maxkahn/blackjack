assert = chai.assert

describe "hand constructor", ->

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  it "should create a card collection", ->
    hand = new Hand()
    assert.strictEqual typeof hand, 'object'

  it "should calculate the minscore", -> 
    hand = new Hand([new Card({rank: 8, suit: 0}), new Card({rank: 10, suit: 0})])
    assert.strictEqual hand.minScore(), 18

  it "should create an array of scores", ->
    hand = new Hand([new Card({rank: 8, suit: 0}), new Card({rank: 10, suit: 0})])
    assert.strictEqual hand.scores().length, 2
    assert.strictEqual hand.scores()[0], 18
    assert.strictEqual hand.scores()[1], 18

    hand = new Hand([new Card({rank: 8, suit: 0}), new Card({rank: 10, suit: 0}), new Card({rank: 1, suit: 0})])
    assert.strictEqual hand.scores().length, 2
    assert.strictEqual hand.scores()[0], 19
    assert.strictEqual hand.scores()[1], 29

    hand = new Hand([new Card({rank: 2, suit: 0}), new Card({rank: 3, suit: 0}), new Card({rank: 1, suit: 0})])
    assert.strictEqual hand.scores().length, 2
    assert.strictEqual hand.scores()[0], 6
    assert.strictEqual hand.scores()[1], 16

  it "should return the best score on stand", ->
    hand = new Hand([new Card({rank: 8, suit: 0}), new Card({rank: 10, suit: 0})])
    assert.strictEqual hand.stand(), 18

    hand = new Hand([new Card({rank: 8, suit: 0}), new Card({rank: 10, suit: 0}), new Card({rank: 1, suit: 0})])
    assert.strictEqual hand.stand(), 19

  it "should return true on hasAce method", ->
    hand = new Hand([new Card({rank: 2, suit: 0}), new Card({rank: 3, suit: 0}), new Card({rank: 1, suit: 0})]) 
    assert.strictEqual hand.hasAce(), true

    hand = new Hand([new Card({rank: 2, suit: 0}), new Card({rank: 3, suit: 0})]) 
    assert.strictEqual hand.hasAce(), false