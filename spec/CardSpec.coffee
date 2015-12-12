assert = chai.assert

describe "Card constructor", ->

  it "should create a card as an object", ->
    card = new Card({rank: 3})
    assert.strictEqual typeof card, 'object'

  it "should set correct card score based on rank", ->
    card = new Card({rank: 5})
    assert.strictEqual 5, card.get 'value'

    card = new Card({rank: 11})
    assert.strictEqual 10, card.get 'value'

    card = new Card({rank: 1})
    assert.strictEqual 1, card.get 'value'

    card = new Card({rank: 13})
    assert.strictEqual 10, card.get 'value'

    card = new Card({rank: 14})
    assert.strictEqual 10, card.get 'value'


  it "should toggle 'revealed' attribute when flip is called", ->
    card = new Card({rank: 6})
    card.flip()
    assert.strictEqual false, card.get 'revealed'
    card.flip()
    assert.strictEqual true, card.get 'revealed'

  it 'should have correct rankNames', ->
    card = new Card({rank: 5})
    assert.strictEqual 5, card.get 'rankName'

    card = new Card({rank: 11})
    assert.strictEqual 'Jack', card.get 'rankName'

    card = new Card({rank: 1})
    assert.strictEqual 'Ace', card.get 'rankName'

    card = new Card({rank: 13})
    assert.strictEqual 13, card.get 'rankName'

    card = new Card({rank: 14})
    assert.strictEqual 14, card.get 'rankName'

  it 'should set correct suit name', ->
    card = new Card({rank: 3, suit: 0})
    assert.strictEqual 'Spades', card.get 'suitName'

    card = new Card({rank: 3, suit: 1})
    assert.strictEqual 'Diamonds', card.get 'suitName'

    card = new Card({rank: 3, suit: 2})
    assert.strictEqual 'Clubs', card.get 'suitName'

    card = new Card({rank: 3, suit: 3})
    assert.strictEqual 'Hearts', card.get 'suitName'

