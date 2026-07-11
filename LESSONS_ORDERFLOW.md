# Order Flow strategy course authoring source

Course id: `orderflow` · accent `#14B8A6` · standalone strategy track.
Mirrors `Moko/GameData.json`. Correct answers appear first for choice and fill questions.
No intro blocks. Most questions render an order book, chart, or live chart.

Interactive mechanics:
  [AGGRESSOR] Watch a live ladder and choose the aggressive side.
  [BOOKDRAG] Route a market order to the bid or ask.
  [TAP_CANDLE] Select a candle directly on a chart.
  [TRENDLINE] Connect two candles on a chart.
  [LIVE_CHART] Read pressure while candles update.

TOTAL UNITS: 10
TOTAL LESSONS: 90
TOTAL QUESTIONS: 631

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
WHY: Level I is the top of the book. the single best bid and best ask.

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
WHY: A market buy takes the resting offers. it fills at the ask.

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
WHY: The number is resting size. how many shares sit waiting at that price.

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
WHY: A big bid can hold price up for a while. but it can be pulled or absorbed, so it's not a guarantee.

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
WHY: Big bids hold price up, big asks cap it. until they're pulled.

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
WHY: Resting orders can be pulled at any moment. nothing forces them to trade.

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
CELEBRATION: The order book is yours. you read depth, walls and tricks.

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

[MATCH] Match each order book idea.
Bid side => Resting buyers
Ask side => Resting sellers
Large order => Temporary wall
Pulled order => Cancelled before filling
WHY: The backbone of reading a book: sides, walls, and the fact orders can vanish.

[TF] A large resting order guarantees price stops there.
ANSWER: False
WHY: It can be absorbed or pulled. descriptive, not a guarantee.

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
WHY: A wall stalls price while it absorbs. then it either holds or disappears.


UNIT 3 — Tape Reading

NODE 13
TITLE: Reading the Tape
CELEBRATION: Reading the Tape complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: sideways
Prints reveal completed trades
The next move is guaranteed
Only candle color matters
WHY: Prints reveal completed trades.

[TRENDLINE] Connect the first and last candle.
CHART: sideways
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: sideways
executed trades
company size
news schedule
WHY: Focus on executed trades.

[MATCH] Match each clue.
CHART: sideways
Reading the Tape => Executed trades
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 14
TITLE: Trade Speed
CELEBRATION: Trade Speed complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: volatile
Faster prints can reveal rising activity
The next move is guaranteed
Only candle color matters
WHY: Faster prints can reveal rising activity.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: volatile
faster prints
company size
news schedule
WHY: Focus on faster prints.

[MATCH] Match each clue.
CHART: volatile
Trade Speed => Faster prints
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: volatile
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 15
TITLE: Trade Size
CELEBRATION: Trade Size complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: marubozu
Larger trades can show stronger participation
The next move is guaranteed
Only candle color matters
WHY: Larger trades can show stronger participation.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: marubozu
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: marubozu
larger trades
company size
news schedule
WHY: Focus on larger trades.

[MATCH] Match each clue.
CHART: marubozu
Trade Size => Larger trades
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: marubozu
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 16
TITLE: Repeated Prints
CELEBRATION: Repeated Prints complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: uptrend
Repeated buys can show persistent demand
The next move is guaranteed
Only candle color matters
WHY: Repeated buys can show persistent demand.

[TRENDLINE] Connect the first and last candle.
CHART: uptrend
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: uptrend
repeated buying
company size
news schedule
WHY: Focus on repeated buying.

[MATCH] Match each clue.
CHART: uptrend
Repeated Prints => Repeated buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: uptrend
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 17
TITLE: Buyer Initiated Prints
CELEBRATION: Buyer Initiated Prints complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: priceAboveVWAP
Trades at the ask suggest buyer aggression
The next move is guaranteed
Only candle color matters
WHY: Trades at the ask suggest buyer aggression.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: priceAboveVWAP
ask prints
company size
news schedule
WHY: Focus on ask prints.

[MATCH] Match each clue.
CHART: priceAboveVWAP
Buyer Initiated Prints => Ask prints
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: priceAboveVWAP
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 18
TITLE: Seller Initiated Prints
CELEBRATION: Seller Initiated Prints complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: priceBelowVWAP
Trades at the bid suggest seller aggression
The next move is guaranteed
Only candle color matters
WHY: Trades at the bid suggest seller aggression.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: priceBelowVWAP
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: priceBelowVWAP
bid prints
company size
news schedule
WHY: Focus on bid prints.

[MATCH] Match each clue.
CHART: priceBelowVWAP
Seller Initiated Prints => Bid prints
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: priceBelowVWAP
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 19
TITLE: Pace Changes
CELEBRATION: Pace Changes complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bandsWidening
A faster pace can precede expansion
The next move is guaranteed
Only candle color matters
WHY: A faster pace can precede expansion.

[TRENDLINE] Connect the first and last candle.
CHART: bandsWidening
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: bandsWidening
rising pace
company size
news schedule
WHY: Focus on rising pace.

[MATCH] Match each clue.
CHART: bandsWidening
Pace Changes => Rising pace
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bandsWidening
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 20
TITLE: Tape at Key Levels
CELEBRATION: Tape at Key Levels complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: resistanceRejection
Tape reaction matters most near key levels
The next move is guaranteed
Only candle color matters
WHY: Tape reaction matters most near key levels.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: resistanceRejection
reaction at resistance
company size
news schedule
WHY: Focus on reaction at resistance.

[MATCH] Match each clue.
CHART: resistanceRejection
Tape at Key Levels => Reaction at resistance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 21
TITLE: False Urgency
CELEBRATION: False Urgency complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: spinningTop
Fast prints need price confirmation
The next move is guaranteed
Only candle color matters
WHY: Fast prints need price confirmation.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: spinningTop
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: spinningTop
follow through
company size
news schedule
WHY: Focus on follow through.

[MATCH] Match each clue.
CHART: spinningTop
False Urgency => Follow through
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 22
TITLE: Tape Reading Review
CELEBRATION: Tape Reading Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: volatile
Read pace, size, direction, and response together
The next move is guaranteed
Only candle color matters
WHY: Read pace, size, direction, and response together.

[TRENDLINE] Connect the first and last candle.
CHART: volatile
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: volatile
pace and direction
company size
news schedule
WHY: Focus on pace and direction.

[MATCH] Match each clue.
CHART: volatile
Tape Reading Review => Pace and direction
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 4 — Absorption and Exhaustion

NODE 23
TITLE: What Is Absorption
CELEBRATION: What Is Absorption complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: sideways
Absorption appears when pressure fails to move price
The next move is guaranteed
Only candle color matters
WHY: Absorption appears when pressure fails to move price.

[LIVE_CHART] Read the live pressure.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: sideways
price holding
company size
news schedule
WHY: Focus on price holding.

[MATCH] Match each clue.
CHART: sideways
What Is Absorption => Price holding
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 24
TITLE: Buyer Absorption
CELEBRATION: Buyer Absorption complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: supportBounce
Buyers absorb selling near support
The next move is guaranteed
Only candle color matters
WHY: Buyers absorb selling near support.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: supportBounce
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: supportBounce
bids holding
company size
news schedule
WHY: Focus on bids holding.

[MATCH] Match each clue.
CHART: supportBounce
Buyer Absorption => Bids holding
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 25
TITLE: Seller Absorption
CELEBRATION: Seller Absorption complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: resistanceRejection
Sellers absorb buying near resistance
The next move is guaranteed
Only candle color matters
WHY: Sellers absorb buying near resistance.

[TRENDLINE] Connect the first and last candle.
CHART: resistanceRejection
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: resistanceRejection
offers holding
company size
news schedule
WHY: Focus on offers holding.

[MATCH] Match each clue.
CHART: resistanceRejection
Seller Absorption => Offers holding
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 26
TITLE: Repeated Tests
CELEBRATION: Repeated Tests complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: doubleBottom
A level that survives tests may contain absorption
The next move is guaranteed
Only candle color matters
WHY: A level that survives tests may contain absorption.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: doubleBottom
level survival
company size
news schedule
WHY: Focus on level survival.

[MATCH] Match each clue.
CHART: doubleBottom
Repeated Tests => Level survival
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: doubleBottom
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 27
TITLE: Hidden Liquidity
CELEBRATION: Hidden Liquidity complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: range
Refreshing liquidity can hide true available size
The next move is guaranteed
Only candle color matters
WHY: Refreshing liquidity can hide true available size.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: range
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: range
replenishing size
company size
news schedule
WHY: Focus on replenishing size.

[MATCH] Match each clue.
CHART: range
Hidden Liquidity => Replenishing size
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: range
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 28
TITLE: What Is Exhaustion
CELEBRATION: What Is Exhaustion complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: doji
Exhaustion appears when aggressive pressure fades
The next move is guaranteed
Only candle color matters
WHY: Exhaustion appears when aggressive pressure fades.

[TRENDLINE] Connect the first and last candle.
CHART: doji
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: doji
slowing aggression
company size
news schedule
WHY: Focus on slowing aggression.

[MATCH] Match each clue.
CHART: doji
What Is Exhaustion => Slowing aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: doji
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 29
TITLE: Buyer Exhaustion
CELEBRATION: Buyer Exhaustion complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: shootingStar
Fading buyers can stall an advance
The next move is guaranteed
Only candle color matters
WHY: Fading buyers can stall an advance.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: shootingStar
weaker buying
company size
news schedule
WHY: Focus on weaker buying.

[MATCH] Match each clue.
CHART: shootingStar
Buyer Exhaustion => Weaker buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: shootingStar
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 30
TITLE: Seller Exhaustion
CELEBRATION: Seller Exhaustion complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: hammer
Fading sellers can stall a decline
The next move is guaranteed
Only candle color matters
WHY: Fading sellers can stall a decline.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: hammer
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: hammer
weaker selling
company size
news schedule
WHY: Focus on weaker selling.

[MATCH] Match each clue.
CHART: hammer
Seller Exhaustion => Weaker selling
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: hammer
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 31
TITLE: Absorption or Exhaustion
CELEBRATION: Absorption or Exhaustion complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: spinningTop
Price response separates absorption from exhaustion
The next move is guaranteed
Only candle color matters
WHY: Price response separates absorption from exhaustion.

[TRENDLINE] Connect the first and last candle.
CHART: spinningTop
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: spinningTop
price response
company size
news schedule
WHY: Focus on price response.

[MATCH] Match each clue.
CHART: spinningTop
Absorption or Exhaustion => Price response
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 32
TITLE: Absorption Review
CELEBRATION: Absorption Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: rejectionWickDown
Strong pressure with little movement suggests absorption
The next move is guaranteed
Only candle color matters
WHY: Strong pressure with little movement suggests absorption.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: rejectionWickDown
pressure without movement
company size
news schedule
WHY: Focus on pressure without movement.

[MATCH] Match each clue.
CHART: rejectionWickDown
Absorption Review => Pressure without movement
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: rejectionWickDown
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 5 — Imbalances and Momentum

NODE 33
TITLE: Order Imbalance
CELEBRATION: Order Imbalance complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: volatile
Imbalance means one side is more aggressive
The next move is guaranteed
Only candle color matters
WHY: Imbalance means one side is more aggressive.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: volatile
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: volatile
uneven aggression
company size
news schedule
WHY: Focus on uneven aggression.

[MATCH] Match each clue.
CHART: volatile
Order Imbalance => Uneven aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: volatile
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 34
TITLE: Buyer Imbalance
CELEBRATION: Buyer Imbalance complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: uptrend
Buyer imbalance can push price higher
The next move is guaranteed
Only candle color matters
WHY: Buyer imbalance can push price higher.

[TRENDLINE] Connect the first and last candle.
CHART: uptrend
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: uptrend
offers consumed
company size
news schedule
WHY: Focus on offers consumed.

[MATCH] Match each clue.
CHART: uptrend
Buyer Imbalance => Offers consumed
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: uptrend
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 35
TITLE: Seller Imbalance
CELEBRATION: Seller Imbalance complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: downtrend
Seller imbalance can push price lower
The next move is guaranteed
Only candle color matters
WHY: Seller imbalance can push price lower.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: downtrend
bids consumed
company size
news schedule
WHY: Focus on bids consumed.

[MATCH] Match each clue.
CHART: downtrend
Seller Imbalance => Bids consumed
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: downtrend
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 36
TITLE: Momentum Ignition
CELEBRATION: Momentum Ignition complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakout
Sudden aggression can ignite momentum
The next move is guaranteed
Only candle color matters
WHY: Sudden aggression can ignite momentum.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: breakout
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: breakout
sudden aggression
company size
news schedule
WHY: Focus on sudden aggression.

[MATCH] Match each clue.
CHART: breakout
Momentum Ignition => Sudden aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakout
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 37
TITLE: Momentum Continuation
CELEBRATION: Momentum Continuation complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bullFlag
Renewed buying can continue momentum
The next move is guaranteed
Only candle color matters
WHY: Renewed buying can continue momentum.

[TRENDLINE] Connect the first and last candle.
CHART: bullFlag
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: bullFlag
renewed buying
company size
news schedule
WHY: Focus on renewed buying.

[MATCH] Match each clue.
CHART: bullFlag
Momentum Continuation => Renewed buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bullFlag
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 38
TITLE: Momentum Failure
CELEBRATION: Momentum Failure complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: shootingStar
Momentum weakens when price stops responding
The next move is guaranteed
Only candle color matters
WHY: Momentum weakens when price stops responding.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: shootingStar
lost follow through
company size
news schedule
WHY: Focus on lost follow through.

[MATCH] Match each clue.
CHART: shootingStar
Momentum Failure => Lost follow through
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: shootingStar
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 39
TITLE: Stacked Pressure
CELEBRATION: Stacked Pressure complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: marubozu
Pressure across several levels strengthens the move
The next move is guaranteed
Only candle color matters
WHY: Pressure across several levels strengthens the move.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: marubozu
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: marubozu
pressure across levels
company size
news schedule
WHY: Focus on pressure across levels.

[MATCH] Match each clue.
CHART: marubozu
Stacked Pressure => Pressure across levels
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: marubozu
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 40
TITLE: Delta Thinking
CELEBRATION: Delta Thinking complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bandsWidening
Net aggression compares buying with selling
The next move is guaranteed
Only candle color matters
WHY: Net aggression compares buying with selling.

[TRENDLINE] Connect the first and last candle.
CHART: bandsWidening
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: bandsWidening
net aggression
company size
news schedule
WHY: Focus on net aggression.

[MATCH] Match each clue.
CHART: bandsWidening
Delta Thinking => Net aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bandsWidening
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 41
TITLE: Price and Pressure Divergence
CELEBRATION: Price and Pressure Divergence complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bearishEngulfing
Price and pressure disagreement warns of weakness
The next move is guaranteed
Only candle color matters
WHY: Price and pressure disagreement warns of weakness.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: bearishEngulfing
pressure disagreement
company size
news schedule
WHY: Focus on pressure disagreement.

[MATCH] Match each clue.
CHART: bearishEngulfing
Price and Pressure Divergence => Pressure disagreement
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bearishEngulfing
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 42
TITLE: Imbalance Review
CELEBRATION: Imbalance Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: maCrossUp
Sustained imbalance matters more than one burst
The next move is guaranteed
Only candle color matters
WHY: Sustained imbalance matters more than one burst.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: maCrossUp
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: maCrossUp
sustained aggression
company size
news schedule
WHY: Focus on sustained aggression.

[MATCH] Match each clue.
CHART: maCrossUp
Imbalance Review => Sustained aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: maCrossUp
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 6 — Liquidity and Sweeps

NODE 43
TITLE: Liquidity Pools
CELEBRATION: Liquidity Pools complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: range
Liquidity often gathers near obvious levels
The next move is guaranteed
Only candle color matters
WHY: Liquidity often gathers near obvious levels.

[TRENDLINE] Connect the first and last candle.
CHART: range
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: range
clustered orders
company size
news schedule
WHY: Focus on clustered orders.

[MATCH] Match each clue.
CHART: range
Liquidity Pools => Clustered orders
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: range
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 44
TITLE: Resting Stops
CELEBRATION: Resting Stops complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: supportBounce
Stops often gather beyond support
The next move is guaranteed
Only candle color matters
WHY: Stops often gather beyond support.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: supportBounce
stops below support
company size
news schedule
WHY: Focus on stops below support.

[MATCH] Match each clue.
CHART: supportBounce
Resting Stops => Stops below support
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: supportBounce
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 45
TITLE: Buy Stops
CELEBRATION: Buy Stops complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakout
Buy stops can fuel an upside break
The next move is guaranteed
Only candle color matters
WHY: Buy stops can fuel an upside break.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: breakout
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: breakout
stops above resistance
company size
news schedule
WHY: Focus on stops above resistance.

[MATCH] Match each clue.
CHART: breakout
Buy Stops => Stops above resistance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakout
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 46
TITLE: Sell Stops
CELEBRATION: Sell Stops complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakdown
Sell stops can fuel a downside break
The next move is guaranteed
Only candle color matters
WHY: Sell stops can fuel a downside break.

[TRENDLINE] Connect the first and last candle.
CHART: breakdown
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: breakdown
stops below support
company size
news schedule
WHY: Focus on stops below support.

[MATCH] Match each clue.
CHART: breakdown
Sell Stops => Stops below support
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakdown
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 47
TITLE: Liquidity Sweep
CELEBRATION: Liquidity Sweep complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: rejectionWickDown
A sweep takes liquidity then returns
The next move is guaranteed
Only candle color matters
WHY: A sweep takes liquidity then returns.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: rejectionWickDown
quick level breach
company size
news schedule
WHY: Focus on quick level breach.

[MATCH] Match each clue.
CHART: rejectionWickDown
Liquidity Sweep => Quick level breach
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: rejectionWickDown
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 48
TITLE: Upside Sweep
CELEBRATION: Upside Sweep complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: rejectionWickUp
An upside sweep can trap late buyers
The next move is guaranteed
Only candle color matters
WHY: An upside sweep can trap late buyers.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: rejectionWickUp
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: rejectionWickUp
failed push above
company size
news schedule
WHY: Focus on failed push above.

[MATCH] Match each clue.
CHART: rejectionWickUp
Upside Sweep => Failed push above
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 49
TITLE: Downside Sweep
CELEBRATION: Downside Sweep complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: hammer
A downside sweep can trap late sellers
The next move is guaranteed
Only candle color matters
WHY: A downside sweep can trap late sellers.

[TRENDLINE] Connect the first and last candle.
CHART: hammer
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: hammer
failed push below
company size
news schedule
WHY: Focus on failed push below.

[MATCH] Match each clue.
CHART: hammer
Downside Sweep => Failed push below
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: hammer
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 50
TITLE: Sweep or Breakout
CELEBRATION: Sweep or Breakout complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakoutRetest
Acceptance beyond a level supports a breakout
The next move is guaranteed
Only candle color matters
WHY: Acceptance beyond a level supports a breakout.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: breakoutRetest
acceptance beyond level
company size
news schedule
WHY: Focus on acceptance beyond level.

[MATCH] Match each clue.
CHART: breakoutRetest
Sweep or Breakout => Acceptance beyond level
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 51
TITLE: Thin Liquidity
CELEBRATION: Thin Liquidity complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: gapUp
Thin liquidity lets price travel quickly
The next move is guaranteed
Only candle color matters
WHY: Thin liquidity lets price travel quickly.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: gapUp
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: gapUp
few nearby orders
company size
news schedule
WHY: Focus on few nearby orders.

[MATCH] Match each clue.
CHART: gapUp
Thin Liquidity => Few nearby orders
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: gapUp
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 52
TITLE: Liquidity Review
CELEBRATION: Liquidity Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: volatile
Judge liquidity events by location and response
The next move is guaranteed
Only candle color matters
WHY: Judge liquidity events by location and response.

[TRENDLINE] Connect the first and last candle.
CHART: volatile
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: volatile
location and response
company size
news schedule
WHY: Focus on location and response.

[MATCH] Match each clue.
CHART: volatile
Liquidity Review => Location and response
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 7 — Breakouts and Failures

NODE 53
TITLE: Breakout Pressure
CELEBRATION: Breakout Pressure complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakout
A breakout needs offers to be consumed
The next move is guaranteed
Only candle color matters
WHY: A breakout needs offers to be consumed.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: breakout
offers cleared
company size
news schedule
WHY: Focus on offers cleared.

[MATCH] Match each clue.
CHART: breakout
Breakout Pressure => Offers cleared
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakout
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 54
TITLE: Breakdown Pressure
CELEBRATION: Breakdown Pressure complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakdown
A breakdown needs bids to be consumed
The next move is guaranteed
Only candle color matters
WHY: A breakdown needs bids to be consumed.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: breakdown
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: breakdown
bids cleared
company size
news schedule
WHY: Focus on bids cleared.

[MATCH] Match each clue.
CHART: breakdown
Breakdown Pressure => Bids cleared
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakdown
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 55
TITLE: Acceptance Above
CELEBRATION: Acceptance Above complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakoutRetest
Holding above a level shows acceptance
The next move is guaranteed
Only candle color matters
WHY: Holding above a level shows acceptance.

[TRENDLINE] Connect the first and last candle.
CHART: breakoutRetest
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: breakoutRetest
price holding above
company size
news schedule
WHY: Focus on price holding above.

[MATCH] Match each clue.
CHART: breakoutRetest
Acceptance Above => Price holding above
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 56
TITLE: Acceptance Below
CELEBRATION: Acceptance Below complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakdownRetest
Holding below a level shows acceptance
The next move is guaranteed
Only candle color matters
WHY: Holding below a level shows acceptance.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: breakdownRetest
price holding below
company size
news schedule
WHY: Focus on price holding below.

[MATCH] Match each clue.
CHART: breakdownRetest
Acceptance Below => Price holding below
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakdownRetest
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 57
TITLE: Failed Breakout
CELEBRATION: Failed Breakout complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: resistanceRejection
A quick return below resistance signals failure
The next move is guaranteed
Only candle color matters
WHY: A quick return below resistance signals failure.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: resistanceRejection
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: resistanceRejection
return below resistance
company size
news schedule
WHY: Focus on return below resistance.

[MATCH] Match each clue.
CHART: resistanceRejection
Failed Breakout => Return below resistance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 58
TITLE: Failed Breakdown
CELEBRATION: Failed Breakdown complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: supportBounce
A quick return above support signals failure
The next move is guaranteed
Only candle color matters
WHY: A quick return above support signals failure.

[TRENDLINE] Connect the first and last candle.
CHART: supportBounce
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: supportBounce
return above support
company size
news schedule
WHY: Focus on return above support.

[MATCH] Match each clue.
CHART: supportBounce
Failed Breakdown => Return above support
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 59
TITLE: Breakout Retest
CELEBRATION: Breakout Retest complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakoutRetest
A defended retest can confirm a breakout
The next move is guaranteed
Only candle color matters
WHY: A defended retest can confirm a breakout.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: breakoutRetest
support on retest
company size
news schedule
WHY: Focus on support on retest.

[MATCH] Match each clue.
CHART: breakoutRetest
Breakout Retest => Support on retest
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 60
TITLE: Breakdown Retest
CELEBRATION: Breakdown Retest complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakdownRetest
A rejected retest can confirm a breakdown
The next move is guaranteed
Only candle color matters
WHY: A rejected retest can confirm a breakdown.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: breakdownRetest
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: breakdownRetest
resistance on retest
company size
news schedule
WHY: Focus on resistance on retest.

[MATCH] Match each clue.
CHART: breakdownRetest
Breakdown Retest => Resistance on retest
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakdownRetest
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 61
TITLE: Chasing Breakouts
CELEBRATION: Chasing Breakouts complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: gapUp
Late entries carry worse risk and reward
The next move is guaranteed
Only candle color matters
WHY: Late entries carry worse risk and reward.

[TRENDLINE] Connect the first and last candle.
CHART: gapUp
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: gapUp
entry distance
company size
news schedule
WHY: Focus on entry distance.

[MATCH] Match each clue.
CHART: gapUp
Chasing Breakouts => Entry distance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: gapUp
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 62
TITLE: Breakout Review
CELEBRATION: Breakout Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: ascendingTriangle
Combine pressure, level break, and acceptance
The next move is guaranteed
Only candle color matters
WHY: Combine pressure, level break, and acceptance.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: ascendingTriangle
pressure and acceptance
company size
news schedule
WHY: Focus on pressure and acceptance.

[MATCH] Match each clue.
CHART: ascendingTriangle
Breakout Review => Pressure and acceptance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: ascendingTriangle
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 8 — Pullbacks and Continuation

NODE 63
TITLE: Healthy Pullbacks
CELEBRATION: Healthy Pullbacks complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: pullbackUptrend
A healthy pullback shows weaker counter pressure
The next move is guaranteed
Only candle color matters
WHY: A healthy pullback shows weaker counter pressure.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: pullbackUptrend
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: pullbackUptrend
lighter selling
company size
news schedule
WHY: Focus on lighter selling.

[MATCH] Match each clue.
CHART: pullbackUptrend
Healthy Pullbacks => Lighter selling
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: pullbackUptrend
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 64
TITLE: Pullback Depth
CELEBRATION: Pullback Depth complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: ascendingChannel
Shallow defended pullbacks show trend strength
The next move is guaranteed
Only candle color matters
WHY: Shallow defended pullbacks show trend strength.

[TRENDLINE] Connect the first and last candle.
CHART: ascendingChannel
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: ascendingChannel
defended structure
company size
news schedule
WHY: Focus on defended structure.

[MATCH] Match each clue.
CHART: ascendingChannel
Pullback Depth => Defended structure
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: ascendingChannel
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 65
TITLE: Seller Pullback
CELEBRATION: Seller Pullback complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: lowerHighsDowntrend
A bearish pullback shows weaker buying
The next move is guaranteed
Only candle color matters
WHY: A bearish pullback shows weaker buying.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: lowerHighsDowntrend
lighter buying
company size
news schedule
WHY: Focus on lighter buying.

[MATCH] Match each clue.
CHART: lowerHighsDowntrend
Seller Pullback => Lighter buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: lowerHighsDowntrend
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 66
TITLE: Continuation Trigger
CELEBRATION: Continuation Trigger complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bullFlag
Continuation begins when trend pressure returns
The next move is guaranteed
Only candle color matters
WHY: Continuation begins when trend pressure returns.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: bullFlag
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: bullFlag
buyers return
company size
news schedule
WHY: Focus on buyers return.

[MATCH] Match each clue.
CHART: bullFlag
Continuation Trigger => Buyers return
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bullFlag
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 67
TITLE: Bearish Continuation
CELEBRATION: Bearish Continuation complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bearFlag
Bearish continuation begins when sellers return
The next move is guaranteed
Only candle color matters
WHY: Bearish continuation begins when sellers return.

[TRENDLINE] Connect the first and last candle.
CHART: bearFlag
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: bearFlag
sellers return
company size
news schedule
WHY: Focus on sellers return.

[MATCH] Match each clue.
CHART: bearFlag
Bearish Continuation => Sellers return
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bearFlag
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 68
TITLE: VWAP Pullback
CELEBRATION: VWAP Pullback complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: priceAboveVWAP
VWAP can organize pullback decisions
The next move is guaranteed
Only candle color matters
WHY: VWAP can organize pullback decisions.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: priceAboveVWAP
support near VWAP
company size
news schedule
WHY: Focus on support near VWAP.

[MATCH] Match each clue.
CHART: priceAboveVWAP
VWAP Pullback => Support near vwap
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: priceAboveVWAP
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 69
TITLE: Moving Average Pullback
CELEBRATION: Moving Average Pullback complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: priceAboveMA
An average can frame a trend pullback
The next move is guaranteed
Only candle color matters
WHY: An average can frame a trend pullback.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: priceAboveMA
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: priceAboveMA
support near average
company size
news schedule
WHY: Focus on support near average.

[MATCH] Match each clue.
CHART: priceAboveMA
Moving Average Pullback => Support near average
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: priceAboveMA
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 70
TITLE: Pullback Failure
CELEBRATION: Pullback Failure complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bearishEngulfing
Strong counter pressure can end continuation
The next move is guaranteed
Only candle color matters
WHY: Strong counter pressure can end continuation.

[TRENDLINE] Connect the first and last candle.
CHART: bearishEngulfing
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: bearishEngulfing
counter pressure grows
company size
news schedule
WHY: Focus on counter pressure grows.

[MATCH] Match each clue.
CHART: bearishEngulfing
Pullback Failure => Counter pressure grows
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bearishEngulfing
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 71
TITLE: Entry After Confirmation
CELEBRATION: Entry After Confirmation complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakoutRetest
Wait for pressure to return before entry
The next move is guaranteed
Only candle color matters
WHY: Wait for pressure to return before entry.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: breakoutRetest
pressure returns
company size
news schedule
WHY: Focus on pressure returns.

[MATCH] Match each clue.
CHART: breakoutRetest
Entry After Confirmation => Pressure returns
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 72
TITLE: Continuation Review
CELEBRATION: Continuation Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bullFlag
Continuation needs structure and renewed pressure
The next move is guaranteed
Only candle color matters
WHY: Continuation needs structure and renewed pressure.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: bullFlag
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: bullFlag
trend pressure returns
company size
news schedule
WHY: Focus on trend pressure returns.

[MATCH] Match each clue.
CHART: bullFlag
Continuation Review => Trend pressure returns
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bullFlag
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 9 — Reversals and Traps

NODE 73
TITLE: Reversal Pressure
CELEBRATION: Reversal Pressure complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bullishEngulfing
Reversals need a clear change in control
The next move is guaranteed
Only candle color matters
WHY: Reversals need a clear change in control.

[TRENDLINE] Connect the first and last candle.
CHART: bullishEngulfing
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: bullishEngulfing
control changes
company size
news schedule
WHY: Focus on control changes.

[MATCH] Match each clue.
CHART: bullishEngulfing
Reversal Pressure => Control changes
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bullishEngulfing
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 74
TITLE: Buyer Trap
CELEBRATION: Buyer Trap complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: shootingStar
A buyer trap forms when a breakout fails
The next move is guaranteed
Only candle color matters
WHY: A buyer trap forms when a breakout fails.

[LIVE_CHART] Read the live pressure.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: shootingStar
failed buying
company size
news schedule
WHY: Focus on failed buying.

[MATCH] Match each clue.
CHART: shootingStar
Buyer Trap => Failed buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: shootingStar
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 75
TITLE: Seller Trap
CELEBRATION: Seller Trap complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: hammer
A seller trap forms when a breakdown fails
The next move is guaranteed
Only candle color matters
WHY: A seller trap forms when a breakdown fails.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: hammer
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: hammer
failed selling
company size
news schedule
WHY: Focus on failed selling.

[MATCH] Match each clue.
CHART: hammer
Seller Trap => Failed selling
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: hammer
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 76
TITLE: Exhaustion Reversal
CELEBRATION: Exhaustion Reversal complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: doji
Exhaustion can prepare a reversal
The next move is guaranteed
Only candle color matters
WHY: Exhaustion can prepare a reversal.

[TRENDLINE] Connect the first and last candle.
CHART: doji
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: doji
slowing pressure
company size
news schedule
WHY: Focus on slowing pressure.

[MATCH] Match each clue.
CHART: doji
Exhaustion Reversal => Slowing pressure
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: doji
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 77
TITLE: Absorption Reversal
CELEBRATION: Absorption Reversal complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: rejectionWickDown
Absorbed selling can support a reversal
The next move is guaranteed
Only candle color matters
WHY: Absorbed selling can support a reversal.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: rejectionWickDown
selling absorbed
company size
news schedule
WHY: Focus on selling absorbed.

[MATCH] Match each clue.
CHART: rejectionWickDown
Absorption Reversal => Selling absorbed
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: rejectionWickDown
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 78
TITLE: Double Top Flow
CELEBRATION: Double Top Flow complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: doubleTop
Repeated failure can shift control to sellers
The next move is guaranteed
Only candle color matters
WHY: Repeated failure can shift control to sellers.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: doubleTop
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: doubleTop
buyers fail twice
company size
news schedule
WHY: Focus on buyers fail twice.

[MATCH] Match each clue.
CHART: doubleTop
Double Top Flow => Buyers fail twice
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: doubleTop
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 79
TITLE: Double Bottom Flow
CELEBRATION: Double Bottom Flow complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: doubleBottom
Repeated failure can shift control to buyers
The next move is guaranteed
Only candle color matters
WHY: Repeated failure can shift control to buyers.

[TRENDLINE] Connect the first and last candle.
CHART: doubleBottom
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: doubleBottom
sellers fail twice
company size
news schedule
WHY: Focus on sellers fail twice.

[MATCH] Match each clue.
CHART: doubleBottom
Double Bottom Flow => Sellers fail twice
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: doubleBottom
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 80
TITLE: Confirmation Before Entry
CELEBRATION: Confirmation Before Entry complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bullishEngulfing
Confirmation reduces premature reversal entries
The next move is guaranteed
Only candle color matters
WHY: Confirmation reduces premature reversal entries.

[LIVE_CHART] Read the live pressure.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: bullishEngulfing
price confirms pressure
company size
news schedule
WHY: Focus on price confirms pressure.

[MATCH] Match each clue.
CHART: bullishEngulfing
Confirmation Before Entry => Price confirms pressure
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bullishEngulfing
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 81
TITLE: Reversal Review
CELEBRATION: Reversal Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: inverseHeadShoulders
A reversal needs control change and confirmation
The next move is guaranteed
Only candle color matters
WHY: A reversal needs control change and confirmation.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: inverseHeadShoulders
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: inverseHeadShoulders
control and confirmation
company size
news schedule
WHY: Focus on control and confirmation.

[MATCH] Match each clue.
CHART: inverseHeadShoulders
Reversal Review => Control and confirmation
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: inverseHeadShoulders
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 10 — Execution and Risk

NODE 82
TITLE: Plan the Entry
CELEBRATION: Plan the Entry complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: breakoutRetest
A clear trigger keeps execution disciplined
The next move is guaranteed
Only candle color matters
WHY: A clear trigger keeps execution disciplined.

[TRENDLINE] Connect the first and last candle.
CHART: breakoutRetest
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: breakoutRetest
defined trigger
company size
news schedule
WHY: Focus on defined trigger.

[MATCH] Match each clue.
CHART: breakoutRetest
Plan the Entry => Defined trigger
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 83
TITLE: Choose the Order Type
CELEBRATION: Choose the Order Type complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: sideways
Order choice balances speed with price control
The next move is guaranteed
Only candle color matters
WHY: Order choice balances speed with price control.

[LIVE_CHART] Read the live pressure.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: sideways
speed versus price
company size
news schedule
WHY: Focus on speed versus price.

[MATCH] Match each clue.
CHART: sideways
Choose the Order Type => Speed versus price
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 84
TITLE: Manage Slippage
CELEBRATION: Manage Slippage complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: volatile
Thin liquidity can increase slippage
The next move is guaranteed
Only candle color matters
WHY: Thin liquidity can increase slippage.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: volatile
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: volatile
available liquidity
company size
news schedule
WHY: Focus on available liquidity.

[MATCH] Match each clue.
CHART: volatile
Manage Slippage => Available liquidity
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 85
TITLE: Place the Stop
CELEBRATION: Place the Stop complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: supportBounce
Stops belong where the trade idea fails
The next move is guaranteed
Only candle color matters
WHY: Stops belong where the trade idea fails.

[TRENDLINE] Connect the first and last candle.
CHART: supportBounce
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: supportBounce
invalidation level
company size
news schedule
WHY: Focus on invalidation level.

[MATCH] Match each clue.
CHART: supportBounce
Place the Stop => Invalidation level
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 86
TITLE: Size the Position
CELEBRATION: Size the Position complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: bandsWidening
Position size should follow planned risk
The next move is guaranteed
Only candle color matters
WHY: Position size should follow planned risk.

[LIVE_CHART] Read the live pressure.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: bandsWidening
risk amount
company size
news schedule
WHY: Focus on risk amount.

[MATCH] Match each clue.
CHART: bandsWidening
Size the Position => Risk amount
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: bandsWidening
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 87
TITLE: Avoid Overtrading
CELEBRATION: Avoid Overtrading complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: spinningTop
No clear signal means no trade
The next move is guaranteed
Only candle color matters
WHY: No clear signal means no trade.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: spinningTop
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: spinningTop
quality over activity
company size
news schedule
WHY: Focus on quality over activity.

[MATCH] Match each clue.
CHART: spinningTop
Avoid Overtrading => Quality over activity
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 88
TITLE: Exit Into Liquidity
CELEBRATION: Exit Into Liquidity complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: resistanceRejection
Liquidity can improve planned exits
The next move is guaranteed
Only candle color matters
WHY: Liquidity can improve planned exits.

[TRENDLINE] Connect the first and last candle.
CHART: resistanceRejection
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The key clue is [___].
CHART: resistanceRejection
available buyers or sellers
company size
news schedule
WHY: Focus on available buyers or sellers.

[MATCH] Match each clue.
CHART: resistanceRejection
Exit Into Liquidity => Available buyers or sellers
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 89
TITLE: Review the Trade
CELEBRATION: Review the Trade complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: sideways
Review execution separately from outcome
The next move is guaranteed
Only candle color matters
WHY: Review execution separately from outcome.

[LIVE_CHART] Read the live pressure.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[FILL] The key clue is [___].
CHART: sideways
process quality
company size
news schedule
WHY: Focus on process quality.

[MATCH] Match each clue.
CHART: sideways
Review the Trade => Process quality
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 90
TITLE: Order Flow Final Review
CELEBRATION: Order Flow Final Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[MC] What is the best read here?
CHART: volatile
Use order flow as context with defined risk
The next move is guaranteed
Only candle color matters
WHY: Use order flow as context with defined risk.

[TAP_CANDLE] Tap the newest confirmation candle.
CHART: volatile
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The key clue is [___].
CHART: volatile
context and risk
company size
news schedule
WHY: Focus on context and risk.

[MATCH] Match each clue.
CHART: volatile
Order Flow Final Review => Context and risk
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.
