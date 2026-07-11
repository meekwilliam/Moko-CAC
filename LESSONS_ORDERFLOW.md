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
  [TIME_SALES] Read an animated feed of completed trades.
  [FOOTPRINT] Compare bid and ask volume at each price.

TOTAL UNITS: 10
TOTAL LESSONS: 99
TOTAL QUESTIONS: 695

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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
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
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Market sell. Tap its fill side.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
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
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Buying now means paying the ask.

[BOOKDRAG] Sell now. Tap the fill side.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: The buyer is lifting the offer.

[AGGRESSOR] Bids are getting eaten. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
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
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[AGGRESSOR] Buyers keep lifting offers. Who controls?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Persistent lifting shows buyer control.

NODE 5
TITLE: Order Flow Foundations Review
CELEBRATION: Foundations mastered. You read the flow behind price.

[AGGRESSOR] Offers are consumed. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers consume offers.

[BOOKDRAG] Market buy. Tap the fill side.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Market sell. Tap the fill side.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
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
A single candle without execution context
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Sellers consume bids.


UNIT 2 — The Order Book

NODE 6
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: The offers are being taken, so the buyer is the aggressor lifting them.

[BOOKDRAG] Tap the side this buy fills against.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
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

NODE 7
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
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy lifts the ask.

[BOOKDRAG] Tap the side this sell fills against.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: The bids are being taken, so the seller is the aggressor.

NODE 8
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Offers being taken means the buyer is the aggressor.

[BOOKDRAG] Tap the side this sell fills against.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[ORDER] Order what happens as a thin book gets hit.
A small resting size sits at the bid
A market sell hits it
The bid clears fast
Price drops to the next level
WHY: Thin liquidity clears quickly, so price jumps to the next level.

NODE 9
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Bids being taken means the seller is the aggressor.

[BOOKDRAG] Tap the side this buy fills against.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy fills at the ask.

NODE 10
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Offers being taken means the buyer is the aggressor.

[BOOKDRAG] Tap the side this sell fills against.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[ORDER] Order a spoof playing out.
A big bid appears below price
Traders see support and buy
The big bid is pulled
Support vanishes
WHY: A displayed order that gets pulled can lure others in before it ever trades.

NODE 11
TITLE: The Order Book Review
CELEBRATION: The order book is yours. you read depth, walls and tricks.

[MC] What does Level II show?
The full depth of resting orders.
Just the best bid and ask.
Executed trades.
WHY: Level II is the full ladder of resting orders on both sides.

[BOOKDRAG] Tap the side this buy fills against.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Tap the side this sell fills against.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[AGGRESSOR] Tap the aggressor.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
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

NODE 12
TITLE: Foundations and Book Mixed Review
CELEBRATION: Foundations and Book Mixed Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
A complete read combines who acts where liquidity rests and how price responds
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: A complete read combines who acts where liquidity rests and how price responds.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
aggression liquidity and response
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on aggression liquidity and response.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
CHART: sideways
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 13
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
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Aggressive buyers are lifting offers.

[BOOKDRAG] Push price up. Tap the side buyers take.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Buyers take asks to move price higher.


UNIT 3 — Tape Reading

NODE 14
TITLE: Reading Time and Sales
CELEBRATION: Reading Time and Sales complete.

[TIME_SALES] What does this Time and Sales feed show?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints highlighted at the ask.
EVENT: lift
Buyers repeatedly trading at the ask
Sellers repeatedly trading at the bid
Only resting orders
WHY: Each row is a completed trade with time price size and side.

[TIME_SALES] Which side is initiating these trades?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints highlighted at the bid.
EVENT: hit
Sellers
Buyers
Neither side can initiate a trade
WHY: Trades at the bid are seller initiated.

[MC] Which is the best explanation of the full setup?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Time and Sales lists completed trades in sequence
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Time and Sales lists completed trades in sequence.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Reading Time and Sales => Price size and side
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[ORDER] Build the read in order.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 15
TITLE: Reading the Tape
CELEBRATION: Reading the Tape complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Reading the Tape => Executed trades
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which is the best explanation of the full setup?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Prints reveal completed trades
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Prints reveal completed trades.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
CHART: sideways
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
executed trades
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on executed trades.

[ORDER] Build the read in order.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 16
TITLE: Trade Speed
CELEBRATION: Trade Speed complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Faster prints can reveal rising activity
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Faster prints can reveal rising activity.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
faster prints
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on faster prints.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TRENDLINE] Connect the first and last candle.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control. The learner draws directly between two candles to mark the structure.
CHART: volatile
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[ORDER] Build the read in order.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 17
TITLE: Trade Size
CELEBRATION: Trade Size complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which is the best explanation of the full setup?
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range.
CHART: marubozu
Larger trades can show stronger participation
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Larger trades can show stronger participation.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range.
CHART: marubozu
Trade Size => Larger trades
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range.
CHART: marubozu
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 18
TITLE: Repeated Prints
CELEBRATION: Repeated Prints complete.

[MC] Which is the best explanation of the full setup?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
CHART: uptrend
Repeated buys can show persistent demand
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Repeated buys can show persistent demand.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right. The candles are tappable and the learner must select the requested candle.
CHART: uptrend
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
CHART: uptrend
repeated buying
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on repeated buying.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
CHART: uptrend
Repeated Prints => Repeated buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
CHART: uptrend
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 19
TITLE: Buyer Initiated Prints
CELEBRATION: Buyer Initiated Prints complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
Buyer Initiated Prints => Ask prints
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which is the best explanation of the full setup?
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
Trades at the ask suggest buyer aggression
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Trades at the ask suggest buyer aggression.

[TRENDLINE] Connect the first and last candle.
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support. The learner draws directly between two candles to mark the structure.
CHART: priceAboveVWAP
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
ask prints
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on ask prints.

[ORDER] Build the read in order.
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 20
TITLE: Seller Initiated Prints
CELEBRATION: Seller Initiated Prints complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: Candles trade below the VWAP line while rebounds test it as potential resistance.
CHART: priceBelowVWAP
Trades at the bid suggest seller aggression
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Trades at the bid suggest seller aggression.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Candles trade below the VWAP line while rebounds test it as potential resistance.
CHART: priceBelowVWAP
bid prints
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on bid prints.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[ORDER] Build the read in order.
VISUAL: Candles trade below the VWAP line while rebounds test it as potential resistance.
CHART: priceBelowVWAP
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 21
TITLE: Pace Changes
CELEBRATION: Pace Changes complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which is the best explanation of the full setup?
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
A faster pace can precede expansion
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: A faster pace can precede expansion.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Pace Changes => Rising pace
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart. The candles are tappable and the learner must select the requested candle.
CHART: bandsWidening
TARGET: 4
WHY: The newest candle confirms the current response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 22
TITLE: Tape at Key Levels
CELEBRATION: Tape at Key Levels complete.

[MC] Which is the best explanation of the full setup?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Tape reaction matters most near key levels
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Tape reaction matters most near key levels.

[TRENDLINE] Connect the first and last candle.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The learner draws directly between two candles to mark the structure.
CHART: resistanceRejection
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
reaction at resistance
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on reaction at resistance.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Tape at Key Levels => Reaction at resistance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 23
TITLE: False Urgency
CELEBRATION: False Urgency complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
False Urgency => Follow through
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which is the best explanation of the full setup?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Fast prints need price confirmation
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Fast prints need price confirmation.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
follow through
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on follow through.

[ORDER] Build the read in order.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 24
TITLE: Tape Reading Review
CELEBRATION: Tape Reading Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Read pace, size, direction, and response together
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Read pace, size, direction, and response together.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
pace and direction
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on pace and direction.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control. The candles are tappable and the learner must select the requested candle.
CHART: volatile
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 4 — Absorption and Exhaustion

NODE 25
TITLE: What Is Absorption
CELEBRATION: What Is Absorption complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MC] Which is the best explanation of the full setup?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Absorption appears when pressure fails to move price
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Absorption appears when pressure fails to move price.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
What Is Absorption => Price holding
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TRENDLINE] Connect the first and last candle.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The learner draws directly between two candles to mark the structure.
CHART: sideways
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 26
TITLE: Buyer Absorption
CELEBRATION: Buyer Absorption complete.

[MC] Which is the best explanation of the full setup?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Buyers absorb selling near support
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Buyers absorb selling near support.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
bids holding
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on bids holding.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Buyer Absorption => Bids holding
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 27
TITLE: Seller Absorption
CELEBRATION: Seller Absorption complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Seller Absorption => Offers holding
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which is the best explanation of the full setup?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Sellers absorb buying near resistance
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Sellers absorb buying near resistance.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The candles are tappable and the learner must select the requested candle.
CHART: resistanceRejection
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
offers holding
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on offers holding.

[ORDER] Build the read in order.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 28
TITLE: Repeated Tests
CELEBRATION: Repeated Tests complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: Price tests the same support area twice and rebounds after the second test.
CHART: doubleBottom
A level that survives tests may contain absorption
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: A level that survives tests may contain absorption.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price tests the same support area twice and rebounds after the second test.
CHART: doubleBottom
level survival
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on level survival.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TRENDLINE] Connect the first and last candle.
VISUAL: Price tests the same support area twice and rebounds after the second test. The learner draws directly between two candles to mark the structure.
CHART: doubleBottom
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[ORDER] Build the read in order.
VISUAL: Price tests the same support area twice and rebounds after the second test.
CHART: doubleBottom
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 29
TITLE: Hidden Liquidity
CELEBRATION: Hidden Liquidity complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MC] Which is the best explanation of the full setup?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Refreshing liquidity can hide true available size
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Refreshing liquidity can hide true available size.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Hidden Liquidity => Replenishing size
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 30
TITLE: What Is Exhaustion
CELEBRATION: What Is Exhaustion complete.

[MC] Which is the best explanation of the full setup?
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
CHART: doji
Exhaustion appears when aggressive pressure fades
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Exhaustion appears when aggressive pressure fades.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A narrow candle body with wicks on both sides shows little net price progress. The candles are tappable and the learner must select the requested candle.
CHART: doji
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
CHART: doji
slowing aggression
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on slowing aggression.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
CHART: doji
What Is Exhaustion => Slowing aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
CHART: doji
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 31
TITLE: Buyer Exhaustion
CELEBRATION: Buyer Exhaustion complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Buyer Exhaustion => Weaker buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which is the best explanation of the full setup?
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Fading buyers can stall an advance
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Fading buyers can stall an advance.

[TRENDLINE] Connect the first and last candle.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices. The learner draws directly between two candles to mark the structure.
CHART: shootingStar
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
weaker buying
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on weaker buying.

[ORDER] Build the read in order.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 32
TITLE: Seller Exhaustion
CELEBRATION: Seller Exhaustion complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
Fading sellers can stall a decline
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Fading sellers can stall a decline.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
weaker selling
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on weaker selling.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[ORDER] Build the read in order.
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 33
TITLE: Absorption or Exhaustion
CELEBRATION: Absorption or Exhaustion complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MC] Which is the best explanation of the full setup?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Price response separates absorption from exhaustion
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Price response separates absorption from exhaustion.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Absorption or Exhaustion => Price response
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress. The candles are tappable and the learner must select the requested candle.
CHART: spinningTop
TARGET: 4
WHY: The newest candle confirms the current response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 34
TITLE: Absorption Review
CELEBRATION: Absorption Review complete.

[MC] Which is the best explanation of the full setup?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Strong pressure with little movement suggests absorption
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Strong pressure with little movement suggests absorption.

[TRENDLINE] Connect the first and last candle.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick. The learner draws directly between two candles to mark the structure.
CHART: rejectionWickDown
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
pressure without movement
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on pressure without movement.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Absorption Review => Pressure without movement
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 35
TITLE: Tape and Absorption Mixed Review
CELEBRATION: Tape and Absorption Mixed Review complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Tape and Absorption Mixed Review => Aggression and price response
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which is the best explanation of the full setup?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Separate active pressure from the market response
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Separate active pressure from the market response.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
aggression and price response
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on aggression and price response.

[ORDER] Build the read in order.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 5 — Imbalances and Momentum

NODE 36
TITLE: Order Imbalance
CELEBRATION: Order Imbalance complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Imbalance means one side is more aggressive
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Imbalance means one side is more aggressive.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
uneven aggression
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on uneven aggression.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control. The candles are tappable and the learner must select the requested candle.
CHART: volatile
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 37
TITLE: Buyer Imbalance
CELEBRATION: Buyer Imbalance complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which is the best explanation of the full setup?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
CHART: uptrend
Buyer imbalance can push price higher
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Buyer imbalance can push price higher.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
CHART: uptrend
Buyer Imbalance => Offers consumed
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TRENDLINE] Connect the first and last candle.
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right. The learner draws directly between two candles to mark the structure.
CHART: uptrend
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
CHART: uptrend
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 38
TITLE: Seller Imbalance
CELEBRATION: Seller Imbalance complete.

[MC] Which is the best explanation of the full setup?
VISUAL: A sequence of lower highs and lower lows moves from the upper left toward the lower right.
CHART: downtrend
Seller imbalance can push price lower
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Seller imbalance can push price lower.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A sequence of lower highs and lower lows moves from the upper left toward the lower right.
CHART: downtrend
bids consumed
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on bids consumed.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A sequence of lower highs and lower lows moves from the upper left toward the lower right.
CHART: downtrend
Seller Imbalance => Bids consumed
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A sequence of lower highs and lower lows moves from the upper left toward the lower right.
CHART: downtrend
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 39
TITLE: Momentum Ignition
CELEBRATION: Momentum Ignition complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
Momentum Ignition => Sudden aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which is the best explanation of the full setup?
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
Sudden aggression can ignite momentum
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Sudden aggression can ignite momentum.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles. The candles are tappable and the learner must select the requested candle.
CHART: breakout
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
sudden aggression
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on sudden aggression.

[ORDER] Build the read in order.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 40
TITLE: Momentum Continuation
CELEBRATION: Momentum Continuation complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Renewed buying can continue momentum
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Renewed buying can continue momentum.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
renewed buying
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on renewed buying.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TRENDLINE] Connect the first and last candle.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
CHART: bullFlag
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[ORDER] Build the read in order.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 41
TITLE: Momentum Failure
CELEBRATION: Momentum Failure complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which is the best explanation of the full setup?
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Momentum weakens when price stops responding
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Momentum weakens when price stops responding.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Momentum Failure => Lost follow through
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 42
TITLE: Stacked Pressure
CELEBRATION: Stacked Pressure complete.

[MC] Which is the best explanation of the full setup?
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range.
CHART: marubozu
Pressure across several levels strengthens the move
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Pressure across several levels strengthens the move.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range. The candles are tappable and the learner must select the requested candle.
CHART: marubozu
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range.
CHART: marubozu
pressure across levels
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on pressure across levels.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range.
CHART: marubozu
Stacked Pressure => Pressure across levels
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range.
CHART: marubozu
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 43
TITLE: Delta Thinking
CELEBRATION: Delta Thinking complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Delta Thinking => Net aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which is the best explanation of the full setup?
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Net aggression compares buying with selling
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Net aggression compares buying with selling.

[TRENDLINE] Connect the first and last candle.
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart. The learner draws directly between two candles to mark the structure.
CHART: bandsWidening
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
net aggression
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on net aggression.

[ORDER] Build the read in order.
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 44
TITLE: Price and Pressure Divergence
CELEBRATION: Price and Pressure Divergence complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which is the best explanation of the full setup?
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
Price and pressure disagreement warns of weakness
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Price and pressure disagreement warns of weakness.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
pressure disagreement
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on pressure disagreement.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[ORDER] Build the read in order.
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 45
TITLE: Imbalance Review
CELEBRATION: Imbalance Review complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which is the best explanation of the full setup?
VISUAL: A faster moving average crosses above a slower average as candles begin rising.
CHART: maCrossUp
Sustained imbalance matters more than one burst
The pressure and price response point in opposite directions
One print is enough to confirm the next move
WHY: Sustained imbalance matters more than one burst.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: A faster moving average crosses above a slower average as candles begin rising.
CHART: maCrossUp
Imbalance Review => Sustained aggression
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A faster moving average crosses above a slower average as candles begin rising. The candles are tappable and the learner must select the requested candle.
CHART: maCrossUp
TARGET: 4
WHY: The newest candle confirms the current response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: A faster moving average crosses above a slower average as candles begin rising.
CHART: maCrossUp
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 6 — Liquidity and Sweeps

NODE 46
TITLE: Liquidity Pools
CELEBRATION: Liquidity Pools complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Liquidity often gathers near obvious levels
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Liquidity often gathers near obvious levels.

[TRENDLINE] Connect the first and last candle.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction. The learner draws directly between two candles to mark the structure.
CHART: range
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
clustered orders
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on clustered orders.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Liquidity Pools => Clustered orders
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 47
TITLE: Resting Stops
CELEBRATION: Resting Stops complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Resting Stops => Stops below support
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Stops often gather beyond support
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Stops often gather beyond support.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
stops below support
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on stops below support.

[ORDER] Build the read in order.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 48
TITLE: Buy Stops
CELEBRATION: Buy Stops complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
Buy stops can fuel an upside break
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Buy stops can fuel an upside break.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
stops above resistance
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on stops above resistance.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles. The candles are tappable and the learner must select the requested candle.
CHART: breakout
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 49
TITLE: Sell Stops
CELEBRATION: Sell Stops complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
Sell stops can fuel a downside break
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Sell stops can fuel a downside break.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
Sell Stops => Stops below support
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TRENDLINE] Connect the first and last candle.
VISUAL: Price drives below a visible support level with expanding bearish candles. The learner draws directly between two candles to mark the structure.
CHART: breakdown
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 50
TITLE: Liquidity Sweep
CELEBRATION: Liquidity Sweep complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
A sweep takes liquidity then returns
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A sweep takes liquidity then returns.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
quick level breach
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on quick level breach.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Liquidity Sweep => Quick level breach
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 51
TITLE: Upside Sweep
CELEBRATION: Upside Sweep complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
CHART: rejectionWickUp
Upside Sweep => Failed push above
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
CHART: rejectionWickUp
An upside sweep can trap late buyers
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: An upside sweep can trap late buyers.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick. The candles are tappable and the learner must select the requested candle.
CHART: rejectionWickUp
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
CHART: rejectionWickUp
failed push above
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on failed push above.

[ORDER] Build the read in order.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 52
TITLE: Downside Sweep
CELEBRATION: Downside Sweep complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
A downside sweep can trap late sellers
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A downside sweep can trap late sellers.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
failed push below
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on failed push below.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TRENDLINE] Connect the first and last candle.
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices. The learner draws directly between two candles to mark the structure.
CHART: hammer
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[ORDER] Build the read in order.
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 53
TITLE: Sweep or Breakout
CELEBRATION: Sweep or Breakout complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Acceptance beyond a level supports a breakout
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Acceptance beyond a level supports a breakout.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Sweep or Breakout => Acceptance beyond level
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 54
TITLE: Thin Liquidity
CELEBRATION: Thin Liquidity complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Thin liquidity lets price travel quickly
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Thin liquidity lets price travel quickly.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Price opens well above the prior trading area with little activity between the two zones. The candles are tappable and the learner must select the requested candle.
CHART: gapUp
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
few nearby orders
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on few nearby orders.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Thin Liquidity => Few nearby orders
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 55
TITLE: Thick Book vs Thin Book
CELEBRATION: Thick Book vs Thin Book complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Thick Book vs Thin Book => Available depth
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Book depth changes how easily price can travel
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Book depth changes how easily price can travel.

[TRENDLINE] Connect the first and last candle.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control. The learner draws directly between two candles to mark the structure.
CHART: volatile
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[MC] Which comparison best separates these two ideas?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
A thick book offers more nearby depth. A thin book can allow faster travel.
A thick book guarantees reversal
A thin book proves aggressive buyers are present
WHY: A thick book offers more nearby depth. A thin book can allow faster travel.

[ORDER] Build the read in order.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 56
TITLE: Liquidity Review
CELEBRATION: Liquidity Review complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Judge liquidity events by location and response
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Judge liquidity events by location and response.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
location and response
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on location and response.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[ORDER] Build the read in order.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 57
TITLE: Flow and Liquidity Mixed Review
CELEBRATION: Flow and Liquidity Mixed Review complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Combine pressure with liquidity and price response
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Combine pressure with liquidity and price response.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Flow and Liquidity Mixed Review => Pressure location and acceptance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
CHART: breakoutRetest
TARGET: 4
WHY: The newest candle confirms the current response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 7 — Breakouts and Failures

NODE 58
TITLE: Breakout Pressure
CELEBRATION: Breakout Pressure complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
A breakout needs offers to be consumed
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A breakout needs offers to be consumed.

[TRENDLINE] Connect the first and last candle.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles. The learner draws directly between two candles to mark the structure.
CHART: breakout
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
offers cleared
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on offers cleared.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
Breakout Pressure => Offers cleared
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 59
TITLE: Breakdown Pressure
CELEBRATION: Breakdown Pressure complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
Breakdown Pressure => Bids cleared
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
A breakdown needs bids to be consumed
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A breakdown needs bids to be consumed.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
bids cleared
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on bids cleared.

[ORDER] Build the read in order.
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 60
TITLE: Acceptance Above
CELEBRATION: Acceptance Above complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Holding above a level shows acceptance
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Holding above a level shows acceptance.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
price holding above
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on price holding above.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
CHART: breakoutRetest
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 61
TITLE: Acceptance Below
CELEBRATION: Acceptance Below complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
Holding below a level shows acceptance
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Holding below a level shows acceptance.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
Acceptance Below => Price holding below
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TRENDLINE] Connect the first and last candle.
VISUAL: Price breaks support, returns to test it from below, then reacts lower. The learner draws directly between two candles to mark the structure.
CHART: breakdownRetest
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 62
TITLE: Failed Breakout
CELEBRATION: Failed Breakout complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
A quick return below resistance signals failure
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A quick return below resistance signals failure.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
return below resistance
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on return below resistance.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Failed Breakout => Return below resistance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 63
TITLE: Failed Breakdown
CELEBRATION: Failed Breakdown complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Failed Breakdown => Return above support
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
A quick return above support signals failure
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A quick return above support signals failure.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area. The candles are tappable and the learner must select the requested candle.
CHART: supportBounce
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
return above support
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on return above support.

[ORDER] Build the read in order.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 64
TITLE: Breakout Retest
CELEBRATION: Breakout Retest complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
A defended retest can confirm a breakout
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A defended retest can confirm a breakout.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
support on retest
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on support on retest.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TRENDLINE] Connect the first and last candle.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The learner draws directly between two candles to mark the structure.
CHART: breakoutRetest
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[ORDER] Build the read in order.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 65
TITLE: Breakdown Retest
CELEBRATION: Breakdown Retest complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
A rejected retest can confirm a breakdown
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A rejected retest can confirm a breakdown.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
Breakdown Retest => Resistance on retest
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 66
TITLE: Chasing Breakouts
CELEBRATION: Chasing Breakouts complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Late entries carry worse risk and reward
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Late entries carry worse risk and reward.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Price opens well above the prior trading area with little activity between the two zones. The candles are tappable and the learner must select the requested candle.
CHART: gapUp
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
entry distance
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on entry distance.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Chasing Breakouts => Entry distance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 67
TITLE: Breakout Review
CELEBRATION: Breakout Review complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Higher lows press into a flat resistance level before price tests the upper boundary.
CHART: ascendingTriangle
Breakout Review => Pressure and acceptance
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Higher lows press into a flat resistance level before price tests the upper boundary.
CHART: ascendingTriangle
Combine pressure, level break, and acceptance
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Combine pressure, level break, and acceptance.

[TRENDLINE] Connect the first and last candle.
VISUAL: Higher lows press into a flat resistance level before price tests the upper boundary. The learner draws directly between two candles to mark the structure.
CHART: ascendingTriangle
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Higher lows press into a flat resistance level before price tests the upper boundary.
CHART: ascendingTriangle
pressure and acceptance
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on pressure and acceptance.

[ORDER] Build the read in order.
VISUAL: Higher lows press into a flat resistance level before price tests the upper boundary.
CHART: ascendingTriangle
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 68
TITLE: Common Order Flow Misconceptions
CELEBRATION: Common Order Flow Misconceptions complete.

[TF] A large visible wall guarantees a reversal.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
ANSWER: False
WHY: Walls can trade pull or fail.

[TF] Fast tape guarantees a breakout.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
ANSWER: False
WHY: Speed needs acceptance and follow through.

[MC] Positive delta appears but price cannot rise. What is the best explanation?
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Buying may be absorbed by passive sellers
Positive delta guarantees delayed upside
The chart invalidates all tape data
WHY: Aggressive buying without progress can reveal seller absorption.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MATCH] Match each clue.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Common Order Flow Misconceptions => Price response
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 8 — Pullbacks and Continuation

NODE 69
TITLE: Healthy Pullbacks
CELEBRATION: Healthy Pullbacks complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: An established rise pauses with smaller bearish candles before testing trend continuation.
CHART: pullbackUptrend
A healthy pullback shows weaker counter pressure
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A healthy pullback shows weaker counter pressure.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: An established rise pauses with smaller bearish candles before testing trend continuation.
CHART: pullbackUptrend
Healthy Pullbacks => Lighter selling
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: An established rise pauses with smaller bearish candles before testing trend continuation. The candles are tappable and the learner must select the requested candle.
CHART: pullbackUptrend
TARGET: 4
WHY: The newest candle confirms the current response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: An established rise pauses with smaller bearish candles before testing trend continuation.
CHART: pullbackUptrend
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 70
TITLE: Pullback Depth
CELEBRATION: Pullback Depth complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
CHART: ascendingChannel
Shallow defended pullbacks show trend strength
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Shallow defended pullbacks show trend strength.

[TRENDLINE] Connect the first and last candle.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary. The learner draws directly between two candles to mark the structure.
CHART: ascendingChannel
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
CHART: ascendingChannel
defended structure
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on defended structure.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
CHART: ascendingChannel
Pullback Depth => Defended structure
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
CHART: ascendingChannel
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 71
TITLE: Seller Pullback
CELEBRATION: Seller Pullback complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Each rebound ends below the previous high while price continues making lower lows.
CHART: lowerHighsDowntrend
Seller Pullback => Lighter buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Each rebound ends below the previous high while price continues making lower lows.
CHART: lowerHighsDowntrend
A bearish pullback shows weaker buying
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A bearish pullback shows weaker buying.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Each rebound ends below the previous high while price continues making lower lows.
CHART: lowerHighsDowntrend
lighter buying
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on lighter buying.

[ORDER] Build the read in order.
VISUAL: Each rebound ends below the previous high while price continues making lower lows.
CHART: lowerHighsDowntrend
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 72
TITLE: Continuation Trigger
CELEBRATION: Continuation Trigger complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Continuation begins when trend pressure returns
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Continuation begins when trend pressure returns.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
buyers return
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on buyers return.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The candles are tappable and the learner must select the requested candle.
CHART: bullFlag
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 73
TITLE: Bearish Continuation
CELEBRATION: Bearish Continuation complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: A sharp decline pauses in a small upward sloping channel before sellers test control again.
CHART: bearFlag
Bearish continuation begins when sellers return
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Bearish continuation begins when sellers return.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: A sharp decline pauses in a small upward sloping channel before sellers test control again.
CHART: bearFlag
Bearish Continuation => Sellers return
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TRENDLINE] Connect the first and last candle.
VISUAL: A sharp decline pauses in a small upward sloping channel before sellers test control again. The learner draws directly between two candles to mark the structure.
CHART: bearFlag
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: A sharp decline pauses in a small upward sloping channel before sellers test control again.
CHART: bearFlag
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 74
TITLE: VWAP Pullback
CELEBRATION: VWAP Pullback complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
VWAP can organize pullback decisions
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: VWAP can organize pullback decisions.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
support near VWAP
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on support near VWAP.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
VWAP Pullback => Support near vwap
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 75
TITLE: Moving Average Pullback
CELEBRATION: Moving Average Pullback complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
CHART: priceAboveMA
Moving Average Pullback => Support near average
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
CHART: priceAboveMA
An average can frame a trend pullback
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: An average can frame a trend pullback.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Candles hold above a rising moving average and react near it during pullbacks. The candles are tappable and the learner must select the requested candle.
CHART: priceAboveMA
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
CHART: priceAboveMA
support near average
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on support near average.

[ORDER] Build the read in order.
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
CHART: priceAboveMA
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 76
TITLE: Pullback Failure
CELEBRATION: Pullback Failure complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
Strong counter pressure can end continuation
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Strong counter pressure can end continuation.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
counter pressure grows
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on counter pressure grows.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TRENDLINE] Connect the first and last candle.
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise. The learner draws directly between two candles to mark the structure.
CHART: bearishEngulfing
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[ORDER] Build the read in order.
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 77
TITLE: Entry After Confirmation
CELEBRATION: Entry After Confirmation complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Wait for pressure to return before entry
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Wait for pressure to return before entry.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Entry After Confirmation => Pressure returns
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 78
TITLE: Continuation Review
CELEBRATION: Continuation Review complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Continuation needs structure and renewed pressure
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Continuation needs structure and renewed pressure.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The candles are tappable and the learner must select the requested candle.
CHART: bullFlag
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
trend pressure returns
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on trend pressure returns.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Continuation Review => Trend pressure returns
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 79
TITLE: Breakout and Continuation Mixed Review
CELEBRATION: Breakout and Continuation Mixed Review complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Breakout and Continuation Mixed Review => Acceptance and renewed pressure
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Continuation needs both structure and returning pressure
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Continuation needs both structure and returning pressure.

[TRENDLINE] Connect the first and last candle.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
CHART: bullFlag
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
acceptance and renewed pressure
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on acceptance and renewed pressure.

[ORDER] Build the read in order.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 9 — Reversals and Traps

NODE 80
TITLE: Reading a Footprint Chart
CELEBRATION: Reading a Footprint Chart complete.

[FOOTPRINT] What is the best reading of this footprint?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
A footprint shows executed volume at each price
The displayed volume guarantees the next candle
Resting size is the only information shown
WHY: A footprint shows executed volume at each price.

[MC] Which combined interpretation best explains this chart?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
A footprint shows executed volume at each price
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A footprint shows executed volume at each price.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MATCH] Match each clue.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Reading a Footprint Chart => Bid and ask volume by price
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[ORDER] Build the read in order.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 81
TITLE: Footprint Imbalances
CELEBRATION: Footprint Imbalances complete.

[FOOTPRINT] What is the best reading of this footprint?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing larger ask volume across several price rows.
EVENT: lift
Footprint imbalance highlights concentrated aggression
The displayed volume guarantees the next candle
Resting size is the only information shown
WHY: Footprint imbalance highlights concentrated aggression.

[MC] Which combined interpretation best explains this chart?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Footprint imbalance highlights concentrated aggression
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Footprint imbalance highlights concentrated aggression.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MATCH] Match each clue.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Footprint Imbalances => Uneven volume at neighboring prices
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control. The candles are tappable and the learner must select the requested candle.
CHART: volatile
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 82
TITLE: Reversal Pressure
CELEBRATION: Reversal Pressure complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Reversals need a clear change in control
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Reversals need a clear change in control.

[TRENDLINE] Connect the first and last candle.
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline. The learner draws directly between two candles to mark the structure.
CHART: bullishEngulfing
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
control changes
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on control changes.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Reversal Pressure => Control changes
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 83
TITLE: Buyer Trap
CELEBRATION: Buyer Trap complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Buyer Trap => Failed buying
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
A buyer trap forms when a breakout fails
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A buyer trap forms when a breakout fails.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller pressure
Buyer pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
failed buying
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on failed buying.

[ORDER] Build the read in order.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 84
TITLE: Seller Trap
CELEBRATION: Seller Trap complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
A seller trap forms when a breakdown fails
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A seller trap forms when a breakdown fails.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
failed selling
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on failed selling.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices. The candles are tappable and the learner must select the requested candle.
CHART: hammer
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 85
TITLE: Exhaustion Reversal
CELEBRATION: Exhaustion Reversal complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
CHART: doji
Exhaustion can prepare a reversal
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Exhaustion can prepare a reversal.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
CHART: doji
Exhaustion Reversal => Slowing pressure
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TRENDLINE] Connect the first and last candle.
VISUAL: A narrow candle body with wicks on both sides shows little net price progress. The learner draws directly between two candles to mark the structure.
CHART: doji
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
CHART: doji
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 86
TITLE: Absorption Reversal
CELEBRATION: Absorption Reversal complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Absorbed selling can support a reversal
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Absorbed selling can support a reversal.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
selling absorbed
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on selling absorbed.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Absorption Reversal => Selling absorbed
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 87
TITLE: Double Top Flow
CELEBRATION: Double Top Flow complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price tests the same resistance area twice and retreats after the second test.
CHART: doubleTop
Double Top Flow => Buyers fail twice
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price tests the same resistance area twice and retreats after the second test.
CHART: doubleTop
Repeated failure can shift control to sellers
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Repeated failure can shift control to sellers.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Price tests the same resistance area twice and retreats after the second test. The candles are tappable and the learner must select the requested candle.
CHART: doubleTop
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price tests the same resistance area twice and retreats after the second test.
CHART: doubleTop
buyers fail twice
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on buyers fail twice.

[ORDER] Build the read in order.
VISUAL: Price tests the same resistance area twice and retreats after the second test.
CHART: doubleTop
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 88
TITLE: Double Bottom Flow
CELEBRATION: Double Bottom Flow complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price tests the same support area twice and rebounds after the second test.
CHART: doubleBottom
Repeated failure can shift control to buyers
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Repeated failure can shift control to buyers.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price tests the same support area twice and rebounds after the second test.
CHART: doubleBottom
sellers fail twice
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on sellers fail twice.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TRENDLINE] Connect the first and last candle.
VISUAL: Price tests the same support area twice and rebounds after the second test. The learner draws directly between two candles to mark the structure.
CHART: doubleBottom
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[ORDER] Build the read in order.
VISUAL: Price tests the same support area twice and rebounds after the second test.
CHART: doubleBottom
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 89
TITLE: Confirmation Before Entry
CELEBRATION: Confirmation Before Entry complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Confirmation reduces premature reversal entries
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Confirmation reduces premature reversal entries.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Confirmation Before Entry => Price confirms pressure
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer pressure
Seller pressure
Balanced pressure
WHY: Read direction and pace together.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 90
TITLE: Reversal Review
CELEBRATION: Reversal Review complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Three troughs form with the middle trough deepest before price challenges the neckline.
CHART: inverseHeadShoulders
A reversal needs control change and confirmation
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A reversal needs control change and confirmation.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Three troughs form with the middle trough deepest before price challenges the neckline. The candles are tappable and the learner must select the requested candle.
CHART: inverseHeadShoulders
TARGET: 4
WHY: The newest candle confirms the current response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Three troughs form with the middle trough deepest before price challenges the neckline.
CHART: inverseHeadShoulders
control and confirmation
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on control and confirmation.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Three troughs form with the middle trough deepest before price challenges the neckline.
CHART: inverseHeadShoulders
Reversal Review => Control and confirmation
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Three troughs form with the middle trough deepest before price challenges the neckline.
CHART: inverseHeadShoulders
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 10 — Execution and Risk

NODE 91
TITLE: Plan the Entry
CELEBRATION: Plan the Entry complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Plan the Entry => Defined trigger
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
A clear trigger keeps execution disciplined
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: A clear trigger keeps execution disciplined.

[TRENDLINE] Connect the first and last candle.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The learner draws directly between two candles to mark the structure.
CHART: breakoutRetest
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
defined trigger
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on defined trigger.

[ORDER] Build the read in order.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 92
TITLE: Choose the Order Type
CELEBRATION: Choose the Order Type complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Order choice balances speed with price control
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Order choice balances speed with price control.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
speed versus price
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on speed versus price.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[ORDER] Build the read in order.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 93
TITLE: Manage Slippage
CELEBRATION: Manage Slippage complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Thin liquidity can increase slippage
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Thin liquidity can increase slippage.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Manage Slippage => Available liquidity
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control. The candles are tappable and the learner must select the requested candle.
CHART: volatile
TARGET: 4
WHY: The newest candle confirms the current response.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 94
TITLE: Place the Stop
CELEBRATION: Place the Stop complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Stops belong where the trade idea fails
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Stops belong where the trade idea fails.

[TRENDLINE] Connect the first and last candle.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area. The learner draws directly between two candles to mark the structure.
CHART: supportBounce
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
invalidation level
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on invalidation level.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Buyer control is strengthening
Seller control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Place the Stop => Invalidation level
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 95
TITLE: Size the Position
CELEBRATION: Size the Position complete.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Size the Position => Risk amount
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[MC] Which combined interpretation best explains this chart?
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Position size should follow planned risk
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Position size should follow planned risk.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
risk amount
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on risk amount.

[ORDER] Build the read in order.
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 96
TITLE: Avoid Overtrading
CELEBRATION: Avoid Overtrading complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which combined interpretation best explains this chart?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
No clear signal means no trade
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: No clear signal means no trade.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[FILL] The observation that completes this interpretation is [___].
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
quality over activity
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on quality over activity.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_sell
ANSWER: the bid
WHY: Market buys take asks. Market sells take bids.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress. The candles are tappable and the learner must select the requested candle.
CHART: spinningTop
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 97
TITLE: Exit Into Liquidity
CELEBRATION: Exit Into Liquidity complete.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Seller control is strengthening
Buyer control is strengthening
Pressure remains balanced
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Liquidity can improve planned exits
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Liquidity can improve planned exits.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Exit Into Liquidity => Available buyers or sellers
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[TRENDLINE] Connect the first and last candle.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The learner draws directly between two candles to mark the structure.
CHART: resistanceRejection
TARGET: 0 => 4
WHY: The line makes the current direction easier to see.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[ORDER] Build the read in order.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 98
TITLE: Review the Trade
CELEBRATION: Review the Trade complete.

[MC] Which combined interpretation best explains this chart?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Review execution separately from outcome
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Review execution separately from outcome.

[LIVE_CHART] Read the live pressure.
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Balanced pressure
Buyer pressure
Seller pressure
WHY: Read direction and pace together.

[FILL] The observation that completes this interpretation is [___].
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
process quality
aggression without price response
acceptance beyond the level
liquidity withdrawing ahead of price
WHY: Focus on process quality.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MATCH] Match each clue.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Review the Trade => Process quality
Buyer pressure => Offers being taken
Seller pressure => Bids being taken
WHY: Match the signal with its order flow clue.

[ORDER] Build the read in order.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 99
TITLE: Comprehensive Order Flow Simulation
CELEBRATION: Comprehensive Order Flow Simulation complete.

[AGGRESSOR] Watch the book. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[BOOKDRAG] Route this market order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[TIME_SALES] How does the tape change the current read?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints highlighted at the ask.
EVENT: lift
Buying is active but still needs price acceptance
The outcome is now guaranteed
Resting bids are the only useful evidence
WHY: Tape confirms activity rather than outcome.

[FOOTPRINT] What does the footprint add?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing larger ask volume across several price rows.
EVENT: lift
Concentrated ask side execution at several prices
Proof that risk is unnecessary
A list of resting stop orders
WHY: The footprint locates executed volume by price.

[LIVE_CHART] Combine pace direction and follow through. What is the best current read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Pressure remains balanced
Buyer control is strengthening
Seller control is strengthening
WHY: The best read combines pace direction and price response.

[MC] Which combined interpretation best explains this chart?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Build one read from book tape footprint price and risk
Aggression is present but acceptance is not confirmed
Liquidity changed but price response remains unresolved
Price moved but the tape does not yet confirm participation
WHY: Build one read from book tape footprint price and risk.

[TAP_CANDLE] Tap the newest confirmation candle.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control. The candles are tappable and the learner must select the requested candle.
CHART: volatile
TARGET: 4
WHY: The newest candle confirms the current response.

[ORDER] Build the read in order.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.
