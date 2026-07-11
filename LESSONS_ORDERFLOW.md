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
  [TIME_SALES_TAP] Select evidence directly from the animated tape.
  [FOOTPRINT] Compare bid and ask volume at each price.
  [FOOTPRINT_TAP] Select an imbalance directly on the footprint.

TOTAL UNITS: 10
TOTAL LESSONS: 111
TOTAL QUESTIONS: 428

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

[MC] Repeated deceptive posting and cancellation intended to mislead may constitute…
Spoofing.
Absorption.
A breakout.
WHY: Repeated deceptive posting and cancellation intended to mislead may constitute spoofing. One cancelled order alone does not prove intent.

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

[AGGRESSOR] During foundations and book mixed review, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which interpretation is best supported in this foundations and book mixed review example?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
A complete read combines who acts where liquidity rests and how price responds
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
WHY: A complete read combines who acts where liquidity rests and how price responds.

[FILL] The missing evidence in this foundations and book mixed review read is [___].
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
aggression liquidity and response
a single large print
displayed depth without execution
candle color without location
WHY: Focus on aggression liquidity and response.

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

[FILL] Directional movement often develops when aggressive and passive pressure create an order [___].
imbalance
average
schedule
WHY: Directional movement can develop when aggressive pressure overwhelms liquidity, opposing liquidity withdraws, or both.

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

[TIME_SALES] What information does each row provide?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Execution time price size and initiating side
Resting bid and ask size before execution
Total candle volume without trade direction
WHY: Each row is a completed trade with time price size and side.

[TIME_SALES] Which side is initiating these trades?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Sellers
Buyers
Neither side can initiate a trade
WHY: Trades at the bid are seller initiated.

[TIME_SALES_TAP] In reading time and sales, tap the most informative print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
EVENT: large_print
TARGET: 3
WHY: The selected execution carries the key tape evidence.

[MATCH] Connect the behaviors that matter for reading time and sales.
Reading Time and Sales => Price size and side
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

NODE 15
TITLE: Reading the Tape
CELEBRATION: Reading the Tape complete.

[TIME_SALES] Which tape behavior best supports the reading the tape read?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Prints reveal completed trades
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Prints reveal completed trades.

[TIME_SALES_TAP] In reading the tape, tap the most informative print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
EVENT: large_print
TARGET: 1
WHY: The selected execution carries the key tape evidence.

[MC] Which statement best connects the evidence in this reading the tape replay?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Prints reveal completed trades
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
WHY: Prints reveal completed trades.

[AGGRESSOR] During reading the tape, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

NODE 16
TITLE: Trade Speed
CELEBRATION: Trade Speed complete.

[TIME_SALES] The prints begin slowly and then arrive faster. What changed?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
EVENT: accelerating
Faster prints can reveal rising activity
Displayed depth changed but no completed trade confirms participation
Candle direction identifies the initiating side of every execution
WHY: Faster prints can reveal rising activity.

[TIME_SALES_TAP] Tap the first print where the tape begins accelerating.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
EVENT: accelerating
TARGET: 6
WHY: This print begins the faster arrival sequence.

[MC] Which conclusion is best supported by the evidence in trade speed?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Faster prints can reveal rising activity
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
WHY: Faster prints can reveal rising activity.

NODE 17
TITLE: Trade Size
CELEBRATION: Trade Size complete.

[TIME_SALES] Which change in the feed shows unusually large participation?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
EVENT: large_print
Larger trades can show stronger participation
The spread narrowed so trade pace no longer matters
One large print establishes persistent control
WHY: Larger trades can show stronger participation.

[TIME_SALES_TAP] Tap the unusually large executed trade.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
EVENT: large_print
TARGET: 4
WHY: This execution is much larger than the surrounding prints.

[MC] Which explanation of trade size requires the fewest assumptions?
VISUAL: A wide directional candle has almost no wick, showing sustained movement through its range.
CHART: marubozu
Larger trades can show stronger participation
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
WHY: Larger trades can show stronger participation.

[AGGRESSOR] During trade size, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

NODE 18
TITLE: Repeated Prints
CELEBRATION: Repeated Prints complete.

[TIME_SALES] Which side shows more persistent aggression across the sequence?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Repeated buys can show persistent demand
Total tape volume reveals where every resting order sits
The final print deserves more weight than the full sequence
WHY: Repeated buys can show persistent demand.

[TIME_SALES_TAP] Tap the print that breaks the dominant side sequence.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one opposing print interrupting a persistent buyer sequence.
EVENT: sequence_break
TARGET: 2
WHY: This print interrupts the persistent aggression shown before it.

[MC] Which interpretation is best supported in this repeated prints example?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
CHART: uptrend
Repeated buys can show persistent demand
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
WHY: Repeated buys can show persistent demand.

NODE 19
TITLE: Buyer Initiated Prints
CELEBRATION: Buyer Initiated Prints complete.

[TIME_SALES] Where are the buyer initiated trades executing?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Trades at the ask suggest buyer aggression
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Trades at the ask suggest buyer aggression.

[TIME_SALES_TAP] Tap a buyer initiated execution at the ask.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the target row showing a buyer initiated execution at the ask.
EVENT: buyer_target
TARGET: 7
WHY: The selected trade executes at the ask and is buyer initiated.

[MC] Which conclusion is most reasonable for the current buyer initiated prints evidence?
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
Trades at the ask suggest buyer aggression
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
WHY: Trades at the ask suggest buyer aggression.

[AGGRESSOR] During buyer initiated prints, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

NODE 20
TITLE: Seller Initiated Prints
CELEBRATION: Seller Initiated Prints complete.

[TIME_SALES] Where are the seller initiated trades executing?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Trades at the bid suggest seller aggression
Displayed depth changed but no completed trade confirms participation
Candle direction identifies the initiating side of every execution
WHY: Trades at the bid suggest seller aggression.

[TIME_SALES_TAP] Tap a seller initiated execution at the bid.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the target row showing a seller initiated execution at the bid.
EVENT: seller_target
TARGET: 5
WHY: The selected trade executes at the bid and is seller initiated.

[MC] Which conclusion about seller initiated prints is best supported?
VISUAL: Candles trade below the VWAP line while rebounds test it as potential resistance.
CHART: priceBelowVWAP
Trades at the bid suggest seller aggression
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
WHY: Trades at the bid suggest seller aggression.

NODE 21
TITLE: Pace Changes
CELEBRATION: Pace Changes complete.

[TIME_SALES] What changed first before activity expanded?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
EVENT: accelerating
A faster pace can precede expansion
The spread narrowed so trade pace no longer matters
One large print establishes persistent control
WHY: A faster pace can precede expansion.

[TIME_SALES_TAP] Tap where the tape first changes to a faster pace.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
EVENT: accelerating
TARGET: 3
WHY: The interval between prints begins shrinking here.

[MC] Which statement best connects the evidence in this pace changes replay?
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
A faster pace can precede expansion
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
WHY: A faster pace can precede expansion.

[AGGRESSOR] During pace changes, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

NODE 22
TITLE: Tape at Key Levels
CELEBRATION: Tape at Key Levels complete.

[TIME_SALES] Which tape behavior best supports the tape at key levels read?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Tape reaction matters most near key levels
Total tape volume reveals where every resting order sits
The final print deserves more weight than the full sequence
WHY: Tape reaction matters most near key levels.

[TIME_SALES_TAP] Tap the execution that first contradicts the dominant pressure.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one opposing print interrupting a persistent buyer sequence.
EVENT: sequence_break
TARGET: 1
WHY: The selected print is the first opposing execution at the level.

[MC] Which conclusion is best supported by the evidence in tape at key levels?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Tape reaction matters most near key levels
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
WHY: Tape reaction matters most near key levels.

NODE 23
TITLE: False Urgency
CELEBRATION: False Urgency complete.

[TIME_SALES] Fast prints lose pace without price progress. What weakened?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
Fast prints need price confirmation
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Fast prints need price confirmation.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
TARGET: 6
WHY: Prints continue but size and pace begin fading here.

[MC] Which explanation of false urgency requires the fewest assumptions?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Fast prints need price confirmation
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
WHY: Fast prints need price confirmation.

[AGGRESSOR] During false urgency, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

NODE 24
TITLE: Tape Reading Review
CELEBRATION: Tape Reading Review complete.

[TIME_SALES] Which tape behavior best supports the tape reading review read?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Read pace, size, direction, and response together
Displayed depth changed but no completed trade confirms participation
Candle direction identifies the initiating side of every execution
WHY: Read pace, size, direction, and response together.

[TIME_SALES_TAP] Tap the seller initiated print that changes the developing read.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the target row showing a seller initiated execution at the bid.
EVENT: seller_target
TARGET: 4
WHY: This bid side execution is the relevant opposing print.

[MC] Which interpretation is best supported in this tape reading review example?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Read pace, size, direction, and response together
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
WHY: Read pace, size, direction, and response together.


UNIT 4 — Absorption and Exhaustion

NODE 25
TITLE: What Is Absorption
CELEBRATION: What Is Absorption complete.

[ORDERFLOW_SIM] Which combined evidence best demonstrates what is absorption?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
Absorption appears when pressure fails to move price
The candle pattern alone establishes the order flow cause
Aggression without book response confirms continuation
Displayed size reveals all hidden liquidity
WHY: Absorption appears when pressure fails to move price.

[TIME_SALES] How does aggressive execution compare with the resulting price progress?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Execution is strong while price progress remains limited
Execution and price are accelerating equally
No aggressive executions are present
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] Which conclusion is most reasonable for the current what is absorption evidence?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Absorption appears when pressure fails to move price
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Absorption appears when pressure fails to move price.

NODE 26
TITLE: Buyer Absorption
CELEBRATION: Buyer Absorption complete.

[ORDERFLOW_SIM] Which combined evidence best demonstrates buyer absorption?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
Buyers absorb selling near support
The candle pattern alone establishes the order flow cause
Aggression without book response confirms continuation
Displayed size reveals all hidden liquidity
WHY: Buyers absorb selling near support.

[TIME_SALES] How does aggressive execution compare with the resulting price progress?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Execution is strong while price progress remains limited
Execution and price are accelerating equally
No aggressive executions are present
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] Which conclusion about buyer absorption is best supported?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Buyers absorb selling near support
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Buyers absorb selling near support.

NODE 27
TITLE: Seller Absorption
CELEBRATION: Seller Absorption complete.

[ORDERFLOW_SIM] Which combined evidence best demonstrates seller absorption?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
Sellers absorb buying near resistance
The candle pattern alone establishes the order flow cause
Aggression without book response confirms continuation
Displayed size reveals all hidden liquidity
WHY: Sellers absorb buying near resistance.

[TIME_SALES] How does aggressive execution compare with the resulting price progress?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Execution is strong while price progress remains limited
Execution and price are accelerating equally
No aggressive executions are present
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] Which statement best connects the evidence in this seller absorption replay?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Sellers absorb buying near resistance
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Sellers absorb buying near resistance.

NODE 28
TITLE: Repeated Tests
CELEBRATION: Repeated Tests complete.

[ORDERFLOW_SIM] Which combined evidence best demonstrates repeated tests?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
A level that survives tests may contain absorption
The candle pattern alone establishes the order flow cause
Aggression without book response confirms continuation
Displayed size reveals all hidden liquidity
WHY: A level that survives tests may contain absorption.

[TIME_SALES] How does aggressive execution compare with the resulting price progress?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Execution is strong while price progress remains limited
Execution and price are accelerating equally
No aggressive executions are present
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] Which conclusion is best supported by the evidence in repeated tests?
VISUAL: Price tests the same support area twice and rebounds after the second test.
CHART: doubleBottom
A level that survives tests may contain absorption
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: A level that survives tests may contain absorption.

NODE 29
TITLE: Hidden Liquidity
CELEBRATION: Hidden Liquidity complete.

[ORDERFLOW_SIM] Which combined evidence best demonstrates hidden liquidity?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
Refreshing liquidity can hide true available size
The candle pattern alone establishes the order flow cause
Aggression without book response confirms continuation
Displayed size reveals all hidden liquidity
WHY: Refreshing liquidity can hide true available size.

[TIME_SALES] How does aggressive execution compare with the resulting price progress?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Execution is strong while price progress remains limited
Execution and price are accelerating equally
No aggressive executions are present
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] Which explanation of hidden liquidity requires the fewest assumptions?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Refreshing liquidity can hide true available size
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Refreshing liquidity can hide true available size.

NODE 30
TITLE: What Is Exhaustion
CELEBRATION: What Is Exhaustion complete.

[TIME_SALES] What changes in the tape during what is exhaustion?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
Aggressive pace and size begin fading
Resting depth proves the next reversal
Executions accelerate while price accepts new levels
WHY: Exhaustion is defined by aggressive activity fading.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
TARGET: 6
WHY: Prints continue but size and pace begin fading here.

[FOOTPRINT] Which footprint change would support exhaustion?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
Directional execution becomes less dominant near the extreme
One large row guarantees reversal
Displayed orders replace executed volume
WHY: Fading directional execution can support an exhaustion read.

NODE 31
TITLE: Buyer Exhaustion
CELEBRATION: Buyer Exhaustion complete.

[TIME_SALES] What changes in the tape during buyer exhaustion?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
Aggressive pace and size begin fading
Resting depth proves the next reversal
Executions accelerate while price accepts new levels
WHY: Exhaustion is defined by aggressive activity fading.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
TARGET: 4
WHY: Prints continue but size and pace begin fading here.

[FOOTPRINT] Which footprint change would support exhaustion?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
Directional execution becomes less dominant near the extreme
One large row guarantees reversal
Displayed orders replace executed volume
WHY: Fading directional execution can support an exhaustion read.

NODE 32
TITLE: Seller Exhaustion
CELEBRATION: Seller Exhaustion complete.

[TIME_SALES] What changes in the tape during seller exhaustion?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
Aggressive pace and size begin fading
Resting depth proves the next reversal
Executions accelerate while price accepts new levels
WHY: Exhaustion is defined by aggressive activity fading.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
TARGET: 2
WHY: Prints continue but size and pace begin fading here.

[FOOTPRINT] Which footprint change would support exhaustion?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
Directional execution becomes less dominant near the extreme
One large row guarantees reversal
Displayed orders replace executed volume
WHY: Fading directional execution can support an exhaustion read.

NODE 33
TITLE: Absorption or Exhaustion
CELEBRATION: Absorption or Exhaustion complete.

[TIME_SALES] What changes in the tape during absorption or exhaustion?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
Aggressive pace and size begin fading
Resting depth proves the next reversal
Executions accelerate while price accepts new levels
WHY: Exhaustion is defined by aggressive activity fading.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
TARGET: 7
WHY: Prints continue but size and pace begin fading here.

[FOOTPRINT] Which footprint change would support exhaustion?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
Directional execution becomes less dominant near the extreme
One large row guarantees reversal
Displayed orders replace executed volume
WHY: Fading directional execution can support an exhaustion read.

NODE 34
TITLE: Seller Absorption Simulation
CELEBRATION: Seller Absorption Simulation complete.

[ORDERFLOW_SIM] Buying is aggressive but price cannot clear resistance. What is strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
Buyers are active but may be absorbed by refreshing sellers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Aggressive buyers can be absorbed by passive sellers at resistance.

[MC] Which conclusion is best supported by the evidence in seller absorption simulation?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Aggressive buyers can be absorbed by passive sellers at resistance
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Aggressive buyers can be absorbed by passive sellers at resistance.

[ORDER] Build the seller absorption simulation read from evidence to conclusion.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 35
TITLE: Buyer Absorption Simulation
CELEBRATION: Buyer Absorption Simulation complete.

[ORDERFLOW_SIM] Selling is aggressive but price cannot break support. What is strongest?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
Sellers are active but may be absorbed by refreshing buyers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Aggressive sellers can be absorbed by passive buyers at support.

[MC] Which explanation of buyer absorption simulation requires the fewest assumptions?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Aggressive sellers can be absorbed by passive buyers at support
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Aggressive sellers can be absorbed by passive buyers at support.

[ORDER] Build the buyer absorption simulation read from evidence to conclusion.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 36
TITLE: Absorption Review
CELEBRATION: Absorption Review complete.

[ORDERFLOW_SIM] Which combined evidence best demonstrates absorption review?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
Strong pressure with little movement suggests absorption
The candle pattern alone establishes the order flow cause
Aggression without book response confirms continuation
Displayed size reveals all hidden liquidity
WHY: Strong pressure with little movement suggests absorption.

[TIME_SALES] How does aggressive execution compare with the resulting price progress?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Execution is strong while price progress remains limited
Execution and price are accelerating equally
No aggressive executions are present
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] Which interpretation is best supported in this absorption review example?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Strong pressure with little movement suggests absorption
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Strong pressure with little movement suggests absorption.

NODE 37
TITLE: Tape and Absorption Mixed Review
CELEBRATION: Tape and Absorption Mixed Review complete.

[MC] Which conclusion is most reasonable for the current tape and absorption mixed review evidence?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Separate active pressure from the market response
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
WHY: Separate active pressure from the market response.

[BOOKDRAG] Route the order used in this tape and absorption mixed review example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for tape and absorption mixed review.
Tape and Absorption Mixed Review => Aggression and price response
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] In tape and absorption mixed review, tap where price response becomes clearest.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick. The candles are tappable and the learner must select the requested candle.
CHART: rejectionWickDown
TARGET: 2
WHY: The selected candle shows whether execution produced follow through.


UNIT 5 — Imbalances and Momentum

NODE 38
TITLE: Reading a Footprint Chart
CELEBRATION: Reading a Footprint Chart complete.

[FOOTPRINT] What does the bid and ask split inside each row represent?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
Executed selling at the bid and buying at the ask
Resting limit orders waiting at each price
Total candle volume without side separation
WHY: A footprint separates executed bid volume from executed ask volume at each price.

[FOOTPRINT_TAP] Tap the row where bid and ask execution is most balanced.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
EVENT: balanced_target
TARGET: 3
WHY: This row has the smallest difference between bid and ask volume.

[MC] Which conclusion about reading a footprint chart is best supported?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
A footprint shows executed volume at each price
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: A footprint shows executed volume at each price.

[MATCH] Connect the behaviors that matter for reading a footprint chart.
Reading a Footprint Chart => Bid and ask volume by price
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

NODE 39
TITLE: Footprint Imbalances
CELEBRATION: Footprint Imbalances complete.

[FOOTPRINT] How is a conventional ask side footprint imbalance usually evaluated?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Compare ask volume with bid volume diagonally at the adjacent lower price using a ratio threshold
Choose the largest same row absolute difference only
Compare displayed ask depth with completed bid volume
WHY: Diagonal comparison and a defined ratio distinguish conventional imbalance from a simple same price execution difference.

[FOOTPRINT_TAP] Tap the row with the largest total executed volume.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
EVENT: total_target
TARGET: 6
WHY: This row has the highest combined bid and ask execution.

[MC] Which statement best connects the evidence in this footprint imbalances replay?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
A conventional footprint imbalance compares diagonally adjacent bid and ask volume using a ratio threshold
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: A conventional footprint imbalance compares diagonally adjacent bid and ask volume using a ratio threshold.

[MATCH] Connect the behaviors that matter for footprint imbalances.
Footprint Imbalances => Diagonal volume ratios at neighboring prices
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

NODE 40
TITLE: Order Imbalance
CELEBRATION: Order Imbalance complete.

[FOOTPRINT] Which footprint evidence best supports order imbalance?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Imbalance means one side is more aggressive
The largest total row proves directional delta
The bid ask split represents resting limit orders
One same price difference confirms a stacked diagonal imbalance
WHY: Imbalance means one side is more aggressive.

[FOOTPRINT_TAP] Tap the row with the greatest ask side execution advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
TARGET: 2
WHY: This row has the largest positive same price execution difference.

[MC] Which conclusion is best supported by the evidence in order imbalance?
Imbalance means one side is more aggressive
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Imbalance means one side is more aggressive.

NODE 41
TITLE: Buyer Imbalance
CELEBRATION: Buyer Imbalance complete.

[FOOTPRINT] Which footprint evidence best supports buyer imbalance?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Buyer imbalance can push price higher
Positive candle delta guarantees price acceptance
A quiet row invalidates aggression elsewhere
Absolute volume matters more than price response
WHY: Buyer imbalance can push price higher.

[FOOTPRINT_TAP] Tap the row with the greatest bid side execution advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
TARGET: 5
WHY: This row has the largest negative same price execution difference.

[MC] Which explanation of buyer imbalance requires the fewest assumptions?
Buyer imbalance can push price higher
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Buyer imbalance can push price higher.

[ORDER] Build the buyer imbalance read from evidence to conclusion.
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 42
TITLE: Seller Imbalance
CELEBRATION: Seller Imbalance complete.

[FOOTPRINT] Which footprint evidence best supports seller imbalance?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
Seller imbalance can push price lower
The brightest cell identifies the next candle direction
A same row advantage and diagonal imbalance are identical
Displayed depth can be inferred directly from executed volume
WHY: Seller imbalance can push price lower.

[FOOTPRINT_TAP] Tap the row where bid and ask execution is most balanced.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
EVENT: balanced_target
TARGET: 1
WHY: This row has the smallest difference between bid and ask volume.

[MC] Which interpretation is best supported in this seller imbalance example?
Seller imbalance can push price lower
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Seller imbalance can push price lower.

NODE 43
TITLE: Momentum Ignition
CELEBRATION: Momentum Ignition complete.

[FOOTPRINT] Which footprint evidence best supports momentum ignition?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Sudden aggression can ignite momentum
Several ask heavy rows prove sellers withdrew
High total volume must contain directional delta
One footprint candle is enough to ignore location
WHY: Sudden aggression can ignite momentum.

[FOOTPRINT_TAP] Tap the row with the largest total executed volume.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
EVENT: total_target
TARGET: 4
WHY: This row has the highest combined bid and ask execution.

[MC] Which conclusion is most reasonable for the current momentum ignition evidence?
Sudden aggression can ignite momentum
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: Sudden aggression can ignite momentum.

[ORDER] Build the momentum ignition read from evidence to conclusion.
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 44
TITLE: Momentum Continuation
CELEBRATION: Momentum Continuation complete.

[FOOTPRINT] Which footprint evidence best supports momentum continuation?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Renewed buying can continue momentum
The largest total row proves directional delta
The bid ask split represents resting limit orders
One same price difference confirms a stacked diagonal imbalance
WHY: Renewed buying can continue momentum.

[FOOTPRINT_TAP] Tap the row with the greatest ask side execution advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
TARGET: 0
WHY: This row has the largest positive same price execution difference.

[MC] Which conclusion about momentum continuation is best supported?
Renewed buying can continue momentum
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Renewed buying can continue momentum.

NODE 45
TITLE: Momentum Failure
CELEBRATION: Momentum Failure complete.

[FOOTPRINT] Which footprint evidence best supports momentum failure?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
Momentum weakens when price stops responding
Positive candle delta guarantees price acceptance
A quiet row invalidates aggression elsewhere
Absolute volume matters more than price response
WHY: Momentum weakens when price stops responding.

[FOOTPRINT_TAP] Tap the row with the greatest bid side execution advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
TARGET: 3
WHY: This row has the largest negative same price execution difference.

[MC] Which statement best connects the evidence in this momentum failure replay?
Momentum weakens when price stops responding
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Momentum weakens when price stops responding.

[ORDER] Build the momentum failure read from evidence to conclusion.
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 46
TITLE: Stacked Pressure
CELEBRATION: Stacked Pressure complete.

[FOOTPRINT] Which footprint evidence best supports stacked pressure?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Pressure across several levels strengthens the move
The brightest cell identifies the next candle direction
A same row advantage and diagonal imbalance are identical
Displayed depth can be inferred directly from executed volume
WHY: Pressure across several levels strengthens the move.

[FOOTPRINT_TAP] Tap the row where bid and ask execution is most balanced.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
EVENT: balanced_target
TARGET: 6
WHY: This row has the smallest difference between bid and ask volume.

[MC] Which conclusion is best supported by the evidence in stacked pressure?
Pressure across several levels strengthens the move
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Pressure across several levels strengthens the move.

NODE 47
TITLE: Delta Thinking
CELEBRATION: Delta Thinking complete.

[FOOTPRINT] Which footprint evidence best supports delta thinking?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Net aggression compares buying with selling
Several ask heavy rows prove sellers withdrew
High total volume must contain directional delta
One footprint candle is enough to ignore location
WHY: Net aggression compares buying with selling.

[FOOTPRINT_TAP] Tap the row with the largest total executed volume.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
EVENT: total_target
TARGET: 2
WHY: This row has the highest combined bid and ask execution.

[MC] Which explanation of delta thinking requires the fewest assumptions?
Net aggression compares buying with selling
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Net aggression compares buying with selling.

[ORDER] Build the delta thinking read from evidence to conclusion.
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 48
TITLE: Delta vs Volume
CELEBRATION: Delta vs Volume complete.

[FOOTPRINT] Price and executed volume disagree. Which explanation best fits?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Volume measures total trading while delta compares aggressive buying and selling
Delta alone determines the next price
Total volume and delta measure the same thing
The disagreement makes both readings useless
WHY: Volume measures total trading while delta compares aggressive buying and selling.

[MC] Which interpretation is best supported in this delta vs volume example?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Volume measures total trading while delta compares aggressive buying and selling
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Volume measures total trading while delta compares aggressive buying and selling.

[FOOTPRINT_TAP] Tap the row with the greatest ask side execution advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
TARGET: 5
WHY: This row has the largest positive same price execution difference.

[ORDER] Build the delta vs volume read from evidence to conclusion.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 49
TITLE: Positive Delta While Price Falls
CELEBRATION: Positive Delta While Price Falls complete.

[FOOTPRINT] Price and executed volume disagree. Which explanation best fits?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Positive delta with falling price can reveal seller absorption or trapped buyers
Delta alone determines the next price
Total volume and delta measure the same thing
The disagreement makes both readings useless
WHY: Positive delta with falling price can reveal seller absorption or trapped buyers.

[MC] Which conclusion is most reasonable for the current positive delta while price falls evidence?
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
Positive delta with falling price can reveal seller absorption or trapped buyers
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Positive delta with falling price can reveal seller absorption or trapped buyers.

[FOOTPRINT_TAP] Tap the row with the greatest bid side execution advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
TARGET: 1
WHY: This row has the largest negative same price execution difference.

[ORDER] Build the positive delta while price falls read from evidence to conclusion.
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 50
TITLE: Negative Delta While Price Rises
CELEBRATION: Negative Delta While Price Rises complete.

[FOOTPRINT] Price and executed volume disagree. Which explanation best fits?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
Negative delta with rising price can reveal buyer absorption or trapped sellers
Delta alone determines the next price
Total volume and delta measure the same thing
The disagreement makes both readings useless
WHY: Negative delta with rising price can reveal buyer absorption or trapped sellers.

[MC] Which conclusion about negative delta while price rises is best supported?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Negative delta with rising price can reveal buyer absorption or trapped sellers
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Negative delta with rising price can reveal buyer absorption or trapped sellers.

[FOOTPRINT_TAP] Tap the row where bid and ask execution is most balanced.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
EVENT: balanced_target
TARGET: 4
WHY: This row has the smallest difference between bid and ask volume.

[ORDER] Build the negative delta while price rises read from evidence to conclusion.
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 51
TITLE: Price and Pressure Divergence
CELEBRATION: Price and Pressure Divergence complete.

[FOOTPRINT] Which footprint evidence best supports price and pressure divergence?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
Price and pressure disagreement warns of weakness
Several ask heavy rows prove sellers withdrew
High total volume must contain directional delta
One footprint candle is enough to ignore location
WHY: Price and pressure disagreement warns of weakness.

[FOOTPRINT_TAP] Tap the row with the largest total executed volume.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
EVENT: total_target
TARGET: 0
WHY: This row has the highest combined bid and ask execution.

[MC] Which statement best connects the evidence in this price and pressure divergence replay?
Price and pressure disagreement warns of weakness
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Price and pressure disagreement warns of weakness.

[ORDER] Build the price and pressure divergence read from evidence to conclusion.
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 52
TITLE: Imbalance Review
CELEBRATION: Imbalance Review complete.

[FOOTPRINT] Which footprint evidence best supports imbalance review?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
Sustained imbalance matters more than one burst
The largest total row proves directional delta
The bid ask split represents resting limit orders
One same price difference confirms a stacked diagonal imbalance
WHY: Sustained imbalance matters more than one burst.

[FOOTPRINT_TAP] Tap the row with the greatest ask side execution advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
TARGET: 3
WHY: This row has the largest positive same price execution difference.

[MC] Which conclusion is best supported by the evidence in imbalance review?
Sustained imbalance matters more than one burst
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Sustained imbalance matters more than one burst.


UNIT 6 — Liquidity and Sweeps

NODE 53
TITLE: Liquidity Pools
CELEBRATION: Liquidity Pools complete.

[FILL] The missing evidence in this liquidity pools read is [___].
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
clustered orders
positive delta without progress
a wick without tape evidence
depth far from the active price
WHY: Focus on clustered orders.

[MC] Which explanation of liquidity pools requires the fewest assumptions?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Liquidity often gathers near obvious levels
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Liquidity often gathers near obvious levels.

[MATCH] Connect the behaviors that matter for liquidity pools.
Liquidity Pools => Clustered orders
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

NODE 54
TITLE: Resting Stops
CELEBRATION: Resting Stops complete.

[AGGRESSOR] During resting stops, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which interpretation is best supported in this resting stops example?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Traders often infer that stops may cluster beyond obvious support resistance highs and lows
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Traders often infer that stops may cluster beyond obvious support resistance highs and lows.

[FILL] The missing evidence in this resting stops read is [___].
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
inferred stop clusters beyond obvious levels
a single large print
displayed depth without execution
candle color without location
WHY: Focus on inferred stop clusters beyond obvious levels.

NODE 55
TITLE: Buy Stops
CELEBRATION: Buy Stops complete.

[MC] Which conclusion is most reasonable for the current buy stops evidence?
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
Buy stops can fuel an upside break
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: Buy stops can fuel an upside break.

[BOOKDRAG] Route the order used in this buy stops example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for buy stops.
Buy Stops => Stops above resistance
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] In buy stops, tap where price response becomes clearest.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles. The candles are tappable and the learner must select the requested candle.
CHART: breakout
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

NODE 56
TITLE: Sell Stops
CELEBRATION: Sell Stops complete.

[MC] Which conclusion about sell stops is best supported?
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
Sell stops can fuel a downside break
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Sell stops can fuel a downside break.

[TAP_CANDLE] In sell stops, tap where price response becomes clearest.
VISUAL: Price drives below a visible support level with expanding bearish candles. The candles are tappable and the learner must select the requested candle.
CHART: breakdown
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[FILL] The missing evidence in this sell stops read is [___].
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
stops below support
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on stops below support.

NODE 57
TITLE: Liquidity Sweep
CELEBRATION: Liquidity Sweep complete.

[BOOKDRAG] Route the order used in this liquidity sweep example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for liquidity sweep.
Liquidity Sweep => Quick level breach
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] Which statement best connects the evidence in this liquidity sweep replay?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
A sweep takes liquidity then returns
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: A sweep takes liquidity then returns.

NODE 58
TITLE: Upside Sweep
CELEBRATION: Upside Sweep complete.

[TAP_CANDLE] In upside sweep, tap where price response becomes clearest.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick. The candles are tappable and the learner must select the requested candle.
CHART: rejectionWickUp
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

[AGGRESSOR] During upside sweep, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which conclusion is best supported by the evidence in upside sweep?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
CHART: rejectionWickUp
An upside sweep can trap late buyers
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: An upside sweep can trap late buyers.

[ORDER] Build the upside sweep read from evidence to conclusion.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 59
TITLE: Downside Sweep
CELEBRATION: Downside Sweep complete.

[FILL] The missing evidence in this downside sweep read is [___].
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
failed push below
positive delta without progress
a wick without tape evidence
depth far from the active price
WHY: Focus on failed push below.

[MC] Which explanation of downside sweep requires the fewest assumptions?
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
A downside sweep can trap late sellers
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: A downside sweep can trap late sellers.

[MATCH] Connect the behaviors that matter for downside sweep.
Downside Sweep => Failed push below
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

NODE 60
TITLE: Sweep or Breakout
CELEBRATION: Sweep or Breakout complete.

[AGGRESSOR] During sweep or breakout, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which interpretation is best supported in this sweep or breakout example?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Acceptance beyond a level supports a breakout
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Acceptance beyond a level supports a breakout.

[MC] Which comparison best separates these two ideas?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
A sweep returns through the level. A breakout gains acceptance beyond it.
A sweep always has slower tape than a breakout
Any trade beyond the level confirms a breakout
WHY: A sweep returns through the level. A breakout gains acceptance beyond it.

NODE 61
TITLE: Liquidity Sweep Rejection Simulation
CELEBRATION: Liquidity Sweep Rejection Simulation complete.

[ORDERFLOW_SIM] Price trades beyond the level and immediately returns. What is strongest?
VISUAL: Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.
Liquidity was taken but acceptance failed
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: A sweep takes liquidity but fails to gain acceptance.

[MC] Which conclusion is most reasonable for the current liquidity sweep rejection simulation evidence?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
CHART: rejectionWickUp
A sweep takes liquidity but fails to gain acceptance
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: A sweep takes liquidity but fails to gain acceptance.

[ORDER] Build the liquidity sweep rejection simulation read from evidence to conclusion.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 62
TITLE: Thin Liquidity
CELEBRATION: Thin Liquidity complete.

[MC] Which conclusion about thin liquidity is best supported?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Thin liquidity lets price travel quickly
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Thin liquidity lets price travel quickly.

[TAP_CANDLE] In thin liquidity, tap where price response becomes clearest.
VISUAL: Price opens well above the prior trading area with little activity between the two zones. The candles are tappable and the learner must select the requested candle.
CHART: gapUp
TARGET: 2
WHY: The selected candle shows whether execution produced follow through.

[FILL] The missing evidence in this thin liquidity read is [___].
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
few nearby orders
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on few nearby orders.

NODE 63
TITLE: Thick Book vs Thin Book
CELEBRATION: Thick Book vs Thin Book complete.

[BOOKDRAG] Route the order used in this thick book vs thin book example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for thick book vs thin book.
Thick Book vs Thin Book => Available depth
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[MC] Which statement best connects the evidence in this thick book vs thin book replay?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Book depth changes how easily price can travel
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Book depth changes how easily price can travel.

NODE 64
TITLE: Iceberg Orders
CELEBRATION: Iceberg Orders complete.

[TIME_SALES] Large buy prints keep trading at one price but the offer refreshes. What best explains it?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
A possible sell iceberg is replenishing hidden size
Buyers have already secured a breakout
The tape is showing canceled orders
Displayed size cannot change after a fill
WHY: Repeated execution against refreshing displayed size is consistent with an iceberg.

[AGGRESSOR] During iceberg orders, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which conclusion is best supported by the evidence in iceberg orders?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
An iceberg can replenish displayed size while absorbing repeated trades
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: An iceberg can replenish displayed size while absorbing repeated trades.

[TIME_SALES_TAP] In iceberg orders, tap the most informative print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
EVENT: large_print
TARGET: 1
WHY: The selected execution carries the key tape evidence.

NODE 65
TITLE: Liquidity Review
CELEBRATION: Liquidity Review complete.

[FILL] The missing evidence in this liquidity review read is [___].
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
location and response
positive delta without progress
a wick without tape evidence
depth far from the active price
WHY: Focus on location and response.

[MC] Which explanation of liquidity review requires the fewest assumptions?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Judge liquidity events by location and response
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Judge liquidity events by location and response.

[MATCH] Connect the behaviors that matter for liquidity review.
Liquidity Review => Location and response
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

NODE 66
TITLE: Flow and Liquidity Mixed Review
CELEBRATION: Flow and Liquidity Mixed Review complete.

[AGGRESSOR] During flow and liquidity mixed review, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which interpretation is best supported in this flow and liquidity mixed review example?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Combine pressure with liquidity and price response
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Combine pressure with liquidity and price response.

[FILL] The missing evidence in this flow and liquidity mixed review read is [___].
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
pressure location and acceptance
a single large print
displayed depth without execution
candle color without location
WHY: Focus on pressure location and acceptance.


UNIT 7 — Breakouts and Failures

NODE 67
TITLE: Breakout Pressure
CELEBRATION: Breakout Pressure complete.

[MC] Which conclusion is most reasonable for the current breakout pressure evidence?
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
CHART: breakout
An upside breakout can develop as buyers consume offers sellers withdraw liquidity or both
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: An upside breakout can develop as buyers consume offers sellers withdraw liquidity or both.

[BOOKDRAG] Route the order used in this breakout pressure example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for breakout pressure.
Breakout Pressure => Offers consumed withdrawn or thin
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] In breakout pressure, tap where price response becomes clearest.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles. The candles are tappable and the learner must select the requested candle.
CHART: breakout
TARGET: 2
WHY: The selected candle shows whether execution produced follow through.

NODE 68
TITLE: Breakdown Pressure
CELEBRATION: Breakdown Pressure complete.

[MC] Which conclusion about breakdown pressure is best supported?
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
A downside break can develop as sellers consume bids buyers withdraw liquidity or both
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: A downside break can develop as sellers consume bids buyers withdraw liquidity or both.

[TAP_CANDLE] In breakdown pressure, tap where price response becomes clearest.
VISUAL: Price drives below a visible support level with expanding bearish candles. The candles are tappable and the learner must select the requested candle.
CHART: breakdown
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

[FILL] The missing evidence in this breakdown pressure read is [___].
VISUAL: Price drives below a visible support level with expanding bearish candles.
CHART: breakdown
bids consumed withdrawn or thin
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on bids consumed withdrawn or thin.

NODE 69
TITLE: Acceptance Above
CELEBRATION: Acceptance Above complete.

[BOOKDRAG] Route the order used in this acceptance above example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Which price behavior now supports the acceptance above read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Connect the behaviors that matter for acceptance above.
Acceptance Above => Price holding above
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] Which statement best connects the evidence in this acceptance above replay?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Holding above a level shows acceptance
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Holding above a level shows acceptance.

NODE 70
TITLE: Acceptance Below
CELEBRATION: Acceptance Below complete.

[TAP_CANDLE] In acceptance below, tap where price response becomes clearest.
VISUAL: Price breaks support, returns to test it from below, then reacts lower. The candles are tappable and the learner must select the requested candle.
CHART: breakdownRetest
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

[AGGRESSOR] During acceptance below, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which conclusion is best supported by the evidence in acceptance below?
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
Holding below a level shows acceptance
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Holding below a level shows acceptance.

[ORDER] Build the acceptance below read from evidence to conclusion.
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 71
TITLE: Breakout Acceptance Simulation
CELEBRATION: Breakout Acceptance Simulation complete.

[ORDERFLOW_SIM] Offers are consumed and price holds beyond resistance. What is strongest?
VISUAL: Price approaches resistance, offers thin and are consumed, buyer initiated prints persist, stacked ask side execution appears, and price holds above the broken level.
Aggression is receiving confirming price acceptance
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: A real breakout combines pressure with sustained trade beyond the level.

[MC] Which explanation of breakout acceptance simulation requires the fewest assumptions?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
A real breakout combines pressure with sustained trade beyond the level
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: A real breakout combines pressure with sustained trade beyond the level.

[ORDER] Build the breakout acceptance simulation read from evidence to conclusion.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 72
TITLE: Failed Breakout
CELEBRATION: Failed Breakout complete.

[AGGRESSOR] During failed breakout, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] As the failed breakout replay develops, what changed in price response?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MC] Which interpretation is best supported in this failed breakout example?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
A quick return below resistance signals failure
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: A quick return below resistance signals failure.

[FILL] The missing evidence in this failed breakout read is [___].
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
return below resistance
a single large print
displayed depth without execution
candle color without location
WHY: Focus on return below resistance.

NODE 73
TITLE: Failed Breakdown
CELEBRATION: Failed Breakdown complete.

[MC] Which conclusion is most reasonable for the current failed breakdown evidence?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
A quick return above support signals failure
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: A quick return above support signals failure.

[BOOKDRAG] Route the order used in this failed breakdown example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for failed breakdown.
Failed Breakdown => Return above support
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] In failed breakdown, tap where price response becomes clearest.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area. The candles are tappable and the learner must select the requested candle.
CHART: supportBounce
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

NODE 74
TITLE: Breakout Retest
CELEBRATION: Breakout Retest complete.

[MC] Which conclusion about breakout retest is best supported?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
A defended retest can confirm a breakout
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: A defended retest can confirm a breakout.

[TAP_CANDLE] In breakout retest, tap where price response becomes clearest.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
CHART: breakoutRetest
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

[FILL] The missing evidence in this breakout retest read is [___].
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
support on retest
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on support on retest.

NODE 75
TITLE: Breakdown Retest
CELEBRATION: Breakdown Retest complete.

[BOOKDRAG] Route the order used in this breakdown retest example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Which conclusion is justified by the developing price response in breakdown retest?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Connect the behaviors that matter for breakdown retest.
Breakdown Retest => Resistance on retest
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[MC] Which statement best connects the evidence in this breakdown retest replay?
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
CHART: breakdownRetest
A rejected retest can confirm a breakdown
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: A rejected retest can confirm a breakdown.

NODE 76
TITLE: Chasing Breakouts
CELEBRATION: Chasing Breakouts complete.

[TAP_CANDLE] In chasing breakouts, tap where price response becomes clearest.
VISUAL: Price opens well above the prior trading area with little activity between the two zones. The candles are tappable and the learner must select the requested candle.
CHART: gapUp
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[AGGRESSOR] During chasing breakouts, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which conclusion is best supported by the evidence in chasing breakouts?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Late entries carry worse risk and reward
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Late entries carry worse risk and reward.

[ORDER] Build the chasing breakouts read from evidence to conclusion.
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
CHART: gapUp
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 77
TITLE: Breakout Review
CELEBRATION: Breakout Review complete.

[FILL] The missing evidence in this breakout review read is [___].
VISUAL: Higher lows press into a flat resistance level before price tests the upper boundary.
CHART: ascendingTriangle
pressure and acceptance
positive delta without progress
a wick without tape evidence
depth far from the active price
WHY: Focus on pressure and acceptance.

[MC] Which explanation of breakout review requires the fewest assumptions?
VISUAL: Higher lows press into a flat resistance level before price tests the upper boundary.
CHART: ascendingTriangle
Combine pressure, level break, and acceptance
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Combine pressure, level break, and acceptance.

[MATCH] Connect the behaviors that matter for breakout review.
Breakout Review => Pressure and acceptance
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

NODE 78
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

[TIME_SALES] Buying prints remain active but price response stalls. Which warning is present?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
Aggression is not producing follow through
The breakout is guaranteed after a delay
Resting liquidity no longer matters
WHY: Active prints are not enough when price stops responding.

[ORDER] Build the common order flow misconceptions read from evidence to conclusion.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.


UNIT 8 — Pullbacks and Continuation

NODE 79
TITLE: Healthy Pullbacks
CELEBRATION: Healthy Pullbacks complete.

[MC] Which conclusion is most reasonable for the current healthy pullbacks evidence?
VISUAL: An established rise pauses with smaller bearish candles before testing trend continuation.
CHART: pullbackUptrend
A healthy pullback shows weaker counter pressure
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: A healthy pullback shows weaker counter pressure.

[BOOKDRAG] Route the order used in this healthy pullbacks example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for healthy pullbacks.
Healthy Pullbacks => Lighter selling
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: An established rise pauses with smaller bearish candles before testing trend continuation. The learner draws directly between two candles to mark the structure.
CHART: pullbackUptrend
TARGET: 2 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

NODE 80
TITLE: Pullback Depth
CELEBRATION: Pullback Depth complete.

[MC] Which conclusion about pullback depth is best supported?
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
CHART: ascendingChannel
Shallow defended pullbacks show trend strength
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Shallow defended pullbacks show trend strength.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary. The learner draws directly between two candles to mark the structure.
CHART: ascendingChannel
TARGET: 0 => 3
WHY: Structure supplies location. Execution evidence supplies the read.

[FILL] The missing evidence in this pullback depth read is [___].
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
CHART: ascendingChannel
defended structure
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on defended structure.

NODE 81
TITLE: Seller Pullback
CELEBRATION: Seller Pullback complete.

[BOOKDRAG] Route the order used in this seller pullback example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Which price behavior now supports the seller pullback read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Connect the behaviors that matter for seller pullback.
Seller Pullback => Lighter buying
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] Which statement best connects the evidence in this seller pullback replay?
VISUAL: Each rebound ends below the previous high while price continues making lower lows.
CHART: lowerHighsDowntrend
A bearish pullback shows weaker buying
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: A bearish pullback shows weaker buying.

NODE 82
TITLE: Continuation Trigger
CELEBRATION: Continuation Trigger complete.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
CHART: bullFlag
TARGET: 0 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[AGGRESSOR] During continuation trigger, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which conclusion is best supported by the evidence in continuation trigger?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Continuation begins when trend pressure returns
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Continuation begins when trend pressure returns.

[ORDER] Build the continuation trigger read from evidence to conclusion.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 83
TITLE: Bearish Continuation
CELEBRATION: Bearish Continuation complete.

[FILL] The missing evidence in this bearish continuation read is [___].
VISUAL: A sharp decline pauses in a small upward sloping channel before sellers test control again.
CHART: bearFlag
sellers return
positive delta without progress
a wick without tape evidence
depth far from the active price
WHY: Focus on sellers return.

[MC] Which explanation of bearish continuation requires the fewest assumptions?
VISUAL: A sharp decline pauses in a small upward sloping channel before sellers test control again.
CHART: bearFlag
Bearish continuation begins when sellers return
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Bearish continuation begins when sellers return.

[MATCH] Connect the behaviors that matter for bearish continuation.
Bearish Continuation => Sellers return
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

NODE 84
TITLE: Order Flow at VWAP
CELEBRATION: Order Flow at VWAP complete.

[AGGRESSOR] During order flow at vwap, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[LIVE_CHART] As the order flow at vwap replay develops, what changed in price response?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MC] Which interpretation is best supported in this order flow at vwap example?
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
VWAP provides location while order flow determines the response
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: VWAP provides location while order flow determines the response.

[FILL] The missing evidence in this order flow at vwap read is [___].
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
CHART: priceAboveVWAP
response as price tests VWAP
a single large print
displayed depth without execution
candle color without location
WHY: Focus on response as price tests VWAP.

NODE 85
TITLE: Order Flow at a Moving Average
CELEBRATION: Order Flow at a Moving Average complete.

[MC] Which conclusion is most reasonable for the current order flow at a moving average evidence?
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
CHART: priceAboveMA
The average provides location but execution evidence determines the read
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: The average provides location but execution evidence determines the read.

[BOOKDRAG] Route the order used in this order flow at a moving average example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for order flow at a moving average.
Order Flow at a Moving Average => Aggression near the average
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] In order flow at a moving average, tap where price response becomes clearest.
VISUAL: Candles hold above a rising moving average and react near it during pullbacks. The candles are tappable and the learner must select the requested candle.
CHART: priceAboveMA
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

NODE 86
TITLE: Pullback Failure
CELEBRATION: Pullback Failure complete.

[MC] Which conclusion about pullback failure is best supported?
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
Strong counter pressure can end continuation
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Strong counter pressure can end continuation.

[TAP_CANDLE] In pullback failure, tap where price response becomes clearest.
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise. The candles are tappable and the learner must select the requested candle.
CHART: bearishEngulfing
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[FILL] The missing evidence in this pullback failure read is [___].
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
CHART: bearishEngulfing
counter pressure grows
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on counter pressure grows.

NODE 87
TITLE: Conflicting Order Flow Signals
CELEBRATION: Conflicting Order Flow Signals complete.

[TIME_SALES] How does the tape qualify the price chart?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
Conflicting signals call for patience and a weaker conclusion
Tape speed guarantees directional acceptance
The chart makes execution data irrelevant
One large print resolves every conflict
WHY: Conflicting signals call for patience and a weaker conclusion.

[FOOTPRINT] Which interpretation uses both activity and price response?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
Conflicting signals call for patience and a weaker conclusion
The largest number on the footprint decides direction
High activity always creates a trend
Low activity means price cannot move
WHY: Conflicting signals call for patience and a weaker conclusion.

[MC] Which statement best connects the evidence in this conflicting order flow signals replay?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Conflicting signals call for patience and a weaker conclusion
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Conflicting signals call for patience and a weaker conclusion.

[TAP_CANDLE] In conflicting order flow signals, tap where price response becomes clearest.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress. The candles are tappable and the learner must select the requested candle.
CHART: spinningTop
TARGET: 2
WHY: The selected candle shows whether execution produced follow through.

[ORDER] Build the conflicting order flow signals read from evidence to conclusion.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 88
TITLE: High Volume Chop
CELEBRATION: High Volume Chop complete.

[TIME_SALES] How does the tape qualify the price chart?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
High volume without directional progress can show two sided absorption
Tape speed guarantees directional acceptance
The chart makes execution data irrelevant
One large print resolves every conflict
WHY: High volume without directional progress can show two sided absorption.

[FOOTPRINT] Which interpretation uses both activity and price response?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
High volume without directional progress can show two sided absorption
The largest number on the footprint decides direction
High activity always creates a trend
Low activity means price cannot move
WHY: High volume without directional progress can show two sided absorption.

[MC] Which conclusion is best supported by the evidence in high volume chop?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
High volume without directional progress can show two sided absorption
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: High volume without directional progress can show two sided absorption.

[TAP_CANDLE] In high volume chop, tap where price response becomes clearest.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction. The candles are tappable and the learner must select the requested candle.
CHART: range
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

[ORDER] Build the high volume chop read from evidence to conclusion.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
CHART: range
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 89
TITLE: Low Volume Trend
CELEBRATION: Low Volume Trend complete.

[TIME_SALES] How does the tape qualify the price chart?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
A trend can travel on low volume when little liquidity opposes it
Tape speed guarantees directional acceptance
The chart makes execution data irrelevant
One large print resolves every conflict
WHY: A trend can travel on low volume when little liquidity opposes it.

[FOOTPRINT] Which interpretation uses both activity and price response?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
A trend can travel on low volume when little liquidity opposes it
The largest number on the footprint decides direction
High activity always creates a trend
Low activity means price cannot move
WHY: A trend can travel on low volume when little liquidity opposes it.

[MC] Which explanation of low volume trend requires the fewest assumptions?
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
CHART: ascendingChannel
A trend can travel on low volume when little liquidity opposes it
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: A trend can travel on low volume when little liquidity opposes it.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary. The learner draws directly between two candles to mark the structure.
CHART: ascendingChannel
TARGET: 2 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[ORDER] Build the low volume trend read from evidence to conclusion.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
CHART: ascendingChannel
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 90
TITLE: No Clear Read Simulation
CELEBRATION: No Clear Read Simulation complete.

[ORDERFLOW_SIM] Book tape and price response disagree. What is strongest?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
The evidence conflicts so no directional read is confirmed
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: When evidence conflicts the strongest conclusion may be no clear read.

[MC] Which interpretation is best supported in this no clear read simulation example?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
When evidence conflicts the strongest conclusion may be no clear read
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: When evidence conflicts the strongest conclusion may be no clear read.

[ORDER] Build the no clear read simulation read from evidence to conclusion.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 91
TITLE: Entry After Confirmation
CELEBRATION: Entry After Confirmation complete.

[MC] Which conclusion is most reasonable for the current entry after confirmation evidence?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
Wait for pressure to return before entry
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: Wait for pressure to return before entry.

[BOOKDRAG] Route the order used in this entry after confirmation example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for entry after confirmation.
Entry After Confirmation => Pressure returns
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] In entry after confirmation, tap where price response becomes clearest.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
CHART: breakoutRetest
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

NODE 92
TITLE: Continuation Review
CELEBRATION: Continuation Review complete.

[MC] Which conclusion about continuation review is best supported?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Continuation needs structure and renewed pressure
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Continuation needs structure and renewed pressure.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
CHART: bullFlag
TARGET: 0 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[FILL] The missing evidence in this continuation review read is [___].
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
trend pressure returns
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on trend pressure returns.

NODE 93
TITLE: Breakout and Continuation Mixed Review
CELEBRATION: Breakout and Continuation Mixed Review complete.

[BOOKDRAG] Route the order used in this breakout and continuation mixed review example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[LIVE_CHART] Which price behavior now supports the breakout and continuation mixed review read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
DIRECTION: sideways
Price is not gaining directional acceptance
Upward price response is developing
Downward price response is developing
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Connect the behaviors that matter for breakout and continuation mixed review.
Breakout and Continuation Mixed Review => Acceptance and renewed pressure
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] Which statement best connects the evidence in this breakout and continuation mixed review replay?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
CHART: bullFlag
Continuation needs both structure and returning pressure
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Continuation needs both structure and returning pressure.


UNIT 9 — Reversals and Traps

NODE 94
TITLE: Reversal Pressure
CELEBRATION: Reversal Pressure complete.

[TIME_SALES] Which tape change matters most for reversal pressure?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Reversals need a clear change in control
Positive delta confirms a reversal regardless of price response
Slower tape guarantees the opposing side has control
WHY: Reversals need a clear change in control.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which conclusion is best supported by the evidence in reversal pressure?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Reversals need a clear change in control
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Reversals need a clear change in control.

NODE 95
TITLE: Buyer Trap
CELEBRATION: Buyer Trap complete.

[TIME_SALES] Which tape change matters most for buyer trap?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
A buyer trap forms when a breakout fails
A large opposing print outweighs the executions that follow
Price location is unnecessary once a reversal candle closes
WHY: A buyer trap forms when a breakout fails.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which explanation of buyer trap requires the fewest assumptions?
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
CHART: shootingStar
A buyer trap forms when a breakout fails
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: A buyer trap forms when a breakout fails.

NODE 96
TITLE: Seller Trap
CELEBRATION: Seller Trap complete.

[TIME_SALES] Which tape change matters most for seller trap?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
A seller trap forms when a breakdown fails
The candle pattern identifies every initiating trade
The earliest pressure cannot be contradicted later
WHY: A seller trap forms when a breakdown fails.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which interpretation is best supported in this seller trap example?
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
CHART: hammer
A seller trap forms when a breakdown fails
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: A seller trap forms when a breakdown fails.

NODE 97
TITLE: Exhaustion Reversal
CELEBRATION: Exhaustion Reversal complete.

[TIME_SALES] Which tape change matters most for exhaustion reversal?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
EVENT: stall
Exhaustion can prepare a reversal
A rejection wick proves passive absorption
The second test should inherit the first test's order flow
WHY: Exhaustion can prepare a reversal.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
EVENT: balanced
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which conclusion is most reasonable for the current exhaustion reversal evidence?
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
CHART: doji
Exhaustion can prepare a reversal
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Exhaustion can prepare a reversal.

NODE 98
TITLE: Absorption Reversal
CELEBRATION: Absorption Reversal complete.

[TIME_SALES] Which tape change matters most for absorption reversal?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Absorbed selling can support a reversal
Positive delta confirms a reversal regardless of price response
Slower tape guarantees the opposing side has control
WHY: Absorbed selling can support a reversal.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which conclusion about absorption reversal is best supported?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
CHART: rejectionWickDown
Absorbed selling can support a reversal
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Absorbed selling can support a reversal.

NODE 99
TITLE: Double Top Flow
CELEBRATION: Double Top Flow complete.

[TIME_SALES] Which tape change matters most for double top flow?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
EVENT: lift
Repeated failure can shift control to sellers
A large opposing print outweighs the executions that follow
Price location is unnecessary once a reversal candle closes
WHY: Repeated failure can shift control to sellers.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
EVENT: hit
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which statement best connects the evidence in this double top flow replay?
VISUAL: Price tests the same resistance area twice and retreats after the second test.
CHART: doubleTop
Repeated failure can shift control to sellers
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Repeated failure can shift control to sellers.

NODE 100
TITLE: Double Bottom Flow
CELEBRATION: Double Bottom Flow complete.

[TIME_SALES] Which tape change matters most for double bottom flow?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Repeated failure can shift control to buyers
The candle pattern identifies every initiating trade
The earliest pressure cannot be contradicted later
WHY: Repeated failure can shift control to buyers.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which conclusion is best supported by the evidence in double bottom flow?
VISUAL: Price tests the same support area twice and rebounds after the second test.
CHART: doubleBottom
Repeated failure can shift control to buyers
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Repeated failure can shift control to buyers.

NODE 101
TITLE: Confirmation Before Entry
CELEBRATION: Confirmation Before Entry complete.

[TIME_SALES] Which tape change matters most for confirmation before entry?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
Confirmation reduces premature reversal entries
A rejection wick proves passive absorption
The second test should inherit the first test's order flow
WHY: Confirmation reduces premature reversal entries.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which explanation of confirmation before entry requires the fewest assumptions?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
CHART: bullishEngulfing
Confirmation reduces premature reversal entries
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Confirmation reduces premature reversal entries.

NODE 102
TITLE: Reversal Review
CELEBRATION: Reversal Review complete.

[ORDERFLOW_SIM] Which evidence source prevents an immediate reversal conclusion?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
Aggression and price response still conflict
The candle pattern guarantees confirmation
Positive delta makes location irrelevant
WHY: A reversal needs a control change and confirming response.

[TIME_SALES] Which tape change matters most for reversal review?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
EVENT: hit
A reversal needs control change and confirmation
Positive delta confirms a reversal regardless of price response
Slower tape guarantees the opposing side has control
WHY: A reversal needs control change and confirmation.

[FOOTPRINT] How does executed volume qualify the reversal pattern?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
EVENT: lift
It shows whether aggressive control changed beneath the price pattern
It guarantees the pattern target
It only shows resting liquidity
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which interpretation is best supported in this reversal review example?
VISUAL: Three troughs form with the middle trough deepest before price challenges the neckline.
CHART: inverseHeadShoulders
A reversal needs control change and confirmation
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: A reversal needs control change and confirmation.


UNIT 10 — Execution and Risk

NODE 103
TITLE: Plan the Entry
CELEBRATION: Plan the Entry complete.

[MC] Which conclusion is most reasonable for the current plan the entry evidence?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
CHART: breakoutRetest
A clear trigger keeps execution disciplined
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: A clear trigger keeps execution disciplined.

[BOOKDRAG] Route the order used in this plan the entry example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for plan the entry.
Plan the Entry => Defined trigger
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] In plan the entry, tap where price response becomes clearest.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
CHART: breakoutRetest
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

NODE 104
TITLE: Choose the Order Type
CELEBRATION: Choose the Order Type complete.

[MC] Which conclusion about choose the order type is best supported?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Order choice balances speed with price control
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Order choice balances speed with price control.

[TAP_CANDLE] In choose the order type, tap where price response becomes clearest.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
CHART: sideways
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

[FILL] The missing evidence in this choose the order type read is [___].
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
speed versus price
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on speed versus price.

NODE 105
TITLE: Manage Slippage
CELEBRATION: Manage Slippage complete.

[BOOKDRAG] Route the order used in this manage slippage example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for manage slippage.
Manage Slippage => Available liquidity
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] Which statement best connects the evidence in this manage slippage replay?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Thin liquidity can increase slippage
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Thin liquidity can increase slippage.

NODE 106
TITLE: Order Flow Invalidation
CELEBRATION: Order Flow Invalidation complete.

[TAP_CANDLE] In order flow invalidation, tap where price response becomes clearest.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area. The candles are tappable and the learner must select the requested candle.
CHART: supportBounce
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[AGGRESSOR] During order flow invalidation, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

[MC] Which conclusion is best supported by the evidence in order flow invalidation?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Risk belongs beyond the evidence that would invalidate the order flow read
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Risk belongs beyond the evidence that would invalidate the order flow read.

[ORDER] Build the order flow invalidation read from evidence to conclusion.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 107
TITLE: Risk in Thin Liquidity
CELEBRATION: Risk in Thin Liquidity complete.

[FILL] The missing evidence in this risk in thin liquidity read is [___].
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
slippage and unstable depth
positive delta without progress
a wick without tape evidence
depth far from the active price
WHY: Focus on slippage and unstable depth.

[MC] Which explanation of risk in thin liquidity requires the fewest assumptions?
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
CHART: bandsWidening
Thin liquidity can require smaller risk and more cautious execution
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Thin liquidity can require smaller risk and more cautious execution.

[MATCH] Connect the behaviors that matter for risk in thin liquidity.
Risk in Thin Liquidity => Slippage and unstable depth
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

NODE 108
TITLE: No Clear Order Flow Read
CELEBRATION: No Clear Order Flow Read complete.

[AGGRESSOR] During no clear order flow read, which side is crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
EVENT: hit
ANSWER: The seller
WHY: Buyers take offers. Sellers take bids.

[MC] Which interpretation is best supported in this no clear order flow read example?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
Conflicting evidence is a valid reason to stay out
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Conflicting evidence is a valid reason to stay out.

[FILL] The missing evidence in this no clear order flow read read is [___].
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
CHART: spinningTop
conflicting evidence
a single large print
displayed depth without execution
candle color without location
WHY: Focus on conflicting evidence.

NODE 109
TITLE: Exit Into Liquidity
CELEBRATION: Exit Into Liquidity complete.

[MC] Which conclusion is most reasonable for the current exit into liquidity evidence?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
CHART: resistanceRejection
Liquidity can improve planned exits
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Liquidity can improve planned exits.

[BOOKDRAG] Route the order used in this exit into liquidity example.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Connect the behaviors that matter for exit into liquidity.
Exit Into Liquidity => Available buyers or sellers
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] In exit into liquidity, tap where price response becomes clearest.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The candles are tappable and the learner must select the requested candle.
CHART: resistanceRejection
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

NODE 110
TITLE: Review the Order Flow Read
CELEBRATION: Review the Order Flow Read complete.

[MC] Which conclusion about review the order flow read is best supported?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
Review each evidence source separately from the trade outcome
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Review each evidence source separately from the trade outcome.

[TAP_CANDLE] In review the order flow read, tap where price response becomes clearest.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
CHART: sideways
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

[FILL] The missing evidence in this review the order flow read read is [___].
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
CHART: sideways
whether book tape footprint and price behaved as expected
resting size that never trades
one isolated footprint row
direction without follow through
WHY: Focus on whether book tape footprint and price behaved as expected.

NODE 111
TITLE: Comprehensive Order Flow Simulation
CELEBRATION: Comprehensive Order Flow Simulation complete.

[ORDERFLOW_SIM] Buying is aggressive but price cannot clear resistance. What is the strongest current observation?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
Buyers are active but may be absorbed by refreshing sellers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Build one read from book tape footprint price and risk.

[MC] Which statement best connects the evidence in this comprehensive order flow simulation replay?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Build one read from book tape footprint price and risk
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Build one read from book tape footprint price and risk.

[ORDER] Build the comprehensive order flow simulation read from evidence to conclusion.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.
