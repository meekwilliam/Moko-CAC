# Order Flow — strategy course authoring source

Course id: `orderflow`  ·  accent `#14B8A6`  ·  standalone strategy track (always unlocked).
Mirrors Moko/GameData.json. Correct answer is listed FIRST for [MC]/[FILL] (the app shuffles).
No INTRO blocks. Prompts are the bare ask (reasoning lives in WHY).

Interactive order-flow mechanics (tap-based, no dragging):
  [AGGRESSOR] event: lift|hit — a live DOM ladder is consumed; tap buyer/seller. lift⇒buyer, hit⇒seller.
  [BOOKDRAG]  order: market_buy|market_sell — tap the side it fills. buy⇒ask, sell⇒bid.


UNIT 1 — Order Flow Foundations

NODE 1
TITLE: What Is Order Flow?
CELEBRATION: You get what order flow really means.

[MC] What is order flow?
Live buying, selling, and liquidity
The order candles appear in
A sequence of chart patterns
WHY: Order flow shows live trading pressure and liquidity.

[TF] Order flow shows more than a finished price line.
ANSWER: True
WHY: It adds context about current pressure and liquidity.

[AGGRESSOR] Offers are being taken. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers, so buyers are aggressive.

[MATCH] Match each term.
Order flow => Live buying and selling
Price => Result of execution
A candle => Record of past price
WHY: Orders create fills. Fills create price. Candles record it.

[FILL] Order flow reads the [___] of buyers and sellers.
balance
volume
price
WHY: The balance shows which side has more pressure.

[ORDER] Build the order flow chain.
Buyers and sellers place orders
Orders execute against each other
Price moves to the last fill
The candle updates on the chart
WHY: Orders create fills. Fills update price and the chart.

NODE 2
TITLE: Aggressive vs. Passive Orders
CELEBRATION: You can tell takers from makers.

[MC] Pick the aggressive order.
Takes available liquidity now
Waits at a chosen price
Only fills at the open
WHY: Aggressive orders trade now and remove liquidity.

[MC] Pick the passive order.
Waits at a chosen price
Always fills now
Placed by your broker
WHY: Passive orders wait and provide liquidity.

[BOOKDRAG] Market buy. Tap its fill side.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Market sell. Tap its fill side.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[MATCH] Match maker or taker.
Instant market buy => Taker
Resting limit sell => Maker
Hit the bid now => Taker
WHY: Takers trade now. Makers wait.

[TF] Aggressive orders remove liquidity; passive orders provide it.
ANSWER: True
WHY: Takers remove liquidity. Makers provide it.

[AGGRESSOR] Bids are being taken. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Sellers hit bids, so sellers are aggressive.

NODE 3
TITLE: The Bid, Ask & Spread
CELEBRATION: You own the bid, ask and spread.

[MC] Pick the bid.
Highest buyer price
Lowest seller price
Last traded price
WHY: The bid is the best resting buy price.

[MC] Pick the ask.
Lowest seller price
Highest buyer price
Average daily price
WHY: The ask is the best resting sell price.

[FILL] The gap between the bid and the ask is the [___].
spread
range
gap
WHY: The spread is the distance between bid and ask.

[BOOKDRAG] Buy now. Tap the fill side.
ORDER: market_buy
ANSWER: the ask
WHY: Buying now means paying the ask.

[BOOKDRAG] Sell now. Tap the fill side.
ORDER: market_sell
ANSWER: the bid
WHY: Selling immediately means hitting the bid.

[MATCH] Match each action.
Market buy => Ask
Market sell => Bid
Spread => Ask minus bid
WHY: Buy at the ask. Sell at the bid.

[TF] A wider spread generally signals thinner liquidity.
ANSWER: True
WHY: Less nearby liquidity can widen the spread.

NODE 4
TITLE: Lifting the Offer & Hitting the Bid
CELEBRATION: You can read aggression in the book.

[MC] Which action lifts the offer?
Buying the ask
Canceling a sell order
Posting a higher offer
WHY: Lifting the offer means buying the ask.

[AGGRESSOR] Offers are getting eaten. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: The buyer is lifting the offer.

[AGGRESSOR] Bids are getting eaten. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: The seller is hitting the bid.

[FILL] Sellers push down by [___] the bid.
hitting
posting
raising
WHY: Hitting bids can push price lower.

[MATCH] Match each action.
Lift the offer => May push price up
Hit the bid => May push price down
Only resting orders => Price may stay still
WHY: Aggression consumes liquidity and can move price.

[BOOKDRAG] Lift the offer. Tap the side taken.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[AGGRESSOR] Buyers keep lifting offers. Who controls?
EVENT: lift
ANSWER: The buyer
WHY: Persistent lifting shows buyer control.

NODE 5
TITLE: What Actually Moves Price
CELEBRATION: You understand imbalance.

[MC] What can push price higher?
Aggressive buying takes offers
More shares exist
More candles print
WHY: Aggressive buying can consume offers and lift price.

[TF] A large displayed order guarantees price will hold.
ANSWER: False
WHY: Displayed orders can change or disappear.

[FILL] A strong directional move needs an order [___].
imbalance
average
schedule
WHY: An imbalance means one side is more aggressive.

[ORDER] Build the upward move.
Buyers become more aggressive
Offers get consumed
Price reaches higher asks
A green candle appears
WHY: Buyer pressure consumes offers before the chart updates.

[MATCH] Match pressure to price.
Buyer imbalance => May push price up
Seller imbalance => May push price down
Balanced pressure => May keep price ranging
WHY: Pressure suggests direction, but conditions can change.

[AGGRESSOR] Price grinds higher. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Aggressive buyers are lifting offers.

[BOOKDRAG] Push price up. Tap the side buyers take.
ORDER: market_buy
ANSWER: the ask
WHY: Buyers take asks to move price higher.

NODE 6
TITLE: Order Flow Foundations Review
CELEBRATION: Foundations mastered. You read the flow behind price.

[AGGRESSOR] Offers are consumed. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers consume offers.

[BOOKDRAG] Market buy. Tap the fill side.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Market sell. Tap the fill side.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[MATCH] Match each term.
Bid => Best buyer price
Ask => Best seller price
Spread => Gap between bid and ask
Imbalance => One side has more pressure
WHY: These ideas form the base of order flow.

[MC] Pick order flow.
Live buying, selling, and liquidity
The order chart patterns appear
A company news schedule
WHY: Order flow adds live context to price.

[ORDER] Build the order to chart chain.
Aggressive orders hit the market
They execute against resting orders
Price moves to the next level
The candle updates
WHY: Orders create fills before the chart updates.

[TF] You buy at the ask and sell at the bid when you trade aggressively.
ANSWER: True
WHY: Buy now at the ask. Sell now at the bid.

[AGGRESSOR] Bids are consumed. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Sellers consume bids.


UNIT 2 — The Order Book

NODE 7
TITLE: What the Order Book Shows
CELEBRATION: You know what Level II actually shows.

[MC] What does Level II show?
The full depth of resting orders on both sides.
Only the best bid and ask.
Every trade already executed.
WHY: Level II is the whole ladder of resting limit orders. Level I is just the top of book; executed trades live in time & sales.

[MC] What does Level I show?
Only the best bid and ask.
The full resting depth on both sides.
The day's executed trades.
WHY: Level I is the top of the book — the single best bid and best ask.

[MATCH] Match each feed to what it shows.
Level I => Best bid and ask
Level II => Full resting depth
Time & Sales => Executed trades
WHY: Three lenses: top of book, the full book, and the trades that already happened.

[AGGRESSOR] Tap the aggressor.
EVENT: lift
ANSWER: The buyer
WHY: The offers are being taken, so the buyer is the aggressor lifting them.

[BOOKDRAG] Tap the side this buy fills against.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the resting offers — it fills at the ask.

[TF] The order book shows resting orders, not completed trades.
ANSWER: True
WHY: Resting orders are still waiting to fill; completed trades show up in time & sales.

[ORDER] Order a limit order's life in the book.
A trader posts a limit order
It rests in the book
An aggressor takes it
It leaves the book
WHY: Resting liquidity sits until an aggressive order consumes it.

NODE 8
TITLE: Bid Side vs. Ask Side
CELEBRATION: You can read both sides of the book.

[MC] Where do resting buy orders sit?
The bid side.
The ask side.
The spread.
WHY: Buyers rest on the bid. Sellers rest on the ask, and the spread is the gap between them.

[MC] Where do resting sell orders sit?
The ask side.
The bid side.
The spread.
WHY: Sellers rest on the ask side, above the spread.

[BOOKDRAG] Tap the side this buy fills against.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy lifts the ask.

[BOOKDRAG] Tap the side this sell fills against.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[MATCH] Match each part of the book.
Bid side => Resting buyers
Ask side => Resting sellers
Spread => Gap between them
WHY: Buyers below, sellers above, the spread in between.

[TF] The best bid sits just below the best ask.
ANSWER: True
WHY: The bid is always below the ask; the distance between them is the spread.

[AGGRESSOR] Tap the aggressor.
EVENT: hit
ANSWER: The seller
WHY: The bids are being taken, so the seller is the aggressor.

NODE 9
TITLE: Size & Liquidity
CELEBRATION: You can read depth and liquidity.

[MC] What does the number beside a price show?
The size resting there.
The trades done there.
Its distance from the last price.
WHY: The number is resting size — how many shares sit waiting at that price.

[MC] A book with large size at every level is…
Liquid.
Illiquid.
Volatile.
WHY: Plenty of resting size means liquid: price needs a lot of aggression to move.

[TF] A thin book moves on fewer orders than a thick one.
ANSWER: True
WHY: Less resting size means each aggressive order pushes price further.

[MATCH] Match each book to how it moves.
Thick book => Hard to move
Thin book => Easy to move
Resting size => Liquidity at a price
WHY: Depth is what absorbs aggression; without it, price jumps.

[AGGRESSOR] Tap the aggressor.
EVENT: lift
ANSWER: The buyer
WHY: Offers being taken means the buyer is the aggressor.

[BOOKDRAG] Tap the side this sell fills against.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[ORDER] Order what happens as a thin book gets hit.
A small resting size sits at the bid
A market sell hits it
The bid clears fast
Price drops to the next level
WHY: Thin liquidity clears quickly, so price jumps to the next level.

NODE 10
TITLE: Large Orders as Walls
CELEBRATION: You can spot walls acting as support and resistance.

[MC] A large resting bid can act as…
Temporary support.
Temporary resistance.
A guaranteed floor.
WHY: A big bid can hold price up for a while — but it can be pulled or absorbed, so it's not a guarantee.

[MC] A large resting ask can act as…
Temporary resistance.
Temporary support.
A guaranteed ceiling.
WHY: A big ask can cap price temporarily; it isn't a certainty.

[TF] A large resting order guarantees price stops there.
ANSWER: False
WHY: It can be absorbed or pulled. It's a clue, not a guarantee.

[MATCH] Match each wall to its effect.
Large bid => Support
Large ask => Resistance
Pulled wall => Level vanishes
WHY: Big bids hold price up, big asks cap it — until they're pulled.

[ORDER] Order how a defended bid holds.
Price falls toward a large bid
Sellers hit into it
The bid absorbs the selling
Price holds above it
WHY: A big resting bid can soak up selling and hold price above it.

[AGGRESSOR] Tap the aggressor.
EVENT: hit
ANSWER: The seller
WHY: Bids being taken means the seller is the aggressor.

[BOOKDRAG] Tap the side this buy fills against.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy fills at the ask.

NODE 11
TITLE: Pulling & Spoofing
CELEBRATION: You know the book is live and can deceive.

[MC] What can happen to a resting order before it fills?
It can be cancelled anytime.
It's locked until it fills.
It becomes a market order.
WHY: Resting orders can be pulled at any moment — nothing forces them to trade.

[MC] An order that keeps vanishing before it trades may be…
Spoofing.
Absorption.
A breakout.
WHY: Orders shown then pulled to mislead is spoofing. Absorption actually fills; a breakout is a price move.

[TF] A resting order is a firm promise to trade.
ANSWER: False
WHY: It can be cancelled before anyone hits it.

[MATCH] Match each behavior.
Pulled order => Cancelled before filling
Refreshed order => Replenished after filling
Spoof => Shown then pulled
WHY: The book is live: orders appear, refill, and disappear.

[AGGRESSOR] Tap the aggressor.
EVENT: lift
ANSWER: The buyer
WHY: Offers being taken means the buyer is the aggressor.

[BOOKDRAG] Tap the side this sell fills against.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[ORDER] Order a spoof playing out.
A big bid appears below price
Traders see support and buy
The big bid is pulled
Support vanishes
WHY: A displayed order that gets pulled can lure others in before it ever trades.

NODE 12
TITLE: The Order Book Review
CELEBRATION: The order book is yours — you read depth, walls and tricks.

[MC] What does Level II show?
The full depth of resting orders.
Just the best bid and ask.
Executed trades.
WHY: Level II is the full ladder of resting orders on both sides.

[BOOKDRAG] Tap the side this buy fills against.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Tap the side this sell fills against.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[AGGRESSOR] Tap the aggressor.
EVENT: lift
ANSWER: The buyer
WHY: Offers being consumed means the buyer is the aggressor.

[MATCH] Match each order-book idea.
Bid side => Resting buyers
Ask side => Resting sellers
Large order => Temporary wall
Pulled order => Cancelled before filling
WHY: The backbone of reading a book: sides, walls, and the fact orders can vanish.

[TF] A large resting order guarantees price stops there.
ANSWER: False
WHY: It can be absorbed or pulled — descriptive, not a guarantee.

[MC] A large resting bid acts as…
Temporary support.
Temporary resistance.
A guaranteed floor.
WHY: A big bid holds price up temporarily, but it can be pulled.

[ORDER] Order how a wall gets tested.
Price approaches a large resting order
Aggressors trade into it
It absorbs them and price stalls
The wall holds or gets pulled
WHY: A wall stalls price while it absorbs — then it either holds or disappears.
