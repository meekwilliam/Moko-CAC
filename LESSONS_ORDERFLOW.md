# Order Flow strategy course authoring source

Course id: `orderflow` · accent `#14B8A6` · standalone strategy track.
Mirrors `Moko/GameData.json`. Correct answers appear first for choice and fill questions.
No intro blocks. Most questions render an order book, chart, or live chart.

Interactive mechanics:
  [AGGRESSOR] Watch a live ladder and choose the aggressive side.
  [BOOKDRAG] Route a market order to the bid or ask.
  [BOOK_COMPARE] Compare thick and thin Level II depth.
  [EVIDENCE_SELECT] Choose the clues that complete an evidence stack.
  [MARK_LEVEL] Mark a support or resistance area directly on a chart.
  [REPLAY_COMPARE] Compare acceptance with replenishment and rejection.
  [TAP_CANDLE] Select a candle directly on a chart.
  [TRENDLINE] Connect two candles on a chart.
  [LIVE_CHART] Read pressure while candles update.
  [ORDERFLOW_SIM] Read combined price, book, tape, and footprint evidence across sources at once.
  [TIME_SALES] Read an animated feed of completed trades.
  [TIME_SALES_TAP] Select evidence directly from the animated tape.
  [FOOTPRINT] Compare bid and ask volume at each price.
  [FOOTPRINT_TAP] Select an imbalance directly on the footprint.

TOTAL UNITS: 10
TOTAL LESSONS: 111
TOTAL QUESTIONS: 466

UNIT 1 — Order Flow Foundations
TIER: Beginner

NODE 1
TITLE: What Is Order Flow?
TYPE: STANDARD
CELEBRATION: You get what order flow really means.

[MC] What is order flow?
SKILL: what_is_order_flow
Live buying, selling, and liquidity
The order candles appear in
A sequence of chart patterns
WHY: Order flow shows live trading pressure and liquidity.

[TF] Order flow shows more than a finished price line.
SKILL: what_is_order_flow
ANSWER: True
WHY: It adds context about current pressure and liquidity.

[AGGRESSOR] Offers are being taken. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers, so buyers are aggressive.

[MATCH] Match each term.
SKILL: what_is_order_flow
Order flow => Live buying and selling
Price => Result of execution
A candle => Record of past price
WHY: Orders create fills. Fills create price. Candles record it.

[MC] What does order flow reveal?
SKILL: what_is_order_flow
Buyer and seller pressure
Future prices with certainty
Only candle direction
WHY: Order flow compares active pressure, liquidity, and price response.

[ORDER] Build the order flow chain.
SKILL: market_sequence
Buyers and sellers place orders
Orders execute against each other
Price moves to the last fill
The candle updates on the chart
WHY: Orders create fills. Fills update price and the chart.

NODE 2
TITLE: Aggressive vs. Passive Orders
TYPE: STANDARD
CELEBRATION: You can tell takers from makers.

[MC] Pick the aggressive order.
SKILL: aggressive_vs_passive_orders
Takes available liquidity now
Waits at a chosen price
Only fills at the open
WHY: Aggressive orders trade now and remove liquidity.

[MC] Pick the passive order.
SKILL: aggressive_vs_passive_orders
Waits at a chosen price
Always fills now
Placed by your broker
WHY: Passive orders wait and provide liquidity.

[BOOKDRAG] Market buy. Tap its fill side.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Market sell. Tap its fill side.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[MATCH] Match maker or taker.
SKILL: aggressive_vs_passive_orders
Instant market buy => Taker
Resting limit sell => Maker
Hit the bid now => Taker
WHY: Takers trade now. Makers wait.

[TF] Aggressive orders remove liquidity; passive orders provide it.
SKILL: aggressive_vs_passive_orders
ANSWER: True
WHY: Takers remove liquidity. Makers provide it.

[AGGRESSOR] Bids are being taken. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
SKILL: aggressor_side
EVENT: hit
ANSWER: The seller
WHY: Sellers hit bids, so sellers are aggressive.

NODE 3
TITLE: The Bid, Ask & Spread
TYPE: STANDARD
CELEBRATION: You own the bid, ask and spread.

[MC] Pick the bid.
SKILL: bid_ask_spread
Highest buyer price
Lowest seller price
Last traded price
WHY: The bid is the best resting buy price.

[MC] Pick the ask.
SKILL: bid_ask_spread
Lowest seller price
Highest buyer price
Average daily price
WHY: The ask is the best resting sell price.

[MC] What's the bid ask gap called?
SKILL: bid_ask_spread
The spread
Delta
Depth
WHY: The spread is the distance between the best bid and ask.

[BOOKDRAG] Buy now. Tap the fill side.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: Buying now means paying the ask.

[BOOKDRAG] Sell now. Tap the fill side.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_sell
ANSWER: the bid
WHY: Selling immediately means hitting the bid.

[MATCH] Match each action.
SKILL: bid_ask_spread
Market buy => Ask
Market sell => Bid
Spread => Ask minus bid
WHY: Buy at the ask. Sell at the bid.

[TF] A wider spread generally signals thinner liquidity.
SKILL: bid_ask_spread
ANSWER: True
WHY: Less nearby liquidity can widen the spread.

NODE 4
TITLE: Lifting the Offer & Hitting the Bid
TYPE: STANDARD
CELEBRATION: You can read aggression in the book.

[MC] Which action lifts the offer?
SKILL: lifting_the_offer_hitting_the_bid
Buying the ask
Canceling a sell order
Posting a higher offer
WHY: Lifting the offer means buying the ask.

[AGGRESSOR] Offers are getting eaten. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: The buyer is lifting the offer.

[AGGRESSOR] Bids are getting eaten. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
SKILL: aggressor_side
EVENT: hit
ANSWER: The seller
WHY: The seller is hitting the bid.

[MC] How do sellers trade aggressively?
SKILL: lifting_the_offer_hitting_the_bid
They hit the bid
They post above the ask
They raise the bid
WHY: Aggressive sellers cross the spread and execute against bids.

[MATCH] Match each action.
SKILL: lifting_the_offer_hitting_the_bid
Lift the offer => May push price up
Hit the bid => May push price down
Only resting orders => Price may stay still
WHY: Aggression consumes liquidity and can move price.

[BOOKDRAG] Lift the offer. Tap the side taken.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[AGGRESSOR] Buyers keep lifting offers. Who controls?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Persistent lifting shows buyer control.

NODE 5
TITLE: Boss Battle: Foundations Under Pressure
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Foundations Under Pressure complete.

[AGGRESSOR] Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Buyers are lifting offers.

[BOOKDRAG] Where does a market buy execute?
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take the ask.

[BOOKDRAG] Where does a market sell execute?
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_sell
ANSWER: the bid
WHY: Market sells hit the bid.

[MC] Which order is passive?
SKILL: boss_battle_foundations_under_pressure
A limit order resting at price
A market order crossing now
A completed execution
WHY: Passive orders rest as liquidity.

[EVIDENCE_SELECT] Select the complete market read.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1, 2
Aggressor
Liquidity
Price response
Candle color
WHY: A complete read combines action, liquidity, and response. Candle color repeats what price already shows.


UNIT 2 — The Order Book
TIER: Beginner

NODE 6
TITLE: What the Order Book Shows
TYPE: STANDARD
CELEBRATION: You know what Level II actually shows.

[MC] What does Level II show?
SKILL: what_the_order_book_shows
The full depth of resting orders on both sides.
Only the best bid and ask.
Every trade already executed.
WHY: Level II is the whole ladder of resting limit orders. Level I is just the top of book; executed trades live in time & sales.

[MC] What does Level I show?
SKILL: what_the_order_book_shows
Only the best bid and ask.
The full resting depth on both sides.
The day's executed trades.
WHY: Level I is the top of the book. the single best bid and best ask.

[MATCH] Match each feed to what it shows.
SKILL: what_the_order_book_shows
Level I => Best bid and ask
Level II => Full resting depth
Time & Sales => Executed trades
WHY: Three lenses: top of book, the full book, and the trades that already happened.

[AGGRESSOR] Tap the aggressor.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: The offers are being taken, so the buyer is the aggressor lifting them.

[BOOKDRAG] Tap the side this buy fills against.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the resting offers. it fills at the ask.

[TF] The order book shows resting orders, not completed trades.
SKILL: what_the_order_book_shows
ANSWER: True
WHY: Resting orders are still waiting to fill; completed trades show up in time & sales.

[ORDER] Order a limit order's life in the book.
SKILL: market_sequence
A trader posts a limit order
It rests in the book
An aggressor takes it
It leaves the book
WHY: Resting liquidity sits until an aggressive order consumes it.

NODE 7
TITLE: Bid Side vs. Ask Side
TYPE: STANDARD
CELEBRATION: You can read both sides of the book.

[MC] Where do resting buy orders sit?
SKILL: bid_side_vs_ask_side
The bid side.
The ask side.
The spread.
WHY: Buyers rest on the bid. Sellers rest on the ask, and the spread is the gap between them.

[MC] Where do resting sell orders sit?
SKILL: bid_side_vs_ask_side
The ask side.
The bid side.
The spread.
WHY: Sellers rest on the ask side, above the spread.

[BOOKDRAG] Tap the side this buy fills against.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: A market buy lifts the ask.

[BOOKDRAG] Tap the side this sell fills against.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[MATCH] Match each part of the book.
SKILL: bid_side_vs_ask_side
Bid side => Resting buyers
Ask side => Resting sellers
Spread => Gap between them
WHY: Buyers below, sellers above, the spread in between.

[TF] The best bid sits just below the best ask.
SKILL: bid_side_vs_ask_side
ANSWER: True
WHY: The bid is always below the ask; the distance between them is the spread.

[AGGRESSOR] Tap the aggressor.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
SKILL: aggressor_side
EVENT: hit
ANSWER: The seller
WHY: The bids are being taken, so the seller is the aggressor.

NODE 8
TITLE: Size & Liquidity
TYPE: STANDARD
CELEBRATION: You can read depth and liquidity.

[MC] What does the number beside a price show?
SKILL: size_and_liquidity
The size resting there.
The trades done there.
Its distance from the last price.
WHY: The number is resting size. how many shares sit waiting at that price.

[MC] A book with large size at every level is…
SKILL: size_and_liquidity
Liquid.
Illiquid.
Volatile.
WHY: Plenty of resting size means liquid: price needs a lot of aggression to move.

[TF] A thin book moves on fewer orders than a thick one.
SKILL: size_and_liquidity
ANSWER: True
WHY: Less resting size means each aggressive order pushes price further.

[MATCH] Match each book to how it moves.
SKILL: size_and_liquidity
Thick book => Hard to move
Thin book => Easy to move
Resting size => Liquidity at a price
WHY: Depth is what absorbs aggression; without it, price jumps.

[AGGRESSOR] Tap the aggressor.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Offers being taken means the buyer is the aggressor.

[BOOKDRAG] Tap the side this sell fills against.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[ORDER] Order what happens as a thin book gets hit.
SKILL: market_sequence
A small resting size sits at the bid
A market sell hits it
The bid clears fast
Price drops to the next level
WHY: Thin liquidity clears quickly, so price jumps to the next level.

NODE 9
TITLE: Large Orders as Walls
TYPE: STANDARD
CELEBRATION: You can spot walls acting as support and resistance.

[BOOK_COMPARE] Which book shows the larger wall?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book A
Book B
Both are equal
WHY: Book A shows substantially more resting depth near price.

[MC] A large resting ask can act as…
SKILL: large_orders_as_walls
Temporary resistance.
Temporary support.
A guaranteed ceiling.
WHY: A big ask can cap price temporarily; it isn't a certainty.

[TF] A large resting order guarantees price stops there.
SKILL: large_orders_as_walls
ANSWER: False
WHY: It can be absorbed or pulled. It's a clue, not a guarantee.

[MATCH] Match each wall to its effect.
SKILL: large_orders_as_walls
Large bid => Support
Large ask => Resistance
Pulled wall => Level vanishes
WHY: Big bids hold price up, big asks cap it. until they're pulled.

[ORDER] Order how a defended bid holds.
SKILL: market_sequence
Price falls toward a large bid
Sellers hit into it
The bid absorbs the selling
Price holds above it
WHY: A big resting bid can soak up selling and hold price above it.

[AGGRESSOR] Tap the aggressor.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with bid sizes being consumed by incoming sell orders.
SKILL: aggressor_side
EVENT: hit
ANSWER: The seller
WHY: Bids being taken means the seller is the aggressor.

[BOOKDRAG] Tap the side this buy fills against.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: A market buy fills at the ask.

NODE 10
TITLE: Pulling & Spoofing
TYPE: STANDARD
CELEBRATION: You know the book is live and can deceive.

[REPLAY_COMPARE] Which wall absorbed selling?
VISUAL: Replay A shows sellers hitting a large bid that replenishes while price holds. Replay B shows a large bid getting pulled before price falls through.
SKILL: scenario_comparison
Replay A
Replay B
Neither replay
WHY: Replay A replenishes while trading and price holds. Replay B pulls before the decline.

[MC] Repeated deceptive posting and cancellation intended to mislead may constitute…
SKILL: pulling_and_spoofing
Spoofing.
Absorption.
A breakout.
WHY: Repeated deceptive posting and cancellation intended to mislead may constitute spoofing. One cancelled order alone does not prove intent.

[TF] A resting order is a firm promise to trade.
SKILL: pulling_and_spoofing
ANSWER: False
WHY: It can be cancelled before anyone hits it.

[MATCH] Match each behavior.
SKILL: pulling_and_spoofing
Pulled order => Cancelled before filling
Refreshed order => Replenished after filling
Spoof => Shown then pulled
WHY: The book is live: orders appear, refill, and disappear.

[AGGRESSOR] Tap the aggressor.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Offers being taken means the buyer is the aggressor.

[BOOKDRAG] Tap the side this sell fills against.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[ORDER] Order a spoof playing out.
SKILL: market_sequence
A big bid appears below price
Traders see support and buy
The big bid is pulled
Support vanishes
WHY: A displayed order that gets pulled can lure others in before it ever trades.

NODE 11
TITLE: The Order Book Review
TYPE: STANDARD
CELEBRATION: The order book is yours. you read depth, walls and tricks.

[MC] What does Level II show?
SKILL: the_order_book_review
The full depth of resting orders.
Just the best bid and ask.
Executed trades.
WHY: Level II is the full ladder of resting orders on both sides.

[BOOKDRAG] Tap the side this buy fills against.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Tap the side this sell fills against.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[AGGRESSOR] Tap the aggressor.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Offers being consumed means the buyer is the aggressor.

[MATCH] Match each order book idea.
SKILL: the_order_book_review
Bid side => Resting buyers
Ask side => Resting sellers
Large order => Temporary wall
Pulled order => Cancelled before filling
WHY: The backbone of reading a book: sides, walls, and the fact orders can vanish.

[TF] A large resting order guarantees price stops there.
SKILL: the_order_book_review
ANSWER: False
WHY: It can be absorbed or pulled. descriptive, not a guarantee.

[MC] A large resting bid acts as…
SKILL: the_order_book_review
Temporary support.
Temporary resistance.
A guaranteed floor.
WHY: A big bid holds price up temporarily, but it can be pulled.

[ORDER] Order how a wall gets tested.
SKILL: market_sequence
Price approaches a large resting order
Aggressors trade into it
It absorbs them and price stalls
The wall holds or gets pulled
WHY: A wall stalls price while it absorbs. then it either holds or disappears.

NODE 12
TITLE: What Actually Moves Price
TYPE: STANDARD
CELEBRATION: You understand imbalance.

[MC] What can push price higher?
SKILL: what_actually_moves_price
Aggressive buying takes offers
More shares exist
More candles print
WHY: Aggressive buying can consume offers and lift price.

[TF] A large displayed order guarantees price will hold.
SKILL: what_actually_moves_price
ANSWER: False
WHY: Displayed orders can change or disappear.

[MC] What can create directional movement?
SKILL: what_actually_moves_price
Aggression overwhelms or outlasts liquidity
More candles appear
Displayed size never changes
WHY: Price can move when pressure consumes liquidity, liquidity withdraws, or both.

[ORDER] Build the upward move.
SKILL: market_sequence
Buyers become more aggressive
Offers get consumed
Price reaches higher asks
A green candle appears
WHY: Buyer pressure consumes offers before the chart updates.

[MATCH] Match pressure to price.
SKILL: what_actually_moves_price
Buyer imbalance => May push price up
Seller imbalance => May push price down
Balanced pressure => May keep price ranging
WHY: Pressure suggests direction, but conditions can change.

[AGGRESSOR] Price grinds higher. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Aggressive buyers are lifting offers.

[BOOKDRAG] Push price up. Tap the side buyers take.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: Buyers take asks to move price higher.

NODE 13
TITLE: Boss Battle: Read the Book
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Read the Book complete.

[MC] What does Level II add?
SKILL: boss_battle_read_the_book
Depth across price levels
Only the last trade
Future orders with certainty
WHY: Level II displays resting depth across prices.

[BOOK_COMPARE] Which book should move more easily?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B
Book A
Both equally
WHY: Book B is thinner and contains gaps.

[REPLAY_COMPARE] Which replay shows liquidity being pulled?
VISUAL: Replay A shows sellers hitting a large bid that replenishes while price holds. Replay B shows a large bid getting pulled before price falls through.
SKILL: book_depth
Replay B
Replay A
Neither replay
WHY: Replay B's bid disappears before the decline. Pulled liquidity vanishes; absorbed liquidity keeps trading.

[REPLAY_COMPARE] Which wall absorbed selling?
VISUAL: Replay A shows sellers hitting a large bid that replenishes while price holds. Replay B shows a large bid getting pulled before price falls through.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: Replay A replenishes while trading and price holds.

[MC] What happened when the bid vanished?
SKILL: boss_battle_read_the_book
Liquidity was pulled
Selling was absorbed
The spread closed
WHY: The displayed bid disappeared before trading.

[EVIDENCE_SELECT] Select the holding wall clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1, 2
Repeated fills
Replenishing size
Price holds
Wall pulls
WHY: Trading, replenishment, and response distinguish a holding wall.


UNIT 3 — Tape Reading
TIER: Intermediate

NODE 14
TITLE: Reading Time and Sales
TYPE: STANDARD
CELEBRATION: Reading Time and Sales complete.

[TIME_SALES] What information does each row provide?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Execution time price size and initiating side
Resting bid and ask size before execution
Total candle volume without trade direction
WHY: Each row is a completed trade with time price size and side.

[TIME_SALES] Which side is initiating these trades?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Sellers
Buyers
Neither side can initiate a trade
WHY: Trades at the bid are seller initiated.

[TIME_SALES_TAP] In reading time and sales, tap the most informative print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_interaction
EVENT: large_print
TARGET: 3
WHY: The selected execution carries the key tape evidence.

[MATCH] Match each clue.
SKILL: reading_time_and_sales
Reading Time and Sales => Price size and side
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

NODE 15
TITLE: Reading the Tape
TYPE: STANDARD
CELEBRATION: Reading the Tape complete.

[TIME_SALES] Which tape behavior best supports the reading the tape read?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Prints reveal completed trades
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Prints reveal completed trades.

[TIME_SALES_TAP] In reading the tape, tap the most informative print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_interaction
EVENT: large_print
TARGET: 1
WHY: The selected execution carries the key tape evidence.

[MC] Did price confirm the tape?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: reading_the_tape
CHART: sideways
Price response remains inconclusive
Price fully confirms buyers
Price fully confirms sellers
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[AGGRESSOR] Who's crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

NODE 16
TITLE: Trade Speed
TYPE: STANDARD
CELEBRATION: Trade Speed complete.

[TIME_SALES] The prints begin slowly and then arrive faster. What changed?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_reading
EVENT: accelerating
Faster prints can reveal rising activity
Displayed depth changed but no completed trade confirms participation
Candle direction identifies the initiating side of every execution
WHY: Faster prints can reveal rising activity.

[TIME_SALES_TAP] Tap the first print where the tape begins accelerating.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_interaction
EVENT: accelerating
TARGET: 6
WHY: This print begins the faster arrival sequence.

[MC] Did price confirm the tape?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
SKILL: trade_speed
CHART: uptrend
Yes. Price made upward progress
No. Price rejected the buying
Not enough trades appeared
WHY: Use the chart only to judge whether price confirmed the tape evidence.

NODE 17
TITLE: Trade Size
TYPE: STANDARD
CELEBRATION: Trade Size complete.

[TIME_SALES] Which change in the feed shows unusually large participation?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_reading
EVENT: large_print
Larger trades can show stronger participation
The spread narrowed so trade pace no longer matters
One large print establishes persistent control
WHY: Larger trades can show stronger participation.

[TIME_SALES_TAP] Tap the unusually large executed trade.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_interaction
EVENT: large_print
TARGET: 4
WHY: This execution is much larger than the surrounding prints.

[MC] Did price confirm the tape?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
SKILL: trade_size
CHART: uptrend
Yes. Price made upward progress
No. Price rejected the buying
Not enough trades appeared
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[AGGRESSOR] Who's crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

NODE 18
TITLE: Repeated Prints
TYPE: STANDARD
CELEBRATION: Repeated Prints complete.

[TIME_SALES] Which side shows more persistent aggression across the sequence?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Repeated buys can show persistent demand
Total tape volume reveals where every resting order sits
The final print deserves more weight than the full sequence
WHY: Repeated buys can show persistent demand.

[TIME_SALES_TAP] Tap the print that breaks the dominant side sequence.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one opposing print interrupting a persistent buyer sequence.
SKILL: tape_interaction
EVENT: sequence_break
TARGET: 2
WHY: This print interrupts the persistent aggression shown before it.

[MC] Did price confirm the tape?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
SKILL: repeated_prints
CHART: uptrend
Yes. Price made upward progress
No. Price rejected the buying
Not enough trades appeared
WHY: Use the chart only to judge whether price confirmed the tape evidence.

NODE 19
TITLE: Buyer Initiated Prints
TYPE: STANDARD
CELEBRATION: Buyer Initiated Prints complete.

[TIME_SALES] Where are the buyer initiated trades executing?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Trades at the ask suggest buyer aggression
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Trades at the ask suggest buyer aggression.

[TIME_SALES_TAP] Tap a buyer initiated execution at the ask.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the target row showing a buyer initiated execution at the ask.
SKILL: tape_interaction
EVENT: buyer_target
TARGET: 7
WHY: The selected trade executes at the ask and is buyer initiated.

[MC] Did price confirm the tape?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
SKILL: buyer_initiated_prints
CHART: uptrend
Yes. Price made upward progress
No. Price rejected the buying
Not enough trades appeared
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[EVIDENCE_SELECT] Select both confirmation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Persistent tape pressure
Matching price response
One isolated print
Candle color alone
WHY: Intermediate tape reading combines executions with price follow through.

NODE 20
TITLE: Seller Initiated Prints
TYPE: STANDARD
CELEBRATION: Seller Initiated Prints complete.

[TIME_SALES] Where are the seller initiated trades executing?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Trades at the bid suggest seller aggression
Displayed depth changed but no completed trade confirms participation
Candle direction identifies the initiating side of every execution
WHY: Trades at the bid suggest seller aggression.

[TIME_SALES_TAP] Tap a seller initiated execution at the bid.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the target row showing a seller initiated execution at the bid.
SKILL: tape_interaction
EVENT: seller_target
TARGET: 5
WHY: The selected trade executes at the bid and is seller initiated.

[MC] Did price confirm the tape?
VISUAL: A sequence of lower highs and lower lows moves from the upper left toward the lower right.
SKILL: seller_initiated_prints
CHART: downtrend
Yes. Price made downward progress
No. Price absorbed the selling
The chart cannot show response
WHY: Use the chart only to judge whether price confirmed the tape evidence.

NODE 21
TITLE: Pace Changes
TYPE: STANDARD
CELEBRATION: Pace Changes complete.

[TIME_SALES] What changed first before activity expanded?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_reading
EVENT: accelerating
A faster pace can precede expansion
The spread narrowed so trade pace no longer matters
One large print establishes persistent control
WHY: A faster pace can precede expansion.

[TIME_SALES_TAP] Tap where the tape first changes to a faster pace.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_interaction
EVENT: accelerating
TARGET: 3
WHY: The interval between prints begins shrinking here.

[MC] Did price confirm the tape?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
SKILL: pace_changes
CHART: uptrend
Yes. Price made upward progress
No. Price rejected the buying
Not enough trades appeared
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[EVIDENCE_SELECT] Select both confirmation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Persistent tape pressure
Matching price response
One isolated print
Candle color alone
WHY: Intermediate tape reading combines executions with price follow through.

NODE 22
TITLE: Tape at Key Levels
TYPE: STANDARD
CELEBRATION: Tape at Key Levels complete.

[TIME_SALES] Which tape behavior best supports the tape at key levels read?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Tape reaction matters most near key levels
Total tape volume reveals where every resting order sits
The final print deserves more weight than the full sequence
WHY: Tape reaction matters most near key levels.

[TIME_SALES_TAP] Tap the execution that first contradicts the dominant pressure.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one opposing print interrupting a persistent buyer sequence.
SKILL: tape_interaction
EVENT: sequence_break
TARGET: 1
WHY: The selected print is the first opposing execution at the level.

[MC] Did price confirm the tape?
VISUAL: A sequence of lower highs and lower lows moves from the upper left toward the lower right.
SKILL: tape_at_key_levels
CHART: downtrend
Yes. Price made downward progress
No. Price absorbed the selling
The chart cannot show response
WHY: Use the chart only to judge whether price confirmed the tape evidence.

NODE 23
TITLE: False Urgency
TYPE: STANDARD
CELEBRATION: False Urgency complete.

[TIME_SALES] Fast prints lose pace without price progress. What weakened?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Fast prints need price confirmation
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Fast prints need price confirmation.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_interaction
EVENT: stall
TARGET: 6
WHY: Prints continue but size and pace begin fading here.

[MC] Did price confirm the tape?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: false_urgency
CHART: sideways
No. Price failed to follow through
Yes. Speed confirmed acceptance
No. The spread was too narrow
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[EVIDENCE_SELECT] Select both confirmation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Persistent tape pressure
Matching price response
One isolated print
Candle color alone
WHY: Intermediate tape reading combines executions with price follow through.

NODE 24
TITLE: Boss Battle: Read the Tape
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Read the Tape complete.

[TIME_SALES] Who initiates these prints?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Buyers
Sellers
Neither
WHY: Trades at the ask are buyer initiated.

[TIME_SALES_TAP] Tap where pace accelerates.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_interaction
EVENT: accelerating
TARGET: 4
WHY: Print intervals shorten here.

[TIME_SALES_TAP] Tap the unusually large print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_interaction
EVENT: large_print
TARGET: 6
WHY: This print is much larger than surrounding trades.

[TIME_SALES] What does the sequence show?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Persistent buyer aggression
Persistent seller aggression
No executions
WHY: Buyer initiated prints dominate.

[TIME_SALES_TAP] Tap the sequence break.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one opposing print interrupting a persistent buyer sequence.
SKILL: tape_interaction
EVENT: sequence_break
TARGET: 5
WHY: This opposing print interrupts the dominant side.

[MC] Did price confirm the buying?
VISUAL: A sequence of higher highs and higher lows moves from the lower left toward the upper right.
SKILL: boss_battle_read_the_tape
CHART: uptrend
Yes. Price advanced
No. Price stalled
Price cannot confirm tape
WHY: Price made upward progress with the tape.

[REPLAY_COMPARE] Which replay shows false urgency?
VISUAL: Replay A keeps strong buying against a replenishing offer with stalled price. Replay B shows buying pace itself fading as price stalls.
SKILL: scenario_comparison
Replay B
Replay A
Both
WHY: Replay B shows aggression fading rather than continuing control.


UNIT 4 — Absorption and Exhaustion
TIER: Intermediate

NODE 25
TITLE: What Is Absorption
TYPE: STANDARD
CELEBRATION: What Is Absorption complete.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Absorption appears when pressure fails to move price
The candle alone proves the cause
Aggression confirms continuation
Displayed size reveals hidden liquidity
WHY: Absorption appears when pressure fails to move price.

[TIME_SALES] Is pressure moving price?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
No. Execution is strong; progress is weak
Pressure and price accelerate together
No aggressive executions appear
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] What does the evidence support?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: what_is_absorption
CHART: sideways
Absorption appears when pressure fails to move price
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Absorption appears when pressure fails to move price.

NODE 26
TITLE: Buyer Absorption
TYPE: STANDARD
CELEBRATION: Buyer Absorption complete.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Buyers absorb selling near support
The candle alone proves the cause
Aggression confirms continuation
Displayed size reveals hidden liquidity
WHY: Buyers absorb selling near support.

[TIME_SALES] What are sellers failing to do?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Push price below support
Pressure and price accelerate together
No aggressive executions appear
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] Which explanation fits best?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: buyer_absorption
CHART: supportBounce
Buyers absorb selling near support
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Buyers absorb selling near support.

NODE 27
TITLE: Seller Absorption
TYPE: STANDARD
CELEBRATION: Seller Absorption complete.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Sellers absorb buying near resistance
The candle alone proves the cause
Aggression confirms continuation
Displayed size reveals hidden liquidity
WHY: Sellers absorb buying near resistance.

[TIME_SALES] What are buyers failing to do?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Clear the refreshing offer
Pressure and price accelerate together
No aggressive executions appear
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] What's the strongest conclusion?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: seller_absorption
CHART: resistanceRejection
Sellers absorb buying near resistance
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Sellers absorb buying near resistance.

NODE 28
TITLE: Repeated Tests
TYPE: STANDARD
CELEBRATION: Repeated Tests complete.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
A level that survives tests may contain absorption
The candle alone proves the cause
Aggression confirms continuation
Displayed size reveals hidden liquidity
WHY: A level that survives tests may contain absorption.

[TIME_SALES] What keeps happening at the level?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Pressure trades, but the level holds
Pressure and price accelerate together
No aggressive executions appear
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] What best connects the evidence?
VISUAL: Price tests the same support area twice and rebounds after the second test.
SKILL: repeated_tests
CHART: doubleBottom
A level that survives tests may contain absorption
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: A level that survives tests may contain absorption.

NODE 29
TITLE: Hidden Liquidity
TYPE: STANDARD
CELEBRATION: Hidden Liquidity complete.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Refreshing liquidity can hide true available size
The candle alone proves the cause
Aggression confirms continuation
Displayed size reveals hidden liquidity
WHY: Refreshing liquidity can hide true available size.

[ORDERFLOW_SIM] What suggests hidden liquidity?
VISUAL: The Level II ask shows a modest displayed size while buy prints cross the tape. The same ask size returns after every wave of executions and price makes little progress.
SKILL: multi_signal_read
Displayed size keeps replenishing
Pressure and price accelerate together
No aggressive executions appear
WHY: The offer refills after each wave of buying, so displayed size understates true supply.

[EVIDENCE_SELECT] Select two hidden liquidity clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 1, 3
Fast buy executions
Refreshing offer
Positive delta
Stalled price
WHY: Replenishment plus weak price progress are the strongest hidden liquidity clues.

NODE 30
TITLE: What Is Exhaustion
TYPE: STANDARD
CELEBRATION: What Is Exhaustion complete.

[TIME_SALES] What changed in the tape?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Pace and size are fading
Resting depth proves reversal
Execution gains urgency
WHY: Exhaustion is defined by aggressive activity fading.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_interaction
EVENT: stall
TARGET: 6
WHY: Prints continue but size and pace begin fading here.

[FOOTPRINT] Which footprint change would support exhaustion?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Directional execution becomes less dominant near the extreme
One large row guarantees reversal
Displayed orders replace executed volume
WHY: Fading directional execution can support an exhaustion read.

NODE 31
TITLE: Buyer Exhaustion
TYPE: STANDARD
CELEBRATION: Buyer Exhaustion complete.

[TIME_SALES] Which side is losing urgency?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Aggressive buyers
Resting depth proves reversal
Execution gains urgency
WHY: Exhaustion is defined by aggressive activity fading.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_interaction
EVENT: stall
TARGET: 4
WHY: Prints continue but size and pace begin fading here.

[FOOTPRINT] Which footprint change would support exhaustion?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Directional execution becomes less dominant near the extreme
One large row guarantees reversal
Displayed orders replace executed volume
WHY: Fading directional execution can support an exhaustion read.

NODE 32
TITLE: Seller Exhaustion
TYPE: STANDARD
CELEBRATION: Seller Exhaustion complete.

[TIME_SALES] Which side is losing urgency?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Aggressive sellers
Resting depth proves reversal
Execution gains urgency
WHY: Exhaustion is defined by aggressive activity fading.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_interaction
EVENT: stall
TARGET: 2
WHY: Prints continue but size and pace begin fading here.

[FOOTPRINT] Which footprint change would support exhaustion?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Directional execution becomes less dominant near the extreme
One large row guarantees reversal
Displayed orders replace executed volume
WHY: Fading directional execution can support an exhaustion read.

NODE 33
TITLE: Absorption or Exhaustion
TYPE: STANDARD
CELEBRATION: Absorption or Exhaustion complete.

[TIME_SALES] Pressure stays strong, but price stalls. Which is it?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Absorption
Exhaustion
Acceptance
WHY: Absorption keeps strong aggression but loses price progress. Exhaustion means aggression itself fades.

[TIME_SALES] Aggressive pace now fades. Which is it?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Exhaustion
Absorption
Breakout acceptance
WHY: Fading aggression defines exhaustion.

[REPLAY_COMPARE] Which replay shows absorption?
VISUAL: Replay A keeps strong buying against a replenishing offer with stalled price. Replay B shows buying pace itself fading as price stalls.
SKILL: scenario_comparison
Replay A
Replay B
Both show exhaustion
WHY: Replay A keeps strong aggression while price stalls. Replay B shows aggression fading.

NODE 34
TITLE: Seller Absorption Practice Replay
TYPE: PRACTICE_REPLAY
CELEBRATION: Seller Absorption Simulation complete.

[ORDERFLOW_SIM] Buying is aggressive but price cannot clear resistance. What is strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Buyers are active but may be absorbed by refreshing sellers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Aggressive buyers can be absorbed by passive sellers at resistance.

[MC] Which read is best supported?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: seller_absorption_practice_replay
CHART: resistanceRejection
Aggressive buyers can be absorbed by passive sellers at resistance
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Aggressive buyers can be absorbed by passive sellers at resistance.

[ORDER] Build the read.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: market_sequence
CHART: resistanceRejection
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 35
TITLE: Buyer Absorption Practice Replay
TYPE: PRACTICE_REPLAY
CELEBRATION: Buyer Absorption Simulation complete.

[ORDERFLOW_SIM] Selling is aggressive but price cannot break support. What is strongest?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Sellers are active but may be absorbed by refreshing buyers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Aggressive sellers can be absorbed by passive buyers at support.

[MC] What's the most reasonable read?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: buyer_absorption_practice_replay
CHART: supportBounce
Aggressive sellers can be absorbed by passive buyers at support
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Aggressive sellers can be absorbed by passive buyers at support.

[ORDER] Build the read.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: market_sequence
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 36
TITLE: Absorption Review
TYPE: STANDARD
CELEBRATION: Absorption Review complete.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Strong pressure with little movement suggests absorption
The candle alone proves the cause
Aggression confirms continuation
Displayed size reveals hidden liquidity
WHY: Strong pressure with little movement suggests absorption.

[TIME_SALES] Which clue confirms absorption?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Strong pressure with little progress
Pressure and price accelerate together
No aggressive executions appear
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] What's the best read?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
SKILL: absorption_review
CHART: rejectionWickDown
Strong pressure with little movement suggests absorption
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Strong pressure with little movement suggests absorption.

NODE 37
TITLE: Boss Battle: Absorption or Exhaustion?
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Absorption or Exhaustion? complete.

[REPLAY_COMPARE] Which replay shows absorption?
VISUAL: Replay A keeps strong buying against a replenishing offer with stalled price. Replay B shows buying pace itself fading as price stalls.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: Aggression remains strong while price stalls.

[TIME_SALES] What does fading pace suggest?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Exhaustion
Absorption
Acceptance
WHY: Exhaustion means aggression itself fades.

[ORDERFLOW_SIM] What's the strongest read?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Possible buyer absorption
Seller continuation confirmed
No selling occurred
WHY: Selling remains active while support holds.

[ORDERFLOW_SIM] What's the strongest read?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Possible seller absorption
Buyer continuation confirmed
No buying occurred
WHY: Buying remains active while resistance holds.

[TIME_SALES] Which side loses urgency?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
The aggressive side
The passive side
Neither side
WHY: Exhaustion appears as initiating activity fades.

[EVIDENCE_SELECT] Select seller absorption clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Refreshing offer
Stalled price
Fading buy pace
Price accepts higher
WHY: Replenishment and stalled response support absorption.

[ORDERFLOW_SIM] Is a clear read confirmed?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
Not enough evidence
Buyer absorption
Seller exhaustion
WHY: Conflicting evidence does not confirm either interpretation.


UNIT 5 — Imbalances and Momentum
TIER: Advanced

NODE 38
TITLE: Reading a Footprint Chart
TYPE: STANDARD
CELEBRATION: Reading a Footprint Chart complete.

[FOOTPRINT] What does the bid and ask split inside each row represent?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Executed selling at the bid and buying at the ask
Resting limit orders waiting at each price
Total candle volume without side separation
WHY: A footprint separates executed bid volume from executed ask volume at each price.

[FOOTPRINT_TAP] Tap the row with most executed volume.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
SKILL: footprint_interaction
EVENT: total_target
TARGET: 1
WHY: This row has the largest bid plus ask total.

[MC] Which explanation fits best?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: reading_a_footprint_chart
CHART: sideways
A footprint shows executed volume at each price
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: A footprint shows executed volume at each price.

[MATCH] Match each clue.
SKILL: reading_a_footprint_chart
Reading a Footprint Chart => Bid and ask volume by price
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

NODE 39
TITLE: Footprint Imbalances
TYPE: STANDARD
CELEBRATION: Footprint Imbalances complete.

[FOOTPRINT] How is an ask imbalance measured?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Compare diagonal bid and ask volume by ratio
Use the largest same row difference
Compare ask depth with bid executions
WHY: Diagonal comparison and a defined ratio distinguish conventional imbalance from a simple same price execution difference.

[FOOTPRINT_TAP] Tap the first diagonal ask imbalance.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing ask volume at the target price exceeding bid volume at the diagonally adjacent lower price by a clear ratio.
SKILL: footprint_interaction
EVENT: diagonal_ask
TARGET: 4
WHY: Ask execution exceeds the adjacent lower bid by ratio.

[MC] How should the imbalance be measured?
SKILL: footprint_imbalances
Compare diagonal bid and ask volume by ratio
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Diagonal bid and ask volume compared by ratio defines the imbalance.

[MATCH] Match each clue.
SKILL: footprint_imbalances
Footprint Imbalances => Diagonal volume ratios at neighboring prices
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

NODE 40
TITLE: Order Imbalance
TYPE: STANDARD
CELEBRATION: Order Imbalance complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Imbalance means one side is more aggressive
The largest total row proves directional delta
The bid ask split represents resting limit orders
One same price difference confirms a stacked diagonal imbalance
WHY: Imbalance means one side is more aggressive.

[FOOTPRINT_TAP] Tap the strongest execution imbalance.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_interaction
EVENT: lift
TARGET: 1
WHY: This row has the widest directional execution advantage.

[MC] What best connects the evidence?
SKILL: order_imbalance
Imbalance means one side is more aggressive
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Imbalance means one side is more aggressive.

NODE 41
TITLE: Buyer Imbalance
TYPE: STANDARD
CELEBRATION: Buyer Imbalance complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Buyer imbalance can push price higher
Positive candle delta guarantees price acceptance
A quiet row invalidates aggression elsewhere
Absolute volume matters more than price response
WHY: Buyer imbalance can push price higher.

[FOOTPRINT_TAP] Tap the strongest ask side advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_interaction
EVENT: lift
TARGET: 4
WHY: Aggressive buyers execute at the ask.

[MC] Which read needs fewer assumptions?
SKILL: buyer_imbalance
Buyer imbalance can push price higher
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Buyer imbalance can push price higher.

[ORDER] Build the read.
SKILL: market_sequence
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 42
TITLE: Seller Imbalance
TYPE: STANDARD
CELEBRATION: Seller Imbalance complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Seller imbalance can push price lower
The brightest cell identifies the next candle direction
A same row advantage and diagonal imbalance are identical
Displayed depth can be inferred directly from executed volume
WHY: Seller imbalance can push price lower.

[FOOTPRINT_TAP] Tap the strongest bid side advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_interaction
EVENT: hit
TARGET: 1
WHY: Aggressive sellers execute at the bid.

[MC] What matters most here?
SKILL: seller_imbalance
Seller imbalance can push price lower
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Seller imbalance can push price lower.

NODE 43
TITLE: Momentum Ignition
TYPE: STANDARD
CELEBRATION: Momentum Ignition complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Sudden aggression can ignite momentum
Several ask heavy rows prove sellers withdrew
High total volume must contain directional delta
One footprint candle is enough to ignore location
WHY: Sudden aggression can ignite momentum.

[FOOTPRINT_TAP] Tap the row where buyer pressure concentrates.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_interaction
EVENT: lift
TARGET: 4
WHY: Concentrated ask executions can help ignite momentum.

[MC] Which conclusion fits the response?
SKILL: momentum_ignition
Sudden aggression can ignite momentum
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: Sudden aggression can ignite momentum.

[ORDER] Build the read.
SKILL: market_sequence
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 44
TITLE: Momentum Continuation
TYPE: STANDARD
CELEBRATION: Momentum Continuation complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Renewed buying can continue momentum
The largest total row proves directional delta
The bid ask split represents resting limit orders
One same price difference confirms a stacked diagonal imbalance
WHY: Renewed buying can continue momentum.

[FOOTPRINT_TAP] Tap the first stacked ask imbalance.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing three consecutive rows showing ask side execution imbalances.
SKILL: footprint_interaction
EVENT: stacked_ask
TARGET: 1
WHY: Consecutive ask imbalances support continued buyer pressure.

[MC] How should this be interpreted?
SKILL: momentum_continuation
Renewed buying can continue momentum
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Renewed buying can continue momentum.

NODE 45
TITLE: Momentum Failure
TYPE: STANDARD
CELEBRATION: Momentum Failure complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Momentum weakens when price stops responding
Positive candle delta guarantees price acceptance
A quiet row invalidates aggression elsewhere
Absolute volume matters more than price response
WHY: Momentum weakens when price stops responding.

[FOOTPRINT_TAP] Tap where directional pressure disappears.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
SKILL: footprint_interaction
EVENT: balanced_target
TARGET: 4
WHY: Execution becomes balanced as momentum loses force.

[MC] What does the response suggest?
SKILL: momentum_failure
Momentum weakens when price stops responding
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Momentum weakens when price stops responding.

[ORDER] Build the read.
SKILL: market_sequence
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 46
TITLE: Stacked Pressure
TYPE: STANDARD
CELEBRATION: Stacked Pressure complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Pressure across several levels strengthens the move
The brightest cell identifies the next candle direction
A same row advantage and diagonal imbalance are identical
Displayed depth can be inferred directly from executed volume
WHY: Pressure across several levels strengthens the move.

[FOOTPRINT_TAP] Tap the first row in the stack.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing three consecutive rows showing ask side execution imbalances.
SKILL: footprint_interaction
EVENT: stacked_ask
TARGET: 1
WHY: The selected row begins consecutive ask side imbalances.

[MC] Which read is best supported?
SKILL: stacked_pressure
Pressure across several levels strengthens the move
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Pressure across several levels strengthens the move.

NODE 47
TITLE: Delta Thinking
TYPE: STANDARD
CELEBRATION: Delta Thinking complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Net aggression compares buying with selling
Several ask heavy rows prove sellers withdrew
High total volume must contain directional delta
One footprint candle is enough to ignore location
WHY: Net aggression compares buying with selling.

[FOOTPRINT_TAP] Tap the row adding most positive delta.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest positive ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_positive
TARGET: 4
WHY: This row contributes the largest ask minus bid volume.

[MC] What's the most reasonable read?
SKILL: delta_thinking
Net aggression compares buying with selling
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Net aggression compares buying with selling.

[ORDER] Build the read.
SKILL: market_sequence
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 48
TITLE: Delta vs Volume
TYPE: STANDARD
CELEBRATION: Delta vs Volume complete.

[FOOTPRINT] Price and delta disagree. Why?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Volume is total activity. Delta is net aggression
Delta determines the next price
Volume and delta are identical
The disagreement cancels both readings
WHY: Volume measures total trading while delta compares aggressive buying and selling.

[MC] What's the best read?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: delta_vs_volume
CHART: volatile
Volume is total activity. Delta is net aggression
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Volume measures total trading while delta compares aggressive buying and selling.

[FOOTPRINT_TAP] Tap the highest volume row.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
SKILL: footprint_interaction
EVENT: total_target
TARGET: 1
WHY: Total volume adds bid and ask executions, unlike delta.

[ORDER] Build the read.
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: market_sequence
CHART: volatile
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 49
TITLE: Positive Delta While Price Falls
TYPE: STANDARD
CELEBRATION: Positive Delta While Price Falls complete.

[FOOTPRINT] Price and delta disagree. Why?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Possible seller absorption or trapped buyers
Delta determines the next price
Volume and delta are identical
The disagreement cancels both readings
WHY: Positive delta with falling price can reveal seller absorption or trapped buyers.

[MC] What does the evidence support?
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
SKILL: positive_delta_while_price_falls
CHART: bearishEngulfing
Possible seller absorption or trapped buyers
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Positive delta with falling price can reveal seller absorption or trapped buyers.

[FOOTPRINT_TAP] Tap the row contradicting falling price.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest positive ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_positive
TARGET: 4
WHY: Strong positive delta conflicts with the downward price response.

[ORDER] Build the read.
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
SKILL: market_sequence
CHART: bearishEngulfing
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 50
TITLE: Negative Delta While Price Rises
TYPE: STANDARD
CELEBRATION: Negative Delta While Price Rises complete.

[FOOTPRINT] Price and delta disagree. Why?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Possible buyer absorption or trapped sellers
Delta determines the next price
Volume and delta are identical
The disagreement cancels both readings
WHY: Negative delta with rising price can reveal buyer absorption or trapped sellers.

[MC] Which explanation fits best?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
SKILL: negative_delta_while_price_rises
CHART: bullishEngulfing
Possible buyer absorption or trapped sellers
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Negative delta with rising price can reveal buyer absorption or trapped sellers.

[FOOTPRINT_TAP] Tap the row contradicting rising price.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest negative ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_negative
TARGET: 1
WHY: Strong negative delta conflicts with the upward price response.

[ORDER] Build the read.
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
SKILL: market_sequence
CHART: bullishEngulfing
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 51
TITLE: Price and Pressure Divergence
TYPE: STANDARD
CELEBRATION: Price and Pressure Divergence complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Price and pressure disagreement warns of weakness
Several ask heavy rows prove sellers withdrew
High total volume must contain directional delta
One footprint candle is enough to ignore location
WHY: Price and pressure disagreement warns of weakness.

[FOOTPRINT_TAP] Tap the execution clue opposing price.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest negative ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_negative
TARGET: 4
WHY: The selected negative delta row contradicts the price direction.

[MC] What's the strongest conclusion?
SKILL: price_and_pressure_divergence
Price and pressure disagreement warns of weakness
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Price and pressure disagreement warns of weakness.

[ORDER] Build the read.
SKILL: market_sequence
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 52
TITLE: Boss Battle: Footprint & Momentum
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Footprint & Momentum complete.

[FOOTPRINT] What does each row show?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Bid and ask executions by price
Only resting orders
Only candle volume
WHY: Footprints split executed volume at each price.

[FOOTPRINT_TAP] Tap the diagonal ask imbalance.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing ask volume at the target price exceeding bid volume at the diagonally adjacent lower price by a clear ratio.
SKILL: footprint_interaction
EVENT: diagonal_ask
TARGET: 2
WHY: Ask volume exceeds the adjacent lower bid by ratio.

[FOOTPRINT_TAP] Tap the strongest ask advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_interaction
EVENT: lift
TARGET: 4
WHY: This row has the strongest aggressive buying.

[FOOTPRINT_TAP] Tap the strongest bid advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_interaction
EVENT: hit
TARGET: 1
WHY: This row has the strongest aggressive selling.

[FOOTPRINT_TAP] Tap where stacked pressure begins.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing three consecutive rows showing ask side execution imbalances.
SKILL: footprint_interaction
EVENT: stacked_ask
TARGET: 2
WHY: Three consecutive ask imbalances start here.

[MC] How do volume and delta differ?
SKILL: boss_footprint_momentum
Volume totals trades; delta nets aggression
They are identical
Delta shows resting depth
WHY: Delta compares ask and bid executions.

[ORDERFLOW_SIM] Positive delta, falling price. Why?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Possible seller absorption
Buyer control is confirmed
Delta is invalid
WHY: Buying can be absorbed despite positive delta.

[ORDERFLOW_SIM] Is momentum confirmed?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
No. Price and pressure diverge
Yes. Delta is enough
Yes. Volume is high
WHY: Conflicting response warns of momentum failure.


UNIT 6 — Liquidity and Sweeps
TIER: Advanced

NODE 53
TITLE: Liquidity Pools
TYPE: STANDARD
CELEBRATION: Liquidity Pools complete.

[BOOK_COMPARE] Which book holds the larger liquidity pool?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book A, with thick clustered depth
Book B, with gaps and thin depth
Both show equal liquidity
WHY: Nearby depth changes how much pressure price needs to travel.

[MC] Which read needs fewer assumptions?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
SKILL: liquidity_pools
CHART: range
Liquidity often gathers near obvious levels
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Liquidity often gathers near obvious levels.

[MATCH] Match each clue.
SKILL: liquidity_pools
Liquidity Pools => Clustered orders
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

NODE 54
TITLE: Resting Stops
TYPE: STANDARD
CELEBRATION: Resting Stops complete.

[EVIDENCE_SELECT] Select the clues suggesting a stop cluster.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Obvious swing level nearby
Price accelerating as it breaks
A distant doji
Average daily volume
WHY: Stops cluster beyond obvious levels and fire as a burst of execution when the level breaks.

[MC] What matters most here?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: resting_stops
CHART: supportBounce
Beyond obvious highs, lows, and levels
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Traders often infer that stops may cluster beyond obvious support resistance highs and lows.

[MARK_LEVEL] Mark the support hiding inferred sell stops.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: liquidity_location
CHART: supportBounce
WHY: Stops are inferred beyond obvious levels rather than directly visible before triggering.

NODE 55
TITLE: Buy Stops
TYPE: STANDARD
CELEBRATION: Buy Stops complete.

[MARK_LEVEL] Mark where buy stops may cluster.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
SKILL: liquidity_location
CHART: breakout
WHY: Buy stops may cluster beyond obvious resistance or prior highs.

[EVIDENCE_SELECT] Select the clues pointing to buy stops overhead.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Resistance rejected several times
Sudden buying as the level breaks
Falling volume all session
Candle color
WHY: Buy stops build above repeatedly defended resistance and trigger as it breaks.

[MATCH] Match each clue.
SKILL: buy_stops
Buy Stops => Stops above resistance
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles. The candles are tappable and the learner must select the requested candle.
SKILL: buy_stops
CHART: breakout
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

NODE 56
TITLE: Sell Stops
TYPE: STANDARD
CELEBRATION: Sell Stops complete.

[MC] How should this be interpreted?
VISUAL: Price drives below a visible support level with expanding bearish candles.
SKILL: sell_stops
CHART: breakdown
Sell stops can fuel a downside break
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Sell stops can fuel a downside break.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price drives below a visible support level with expanding bearish candles. The candles are tappable and the learner must select the requested candle.
SKILL: sell_stops
CHART: breakdown
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[MARK_LEVEL] Mark the level sell stops may sit below.
VISUAL: Price drives below a visible support level with expanding bearish candles.
SKILL: liquidity_location
CHART: breakdown
WHY: Stops are inferred beyond obvious levels rather than directly visible before triggering.

NODE 57
TITLE: Liquidity Sweep
TYPE: STANDARD
CELEBRATION: Liquidity Sweep complete.

[EVIDENCE_SELECT] Select the clues showing liquidity was taken and rejected.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
A fast push through the level
Immediate return back inside
Steady two-sided trade
News headline timing
WHY: A sweep takes the liquidity beyond a level, then price snaps back inside.

[MATCH] Match each clue.
SKILL: liquidity_sweep
Liquidity Sweep => Quick level breach
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] What does the response suggest?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
SKILL: liquidity_sweep
CHART: rejectionWickDown
A sweep takes liquidity then returns
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: A sweep takes liquidity then returns.

NODE 58
TITLE: Upside Sweep
TYPE: STANDARD
CELEBRATION: Upside Sweep complete.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick. The candles are tappable and the learner must select the requested candle.
SKILL: upside_sweep
CHART: rejectionWickUp
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

[EVIDENCE_SELECT] Select the clues of an upside sweep.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Offers clear in one burst
Buying dies right after the break
A slow grinding uptrend
A gap from yesterday
WHY: An upside sweep bursts through offers, then aggression vanishes instead of following through.

[MC] Which read is best supported?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: upside_sweep
CHART: rejectionWickUp
An upside sweep can trap late buyers
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: An upside sweep can trap late buyers.

[ORDER] Build the read.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: market_sequence
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 59
TITLE: Downside Sweep
TYPE: STANDARD
CELEBRATION: Downside Sweep complete.

[TAP_CANDLE] Tap the rejection after the sweep.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick. The candles are tappable and the learner must select the requested candle.
SKILL: downside_sweep
CHART: rejectionWickDown
TARGET: 4
WHY: Price response distinguishes rejection from acceptance.

[MC] What's the most reasonable read?
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
SKILL: downside_sweep
CHART: hammer
A downside sweep can trap late sellers
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: A downside sweep can trap late sellers.

[MATCH] Match each clue.
SKILL: downside_sweep
Downside Sweep => Failed push below
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

NODE 60
TITLE: Sweep or Breakout
TYPE: STANDARD
CELEBRATION: Sweep or Breakout complete.

[EVIDENCE_SELECT] Select the clues that separate a sweep from a breakout.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Whether execution persists beyond the level
Whether price holds or returns inside
The size of one candle
The time of day
WHY: Persistent execution and price holding beyond the level separate acceptance from a sweep.

[REPLAY_COMPARE] Which replay gains acceptance?
VISUAL: Replay A trades through a level and rejects immediately without acceptance. Replay B trades through with persistent execution and holds beyond the level.
SKILL: scenario_comparison
Replay B
Replay A
Both replays
WHY: Replay B holds beyond the level. Replay A rejects immediately.

[MC] Which comparison best separates these two ideas?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: sweep_or_breakout
CHART: breakoutRetest
Sweeps reject the level. Breakouts gain acceptance.
A sweep always has slower tape than a breakout
Any trade beyond the level confirms a breakout
WHY: Sweeps reject the level. Breakouts gain acceptance.

NODE 61
TITLE: Liquidity Sweep Rejection Practice Replay
TYPE: PRACTICE_REPLAY
CELEBRATION: Liquidity Sweep Rejection Simulation complete.

[ORDERFLOW_SIM] Price trades beyond the level and immediately returns. What is strongest?
VISUAL: Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.
SKILL: multi_signal_read
Liquidity was taken but acceptance failed
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: A sweep takes liquidity but fails to gain acceptance.

[MC] What does the evidence support?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: liquidity_sweep_rejection_practice_replay
CHART: rejectionWickUp
A sweep takes liquidity but fails to gain acceptance
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: A sweep takes liquidity but fails to gain acceptance.

[ORDER] Build the read.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: market_sequence
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 62
TITLE: Thin Liquidity
TYPE: STANDARD
CELEBRATION: Thin Liquidity complete.

[MC] Which explanation fits best?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
SKILL: thin_liquidity
CHART: gapUp
Thin liquidity lets price travel quickly
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Thin liquidity lets price travel quickly.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price opens well above the prior trading area with little activity between the two zones. The candles are tappable and the learner must select the requested candle.
SKILL: thin_liquidity
CHART: gapUp
TARGET: 2
WHY: The selected candle shows whether execution produced follow through.

[BOOK_COMPARE] Which book should move more easily?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B, because depth is thin
Book A, because depth is thick
Both should move equally
WHY: Nearby depth changes how much pressure price needs to travel.

NODE 63
TITLE: Thick Book vs Thin Book
TYPE: STANDARD
CELEBRATION: Thick Book vs Thin Book complete.

[BOOK_COMPARE] Which book should move more easily?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B, because depth is thin
Book A, because depth is thick
Both should move equally
WHY: Thin nearby depth and gaps can let price travel with less incoming pressure.

[MC] What does thick depth change?
SKILL: thick_book_vs_thin_book
More liquidity must trade or withdraw
Price is guaranteed to reverse
Aggressors can ignore nearby size
WHY: Thick displayed depth can slow travel, but it may still trade or be pulled.

[MC] Which comparison best separates these two ideas?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: thick_book_vs_thin_book
CHART: volatile
Thick books resist travel. Thin books allow easier travel.
A thick book guarantees reversal
A thin book proves aggressive buyers are present
WHY: Thick books resist travel. Thin books allow easier travel.

NODE 64
TITLE: Iceberg Orders
TYPE: STANDARD
CELEBRATION: Iceberg Orders complete.

[ORDERFLOW_SIM] The offer keeps refilling after buy prints. Why?
VISUAL: The Level II offer shows the same displayed size returning after repeated buy executions on the animated tape.
SKILL: iceberg_orders
A possible sell iceberg is replenishing hidden size
Buyers have already secured a breakout
The refills are canceled orders reappearing
Displayed size cannot change after a fill
WHY: Repeated execution against refreshing displayed size is consistent with an iceberg.

[EVIDENCE_SELECT] Select the clues suggesting replenishing hidden size.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Displayed size refills after fills
Repeated execution at one price
A distant resting wall
Positive delta alone
WHY: An iceberg shows repeated fills at one price while displayed size keeps refilling.

[MC] What best connects the evidence?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: iceberg_orders
CHART: sideways
An iceberg can replenish displayed size while absorbing repeated trades
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: An iceberg can replenish displayed size while absorbing repeated trades.

[TIME_SALES_TAP] In iceberg orders, tap the most informative print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_interaction
EVENT: large_print
TARGET: 1
WHY: The selected execution carries the key tape evidence.

NODE 65
TITLE: Liquidity Review
TYPE: STANDARD
CELEBRATION: Liquidity Review complete.

[EVIDENCE_SELECT] Select the two essential clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Event location
Price response
Candle color alone
One isolated print
WHY: A complete read separates aggression, liquidity, and price response.

[MC] Which read needs fewer assumptions?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: liquidity_review
CHART: volatile
Judge liquidity events by location and response
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Judge liquidity events by location and response.

[MATCH] Match each clue.
SKILL: liquidity_review
Liquidity Review => Location and response
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

NODE 66
TITLE: Boss Battle: Sweep or Acceptance?
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Sweep or Acceptance? complete.

[MARK_LEVEL] Mark inferred buy stops.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
SKILL: liquidity_location
CHART: breakout
WHY: Buy stops may cluster beyond resistance.

[MARK_LEVEL] Mark inferred sell stops.
VISUAL: Price drives below a visible support level with expanding bearish candles.
SKILL: liquidity_location
CHART: breakdown
WHY: Sell stops may cluster beyond support.

[REPLAY_COMPARE] Which replay gains acceptance?
VISUAL: Replay A trades through a level and rejects immediately without acceptance. Replay B trades through with persistent execution and holds beyond the level.
SKILL: scenario_comparison
Replay B
Replay A
Both
WHY: Replay B holds beyond the level.

[MC] What does the rejection suggest?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: boss_sweep_or_acceptance
CHART: rejectionWickUp
Possible upside sweep
Accepted breakout
Guaranteed reversal
WHY: Price trades above and returns inside.

[MC] What does this rejection suggest?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
SKILL: boss_sweep_or_acceptance
CHART: rejectionWickDown
Possible downside sweep
Accepted breakdown
No liquidity traded
WHY: Price trades below and returns inside.

[BOOK_COMPARE] Which book should move faster?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B
Book A
Both equally
WHY: Thin depth lets price travel more easily.

[TIME_SALES] The offer keeps refilling. Why?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Possible iceberg
Buyer exhaustion
Spread collapse
WHY: Repeated replenishment can indicate hidden size.

[ORDERFLOW_SIM] What's the strongest read?
VISUAL: Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.
SKILL: multi_signal_read
Liquidity taken; acceptance failed
Breakout confirmed
No stops triggered
WHY: The breach rejects instead of holding.


UNIT 7 — Breakouts and Failures
TIER: Advanced

NODE 67
TITLE: Breakout Pressure
TYPE: STANDARD
CELEBRATION: Breakout Pressure complete.

[REPLAY_COMPARE] Which replay confirms a breakout?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[EVIDENCE_SELECT] Select the two acceptance clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Persistent execution
Price holds beyond the level
Immediate return inside
One isolated print
WHY: Advanced reads combine at least two aligned evidence sources.

[MATCH] Match each clue.
SKILL: breakout_pressure
Breakout Pressure => Offers consumed withdrawn or thin
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles. The candles are tappable and the learner must select the requested candle.
SKILL: breakout_pressure
CHART: breakout
TARGET: 2
WHY: The selected candle shows whether execution produced follow through.

NODE 68
TITLE: Breakdown Pressure
TYPE: STANDARD
CELEBRATION: Breakdown Pressure complete.

[MC] How should this be interpreted?
VISUAL: Price drives below a visible support level with expanding bearish candles.
SKILL: breakdown_pressure
CHART: breakdown
Bids are consumed, withdrawn, or both
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: A downside break can develop as sellers consume bids buyers withdraw liquidity or both.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price drives below a visible support level with expanding bearish candles. The candles are tappable and the learner must select the requested candle.
SKILL: breakdown_pressure
CHART: breakdown
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

[ORDER] Build the decision sequence.
SKILL: market_sequence
Sellers hit bids
Bids trade or withdraw
Price moves below support
Acceptance is tested
WHY: Order flow decisions move from evidence to response and risk.

NODE 69
TITLE: Acceptance Above
TYPE: STANDARD
CELEBRATION: Acceptance Above complete.

[EVIDENCE_SELECT] Select the two acceptance clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution persists
Price holds beyond the level
Price returns inside
Liquidity replenishes against the move
WHY: An advanced breakout read requires both pressure and acceptance.

[LIVE_CHART] Which price behavior supports the read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
SKILL: acceptance_above
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Match each clue.
SKILL: acceptance_above
Acceptance Above => Price holding above
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] What does the response suggest?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: acceptance_above
CHART: breakoutRetest
Holding above a level shows acceptance
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Holding above a level shows acceptance.

NODE 70
TITLE: Acceptance Below
TYPE: STANDARD
CELEBRATION: Acceptance Below complete.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price breaks support, returns to test it from below, then reacts lower. The candles are tappable and the learner must select the requested candle.
SKILL: acceptance_below
CHART: breakdownRetest
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

[EVIDENCE_SELECT] Select the clues confirming acceptance below support.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Selling continues after the break
Price stays below the old support
Price returns back above quickly
Bids replenish against the move
WHY: Acceptance below needs persistent selling and price holding under the broken level.

[MC] Which read is best supported?
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
SKILL: acceptance_below
CHART: breakdownRetest
Holding below a level shows acceptance
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Holding below a level shows acceptance.

[ORDER] Build the read.
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
SKILL: market_sequence
CHART: breakdownRetest
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 71
TITLE: Breakout Acceptance Practice Replay
TYPE: PRACTICE_REPLAY
CELEBRATION: Breakout Acceptance Simulation complete.

[ORDERFLOW_SIM] Offers are consumed and price holds beyond resistance. What is strongest?
VISUAL: Price approaches resistance, offers thin and are consumed, buyer initiated prints persist, stacked ask side execution appears, and price holds above the broken level.
SKILL: multi_signal_read
Aggression is receiving confirming price acceptance
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: A real breakout combines pressure with sustained trade beyond the level.

[MC] What's the most reasonable read?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: breakout_acceptance_practice_replay
CHART: breakoutRetest
Pressure is confirmed by acceptance above
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: A real breakout combines pressure with sustained trade beyond the level.

[ORDER] Build the read.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: market_sequence
CHART: breakoutRetest
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 72
TITLE: Failed Breakout
TYPE: STANDARD
CELEBRATION: Failed Breakout complete.

[REPLAY_COMPARE] Which replay traps breakout buyers?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay B
Replay A
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[LIVE_CHART] What changed in price response?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
SKILL: failed_breakout
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MC] What's the best read?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: failed_breakout
CHART: resistanceRejection
A quick return below resistance signals failure
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: A quick return below resistance signals failure.

[TAP_CANDLE] Tap where the breakout fails.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The candles are tappable and the learner must select the requested candle.
SKILL: failed_breakout
CHART: resistanceRejection
TARGET: 3
WHY: Price response distinguishes rejection from acceptance.

NODE 73
TITLE: Failed Breakdown
TYPE: STANDARD
CELEBRATION: Failed Breakdown complete.

[MC] What does the evidence support?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: failed_breakdown
CHART: supportBounce
A quick return above support signals failure
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: A quick return above support signals failure.

[EVIDENCE_SELECT] Select the clues that the breakdown failed.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Price returns above the broken level
Selling pressure dries up
Execution persists lower
Price holds below support
WHY: A failed breakdown recovers the level while the selling that caused it disappears.

[MATCH] Match each clue.
SKILL: failed_breakdown
Failed Breakdown => Return above support
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area. The candles are tappable and the learner must select the requested candle.
SKILL: failed_breakdown
CHART: supportBounce
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

NODE 74
TITLE: Breakout Retest
TYPE: STANDARD
CELEBRATION: Breakout Retest complete.

[REPLAY_COMPARE] Which replay shows a defended break?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
SKILL: breakout_retest
CHART: breakoutRetest
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

[TAP_CANDLE] Tap the defended retest.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
SKILL: breakout_retest
CHART: breakoutRetest
TARGET: 2
WHY: Price response distinguishes rejection from acceptance.

NODE 75
TITLE: Breakdown Retest
TYPE: STANDARD
CELEBRATION: Breakdown Retest complete.

[EVIDENCE_SELECT] Select the clues that the retest confirms the breakdown.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
The old support rejects price from below
Selling resumes at the retest
Buying persists back above the level
The first test is repeated exactly
WHY: A confirming retest is rejected at the old support and selling resumes from it.

[LIVE_CHART] What does the developing response support?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
SKILL: breakdown_retest
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Match each clue.
SKILL: breakdown_retest
Breakdown Retest => Resistance on retest
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[MC] What's the strongest conclusion?
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
SKILL: breakdown_retest
CHART: breakdownRetest
A rejected retest can confirm a breakdown
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: A rejected retest can confirm a breakdown.

NODE 76
TITLE: Chasing Breakouts
TYPE: STANDARD
CELEBRATION: Chasing Breakouts complete.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price opens well above the prior trading area with little activity between the two zones. The candles are tappable and the learner must select the requested candle.
SKILL: chasing_breakouts
CHART: gapUp
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[EVIDENCE_SELECT] Select the warning clues against chasing the breakout.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Price is far extended past the level
Aggression is already fading
Execution persists beyond the level
Price holds above on a retest
WHY: Chasing risk rises when price is extended and aggression fades. The other two clues are genuine acceptance.

[MC] What best connects the evidence?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
SKILL: chasing_breakouts
CHART: gapUp
Late entries carry worse risk and reward
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Late entries carry worse risk and reward.

[ORDER] Build the read.
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
SKILL: market_sequence
CHART: gapUp
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 77
TITLE: Common Order Flow Misconceptions
TYPE: STANDARD
CELEBRATION: Common Order Flow Misconceptions complete.

[TF] A large visible wall guarantees a reversal.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: common_order_flow_misconceptions
CHART: resistanceRejection
ANSWER: False
WHY: Walls can trade pull or fail.

[TF] Fast tape guarantees a breakout.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
SKILL: common_order_flow_misconceptions
CHART: breakout
ANSWER: False
WHY: Speed needs acceptance and follow through.

[MC] Positive delta appears but price cannot rise. What is the best explanation?
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
SKILL: common_order_flow_misconceptions
CHART: shootingStar
Buying may be absorbed by passive sellers
Positive delta guarantees delayed upside
The chart invalidates all tape data
WHY: Aggressive buying without progress can reveal seller absorption.

[TIME_SALES] Buying prints remain active but price response stalls. Which warning is present?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Aggression is not producing follow through
The breakout is guaranteed after a delay
Resting liquidity no longer matters
WHY: Active prints are not enough when price stops responding.

[ORDER] Build the read.
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
SKILL: market_sequence
CHART: shootingStar
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 78
TITLE: Boss Battle: Breakout or Failure?
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Breakout or Failure? complete.

[REPLAY_COMPARE] Which replay shows acceptance?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: Replay A holds beyond resistance.

[REPLAY_COMPARE] Which replay traps buyers?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay B
Replay A
Neither
WHY: Replay B falls back inside.

[MC] What supports a breakdown?
VISUAL: Price drives below a visible support level with expanding bearish candles.
SKILL: boss_breakout_or_failure
CHART: breakdown
Persistent selling and acceptance
One red candle
A large distant offer
WHY: Pressure must produce trade below support.

[EVIDENCE_SELECT] Select acceptance clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Persistent execution
Price holds beyond
Immediate return inside
Refreshing opposition
WHY: Execution and holding response support acceptance.

[MC] What invalidates the breakout?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: boss_breakout_or_failure
CHART: resistanceRejection
Price returns below resistance
Tape stays fast
Delta stays positive
WHY: Returning inside shows failed acceptance.

[MC] What invalidates the breakdown?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: boss_breakout_or_failure
CHART: supportBounce
Price returns above support
Tape stays fast
Delta stays negative
WHY: Returning inside shows failed acceptance.

[MC] Why wait for a retest?
SKILL: boss_breakout_or_failure
To observe continued acceptance
To confirm aggression remains one-sided
To prove the breakout candle had high volume
WHY: A retest shows whether the level still holds. One-sided aggression earlier or breakout volume does not prove acceptance now.

[ORDERFLOW_SIM] What's the strongest read?
VISUAL: Price approaches resistance, offers thin and are consumed, buyer initiated prints persist, stacked ask side execution appears, and price holds above the broken level.
SKILL: multi_signal_read
Accepted breakout
Liquidity sweep
Not enough trading
WHY: Pressure persists and price holds beyond.


UNIT 8 — Pullbacks and Continuation
TIER: Advanced

NODE 79
TITLE: Healthy Pullbacks
TYPE: STANDARD
CELEBRATION: Healthy Pullbacks complete.

[EVIDENCE_SELECT] Select the two strongest clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Shallow pullback
Trend pressure returns
Counter pressure accelerates
Key level fails
WHY: Advanced continuation requires structure plus confirming execution evidence.

[EVIDENCE_SELECT] Select the two continuation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Structure remains intact
Trend pressure returns
Counter pressure accelerates
The key level fails
WHY: Advanced reads combine at least two aligned evidence sources.

[MATCH] Match each clue.
SKILL: healthy_pullbacks
Healthy Pullbacks => Lighter selling
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: An established rise pauses with smaller bearish candles before testing trend continuation. The learner draws directly between two candles to mark the structure.
SKILL: healthy_pullbacks
CHART: pullbackUptrend
TARGET: 2 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

NODE 80
TITLE: Pullback Depth
TYPE: STANDARD
CELEBRATION: Pullback Depth complete.

[MC] How should this be interpreted?
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
SKILL: pullback_depth
CHART: ascendingChannel
Shallow defended pullbacks show trend strength
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Shallow defended pullbacks show trend strength.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary. The learner draws directly between two candles to mark the structure.
SKILL: pullback_depth
CHART: ascendingChannel
TARGET: 0 => 3
WHY: Structure supplies location. Execution evidence supplies the read.

[FOOTPRINT_TAP] Tap the most balanced execution row.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
SKILL: footprint_interaction
EVENT: balanced_target
TARGET: 3
WHY: The selected row contains the requested execution profile.

NODE 81
TITLE: Seller Pullback
TYPE: STANDARD
CELEBRATION: Seller Pullback complete.

[EVIDENCE_SELECT] Select the clues the downtrend should continue.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Bearish structure stays intact
Selling returns after the bounce
Buyers accept above the last lower high
Delta turns strongly positive
WHY: Continuation lower needs intact structure and returning sell pressure.

[LIVE_CHART] Which price behavior supports the read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
SKILL: seller_pullback
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Match each clue.
SKILL: seller_pullback
Seller Pullback => Lighter buying
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] What does the response suggest?
VISUAL: Each rebound ends below the previous high while price continues making lower lows.
SKILL: seller_pullback
CHART: lowerHighsDowntrend
A bearish pullback shows weaker buying
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: A bearish pullback shows weaker buying.

NODE 82
TITLE: Continuation Trigger
TYPE: STANDARD
CELEBRATION: Continuation Trigger complete.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
SKILL: continuation_trigger
CHART: bullFlag
TARGET: 0 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[EVIDENCE_SELECT] Select the clues that arm a continuation trigger.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
The pullback stalls at a defended level
Trend-side aggression resumes
Counter pressure keeps accelerating
The key level gives way
WHY: A trigger arms when the pullback stalls at defense and trend-side aggression resumes.

[MC] Which read is best supported?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
SKILL: continuation_trigger
CHART: bullFlag
Continuation begins when trend pressure returns
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Continuation begins when trend pressure returns.

[ORDER] Build the read.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
SKILL: market_sequence
CHART: bullFlag
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 83
TITLE: Bearish Continuation
TYPE: STANDARD
CELEBRATION: Bearish Continuation complete.

[TIME_SALES] Which tape clue supports continuation?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Seller prints regain persistence
Buy prints accelerate at support
Trade pace becomes balanced
WHY: Use completed executions to judge whether trend pressure returned.

[MC] What's the most reasonable read?
VISUAL: A sharp decline pauses in a small upward sloping channel before sellers test control again.
SKILL: bearish_continuation
CHART: bearFlag
Bearish continuation begins when sellers return
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Bearish continuation begins when sellers return.

[MATCH] Match each clue.
SKILL: bearish_continuation
Bearish Continuation => Sellers return
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

NODE 84
TITLE: Order Flow at VWAP
TYPE: STANDARD
CELEBRATION: Order Flow at VWAP complete.

[EVIDENCE_SELECT] Select the two strongest clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
VWAP holds as location
Trend aggression returns
Price loses VWAP
Counter tape accelerates
WHY: Advanced continuation requires structure plus confirming execution evidence.

[LIVE_CHART] What changed in price response?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
SKILL: order_flow_at_vwap
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MC] What's the best read?
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
SKILL: order_flow_at_vwap
CHART: priceAboveVWAP
VWAP provides location while order flow determines the response
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: VWAP provides location while order flow determines the response.

[FOOTPRINT_TAP] Tap the busiest row near VWAP.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
SKILL: footprint_interaction
EVENT: total_target
TARGET: 1
WHY: The selected row contains the requested execution profile.

NODE 85
TITLE: Order Flow at a Moving Average
TYPE: STANDARD
CELEBRATION: Order Flow at a Moving Average complete.

[MC] What does the evidence support?
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
SKILL: order_flow_at_a_moving_average
CHART: priceAboveMA
The average provides location but execution evidence determines the read
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: The average provides location but execution evidence determines the read.

[EVIDENCE_SELECT] Select the clues the average is acting as location.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Price stalls near the average
Trend-side execution resumes there
A single touch of the average
Counter aggression accelerates through it
WHY: The average matters as location only when price stalls there and trend-side execution resumes.

[MATCH] Match each clue.
SKILL: order_flow_at_a_moving_average
Order Flow at a Moving Average => Aggression near the average
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Candles hold above a rising moving average and react near it during pullbacks. The candles are tappable and the learner must select the requested candle.
SKILL: order_flow_at_a_moving_average
CHART: priceAboveMA
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

NODE 86
TITLE: Pullback Failure
TYPE: STANDARD
CELEBRATION: Pullback Failure complete.

[MC] Which explanation fits best?
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
SKILL: pullback_failure
CHART: bearishEngulfing
Strong counter pressure can end continuation
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Strong counter pressure can end continuation.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise. The candles are tappable and the learner must select the requested candle.
SKILL: pullback_failure
CHART: bearishEngulfing
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[TIME_SALES] What changes as the pullback fails?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Counter pressure gains urgency
Aggression disappears
The spread proves continuation
WHY: Use completed executions to judge whether trend pressure returned.

NODE 87
TITLE: Conflicting Order Flow Signals
TYPE: STANDARD
CELEBRATION: Conflicting Order Flow Signals complete.

[TIME_SALES] What does the tape show?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Urgency appears, then fades
Tape speed confirms acceptance
One print resolves the read
WHY: Conflicting signals call for patience and a weaker conclusion.

[FOOTPRINT] What contradicts the tape?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Delta and price response disagree
The largest cell decides direction
Volume guarantees a trend
WHY: Conflicting signals call for patience and a weaker conclusion.

[EVIDENCE_SELECT] Select the two strongest clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Tape and delta disagree
Price response is weak
Every clue aligns
Acceptance is confirmed
WHY: Advanced continuation requires structure plus confirming execution evidence.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress. The candles are tappable and the learner must select the requested candle.
SKILL: conflicting_order_flow_signals
CHART: spinningTop
TARGET: 2
WHY: The selected candle shows whether execution produced follow through.

[ORDER] Build the read.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
SKILL: market_sequence
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 88
TITLE: High Volume Chop
TYPE: STANDARD
CELEBRATION: High Volume Chop complete.

[TIME_SALES] What defines the tape?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Fast two sided execution
Tape speed confirms acceptance
One print resolves the read
WHY: High volume without directional progress can show two sided absorption.

[FOOTPRINT] What does the footprint add?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Heavy volume without directional progress
The largest cell decides direction
Volume guarantees a trend
WHY: High volume without directional progress can show two sided absorption.

[MC] What best connects the evidence?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
SKILL: high_volume_chop
CHART: range
High volume without directional progress can show two sided absorption
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: High volume without directional progress can show two sided absorption.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction. The candles are tappable and the learner must select the requested candle.
SKILL: high_volume_chop
CHART: range
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

[ORDER] Build the read.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
SKILL: market_sequence
CHART: range
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 89
TITLE: Low Volume Trend
TYPE: STANDARD
CELEBRATION: Low Volume Trend complete.

[TIME_SALES] What does the tape show?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Steady movement without urgent prints
Tape speed confirms acceptance
One print resolves the read
WHY: A trend can travel on low volume when little liquidity opposes it.

[FOOTPRINT] Is execution strongly directional?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
No. Thin opposition still allows travel
The largest cell decides direction
Volume guarantees a trend
WHY: A trend can travel on low volume when little liquidity opposes it.

[MC] Which read needs fewer assumptions?
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
SKILL: low_volume_trend
CHART: ascendingChannel
Thin opposition can allow a low volume trend
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: A trend can travel on low volume when little liquidity opposes it.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary. The learner draws directly between two candles to mark the structure.
SKILL: low_volume_trend
CHART: ascendingChannel
TARGET: 2 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[ORDER] Build the read.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
SKILL: market_sequence
CHART: ascendingChannel
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 90
TITLE: No Clear Read Practice Replay
TYPE: PRACTICE_REPLAY
CELEBRATION: No Clear Read Simulation complete.

[ORDERFLOW_SIM] Book tape and price response disagree. What is strongest?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
The evidence conflicts so no directional read is confirmed
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: When evidence conflicts the strongest conclusion may be no clear read.

[MC] What matters most here?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
SKILL: no_clear_read_practice_replay
CHART: spinningTop
Conflicting evidence means no confirmed read
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: When evidence conflicts the strongest conclusion may be no clear read.

[ORDER] Build the read.
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
SKILL: market_sequence
CHART: spinningTop
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 91
TITLE: Entry After Confirmation
TYPE: STANDARD
CELEBRATION: Entry After Confirmation complete.

[EVIDENCE_SELECT] Select the two strongest clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Trend side aggression
Confirming price response
One isolated print
An untested wall
WHY: Advanced continuation requires structure plus confirming execution evidence.

[EVIDENCE_SELECT] Select the clues that confirm before entry.
VISUAL: Four evidence cards separate real order flow clues from an irrelevant one. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Structure holds through the pullback
Trend pressure returns at the trigger
The first print beyond the level
Counter pressure still accelerating
WHY: Confirmation is held structure plus returning trend pressure, not a single print.

[MATCH] Match each clue.
SKILL: entry_after_confirmation
Entry After Confirmation => Pressure returns
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
SKILL: entry_after_confirmation
CHART: breakoutRetest
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

NODE 92
TITLE: Continuation Review
TYPE: STANDARD
CELEBRATION: Continuation Review complete.

[MC] How should this be interpreted?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
SKILL: continuation_review
CHART: bullFlag
Continuation needs structure and renewed pressure
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Continuation needs structure and renewed pressure.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
SKILL: continuation_review
CHART: bullFlag
TARGET: 0 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[TIME_SALES] What confirms continuation on tape?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_reading
EVENT: accelerating
Trend side pressure returns
One opposing print appears
Displayed depth stays unchanged
WHY: Use completed executions to judge whether trend pressure returned.

NODE 93
TITLE: Boss Battle: Continue, Fail, or Wait?
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Continue, Fail, or Wait? complete.

[EVIDENCE_SELECT] Select bullish continuation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Shallow pullback
Buyer pressure returns
Support fails
Selling accelerates
WHY: Structure and returning pressure support continuation.

[EVIDENCE_SELECT] Select bearish continuation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Lower high holds
Seller pressure returns
Resistance fails
Buying accelerates
WHY: Bearish structure and selling support continuation.

[MC] What matters at VWAP?
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
SKILL: boss_continue_fail_wait
CHART: priceAboveVWAP
Execution response at the level
VWAP guarantees support
Candle color alone
WHY: VWAP gives location; flow gives the read.

[MC] What matters at the average?
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
SKILL: boss_continue_fail_wait
CHART: priceAboveMA
Execution response at the level
The average guarantees support
One print alone
WHY: The average is location, not confirmation.

[TIME_SALES] Trend pressure fades. Now what?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Continuation is weakening
Continuation is confirmed
Location is irrelevant
WHY: Fading pressure weakens the continuation case.

[FOOTPRINT] Heavy volume, little progress. Why?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Possible high volume chop
Strong trend confirmed
No trading occurred
WHY: Heavy two sided execution can produce chop.

[ORDERFLOW_SIM] What's the best conclusion?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
No clear read yet
Bullish continuation
Bearish continuation
WHY: The evidence conflicts.

[EVIDENCE_SELECT] Select pullback failure clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Counter pressure accelerates
Key structure fails
Trend pressure returns
Price holds the level
WHY: Growing counter pressure and lost structure signal failure.


UNIT 9 — Reversals and Traps
TIER: Expert

NODE 94
TITLE: Reversal Pressure
TYPE: STANDARD
CELEBRATION: Reversal Pressure complete.

[TIME_SALES] What changed on the tape?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
The initiating side lost control
Positive delta confirms a reversal regardless of price response
Slower tape guarantees the opposing side has control
WHY: Reversals need a clear change in control.

[FOOTPRINT] What confirms the control change?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Opposing aggression gains strength
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which read is best supported?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
SKILL: reversal_pressure
CHART: bullishEngulfing
Reversals need a clear change in control
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Reversals need a clear change in control.

NODE 95
TITLE: Buyer Trap
TYPE: STANDARD
CELEBRATION: Buyer Trap complete.

[TIME_SALES] What shows buyers became trapped?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Buy prints fail above resistance
A large opposing print outweighs the executions that follow
Price location is unnecessary once a reversal candle closes
WHY: A buyer trap forms when a breakout fails.

[FOOTPRINT] What contradicts the positive delta?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Price returns below resistance
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[REPLAY_COMPARE] Which replay trapped buyers?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay B
Replay A
Neither replay
WHY: Replay B returns below resistance and transfers control to sellers.

NODE 96
TITLE: Seller Trap
TYPE: STANDARD
CELEBRATION: Seller Trap complete.

[TIME_SALES] What shows sellers became trapped?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Sell prints fail below support
The candle pattern identifies every initiating trade
The earliest pressure cannot be contradicted later
WHY: A seller trap forms when a breakdown fails.

[FOOTPRINT] What contradicts the negative delta?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Price returns above support
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[REPLAY_COMPARE] Which replay trapped sellers?
VISUAL: Replay A trades through a level and rejects immediately without acceptance. Replay B trades through with persistent execution and holds beyond the level.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: The rejected break fails to gain acceptance and traps the initiating side.

NODE 97
TITLE: Exhaustion Reversal
TYPE: STANDARD
CELEBRATION: Exhaustion Reversal complete.

[TIME_SALES] What shows aggression fading?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Print pace and size decline
A rejection wick proves passive absorption
The second test should inherit the first test's order flow
WHY: Exhaustion can prepare a reversal.

[FOOTPRINT] What weakens the prior side?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Directional execution loses dominance
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] What does the evidence support?
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
SKILL: exhaustion_reversal
CHART: doji
Exhaustion can prepare a reversal
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Exhaustion can prepare a reversal.

NODE 98
TITLE: Absorption Reversal
TYPE: STANDARD
CELEBRATION: Absorption Reversal complete.

[TIME_SALES] What shows pressure being absorbed?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Heavy prints make little progress
Positive delta confirms a reversal regardless of price response
Slower tape guarantees the opposing side has control
WHY: Absorbed selling can support a reversal.

[FOOTPRINT] What confirms passive defense?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Aggression stalls at one level
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which explanation fits best?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
SKILL: absorption_reversal
CHART: rejectionWickDown
Absorbed selling can support a reversal
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Absorbed selling can support a reversal.

NODE 99
TITLE: Double Top Flow
TYPE: STANDARD
CELEBRATION: Double Top Flow complete.

[TIME_SALES] How does the second test differ?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Buyer urgency is weaker
A large opposing print outweighs the executions that follow
Price location is unnecessary once a reversal candle closes
WHY: Repeated failure can shift control to sellers.

[FOOTPRINT] What changes on the retest?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Seller response strengthens
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] What's the strongest conclusion?
VISUAL: Price tests the same resistance area twice and retreats after the second test.
SKILL: double_top_flow
CHART: doubleTop
Repeated failure can shift control to sellers
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Repeated failure can shift control to sellers.

NODE 100
TITLE: Double Bottom Flow
TYPE: STANDARD
CELEBRATION: Double Bottom Flow complete.

[TIME_SALES] Which side weakens on the retest?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Aggressive sellers
The candle pattern identifies every initiating trade
The earliest pressure cannot be contradicted later
WHY: Repeated failure can shift control to buyers.

[FOOTPRINT] What changes on the second test?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Buyer response strengthens
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] What best connects the evidence?
VISUAL: Price tests the same support area twice and rebounds after the second test.
SKILL: double_bottom_flow
CHART: doubleBottom
Repeated failure can shift control to buyers
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Repeated failure can shift control to buyers.

NODE 101
TITLE: Confirmation Before Entry
TYPE: STANDARD
CELEBRATION: Confirmation Before Entry complete.

[TIME_SALES] What confirms the reversal?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Opposing prints gain follow through
A rejection wick proves passive absorption
The second test should inherit the first test's order flow
WHY: Confirmation reduces premature reversal entries.

[FOOTPRINT] What must execution produce?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
A confirming price response
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] Which read needs fewer assumptions?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
SKILL: confirmation_before_entry
CHART: bullishEngulfing
Confirmation reduces premature reversal entries
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Confirmation reduces premature reversal entries.

NODE 102
TITLE: Boss Battle: Trap or Reversal?
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Trap or Reversal? complete.

[REPLAY_COMPARE] Which replay traps buyers?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay B
Replay A
Neither
WHY: Replay B fails above resistance.

[REPLAY_COMPARE] Which replay traps sellers?
VISUAL: Replay A trades through a level and rejects immediately without acceptance. Replay B trades through with persistent execution and holds beyond the level.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: The rejected breach traps the initiating side.

[TIME_SALES] What supports exhaustion reversal?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Aggression fades
Aggression stays strong
Price accepts lower
WHY: Exhaustion begins with fading aggression.

[ORDERFLOW_SIM] What supports buyer absorption reversal?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Selling stalls at support
Selling accepts lower
No bids replenish
WHY: Repeated selling fails to make progress.

[MC] What matters on the second test?
VISUAL: Price tests the same resistance area twice and retreats after the second test.
SKILL: boss_trap_or_reversal
CHART: doubleTop
Weaker buying and stronger defense
A higher volume spike than the first test
The same buyers returning at the level
WHY: The turn shows when buying weakens while defense strengthens. Volume alone or repeat buyers do not confirm it.

[MC] What matters on the second test?
VISUAL: Price tests the same support area twice and rebounds after the second test.
SKILL: boss_trap_or_reversal
CHART: doubleBottom
Weaker selling and stronger defense
A deeper wick than the first test
Matching volume on both tests
WHY: The turn shows when selling weakens while defense strengthens. Wick depth or matching volume alone is not confirmation.

[EVIDENCE_SELECT] Select reversal confirmation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Control changes
Price confirms
One rejection wick
Mixed tape
WHY: A reversal needs control change and response.

[ORDERFLOW_SIM] Is a reversal confirmed?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
Not enough evidence
Yes. The wick is enough
Yes. Neutral delta confirms it
WHY: Mixed tape and balanced execution remain inconclusive.

[MC] When should entry wait?
SKILL: boss_trap_or_reversal
Until control and response align
Until a single large print flips delta
Until the reversal candle closes green
WHY: Entry waits for control to change and price to confirm. One print or a green close is not alignment.


UNIT 10 — Execution and Risk
TIER: Expert

NODE 103
TITLE: Plan the Entry
TYPE: STANDARD
CELEBRATION: Plan the Entry complete.

[MC] Which conclusion fits the response?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: plan_the_entry
CHART: breakoutRetest
A clear trigger keeps execution disciplined
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: A clear trigger keeps execution disciplined.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Defined trigger
Confirming response
One fast print
Candle color
WHY: Expert execution decisions combine market evidence with risk.

[REPLAY_COMPARE] Which replay shows a properly confirmed trigger?
VISUAL: Replay A breaks the level, holds above it, and the retest succeeds before continuation. Replay B fails back inside quickly.
SKILL: plan_the_entry
Replay A
Replay B
Neither replay
WHY: Replay A holds beyond the level and the retest succeeds before continuation. Replay B fails back inside.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
SKILL: plan_the_entry
CHART: breakoutRetest
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

NODE 104
TITLE: Choose the Order Type
TYPE: STANDARD
CELEBRATION: Choose the Order Type complete.

[MC] How should this be interpreted?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: choose_the_order_type
CHART: sideways
Order choice balances speed with price control
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Order choice balances speed with price control.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
SKILL: choose_the_order_type
CHART: sideways
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

[MC] What tradeoff guides order choice?
SKILL: choose_the_order_type
Speed versus price control
Candle color versus volume
Bid size versus chart scale
WHY: Market and limit orders trade speed against control of execution price.

NODE 105
TITLE: Manage Slippage
TYPE: STANDARD
CELEBRATION: Manage Slippage complete.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Thin nearby depth
Widening spread
Positive delta
A resting wall far away
WHY: Expert execution decisions combine market evidence with risk.

[BOOK_COMPARE] Which book creates greater slippage risk?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: manage_slippage
Book B
Book A
Both equally
WHY: Book B's thin, gapped depth forces a market order to fill across worse prices.

[ORDERFLOW_SIM] What's the main execution risk?
VISUAL: Depth thins near price, the spread widens after each fill, prints arrive faster, and fills land at worse prices while footprint volume stays light.
SKILL: manage_slippage
Slippage from thin depth and a widening spread
Delayed fills from a thick resting book
Reduced volatility as the spread widens
WHY: Thin depth and a widening spread let market orders fill at worse prices.

NODE 106
TITLE: Order Flow Invalidation
TYPE: STANDARD
CELEBRATION: Order Flow Invalidation complete.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area. The candles are tappable and the learner must select the requested candle.
SKILL: order_flow_invalidation
CHART: supportBounce
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Opposing aggression
Loss of the key level
One small print
Unchanged spread
WHY: Expert execution decisions combine market evidence with risk.

[ORDERFLOW_SIM] The read was seller absorption. What invalidates it?
VISUAL: The original read is a refreshing offer absorbing buyers. Then offers are consumed across levels, buyer prints persist, and price holds above the resistance and VWAP.
SKILL: order_flow_invalidation
Price accepts above the refreshing offer
Buy prints continuing at the same pace
Positive delta while price stalls
WHY: Acceptance above the level means the absorbing seller lost. Continued buying and stalled positive delta were part of the original read.

[ORDER] Build the read.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: market_sequence
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 107
TITLE: Risk in Thin Liquidity
TYPE: STANDARD
CELEBRATION: Risk in Thin Liquidity complete.

[ORDER] Build the decision sequence.
SKILL: market_sequence
Inspect nearby depth
Estimate slippage risk
Reduce size if needed
Define invalidation
WHY: Order flow decisions move from evidence to response and risk.

[MC] What's the most reasonable read?
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
SKILL: risk_in_thin_liquidity
CHART: bandsWidening
Thin liquidity can require smaller risk and more cautious execution
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Thin liquidity can require smaller risk and more cautious execution.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Sparse depth
Higher slippage risk
Large candle body
Positive delta
WHY: Expert execution decisions combine market evidence with risk.

NODE 108
TITLE: No Clear Order Flow Read
TYPE: STANDARD
CELEBRATION: No Clear Order Flow Read complete.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Conflicting tape
Unconfirmed price response
One aligned clue
Stable spread
WHY: Expert execution decisions combine market evidence with risk.

[MC] What's the best read?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
SKILL: no_clear_order_flow_read
CHART: spinningTop
Conflicting evidence is a valid reason to stay out
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Conflicting evidence is a valid reason to stay out.

[MC] What does conflicting evidence suggest?
SKILL: no_clear_order_flow_read
No clear read yet
Follow the fastest signal
Ignore price response
WHY: Conflicting evidence supports patience rather than a forced conclusion.

NODE 109
TITLE: Exit Into Liquidity
TYPE: STANDARD
CELEBRATION: Exit Into Liquidity complete.

[ORDERFLOW_SIM] Which evidence matters most for the planned exit?
VISUAL: Price approaches a large refreshing offer while the tape slows and footprint delta diverges from price progress.
SKILL: exit_into_liquidity
The refreshing offer ahead and the slowing tape
The positive delta from earlier in the move
The distance from VWAP alone
WHY: Opposing liquidity ahead and fading execution pace determine how the exit will fill.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Available opposing liquidity
Current execution pace
Candle color
Moving average slope
WHY: Expert execution decisions combine market evidence with risk.

[MARK_LEVEL] Mark the level where opposing liquidity waits for the exit.
VISUAL: An advance approaches a resistance area holding the opposing resting liquidity a long exit trades into.
SKILL: exit_into_liquidity
CHART: breakout
WHY: The resistance area holds the opposing resting liquidity a long exit trades into.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The candles are tappable and the learner must select the requested candle.
SKILL: exit_into_liquidity
CHART: resistanceRejection
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

NODE 110
TITLE: Review the Order Flow Read
TYPE: STANDARD
CELEBRATION: Review the Order Flow Read complete.

[MC] Which explanation fits best?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: review_the_order_flow_read
CHART: sideways
Review each evidence source separately from the trade outcome
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Review each evidence source separately from the trade outcome.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
SKILL: review_the_order_flow_read
CHART: sideways
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

[REPLAY_COMPARE] Which replay shows acceptance?
VISUAL: Replay A shows offers clearing and price holding above resistance. Replay B shows replenishment and price falling back inside.
SKILL: scenario_comparison
Replay A
Replay B
Neither replay
WHY: Replay A clears offers and holds above the level. Replay B refreshes and rejects.

NODE 111
TITLE: FINAL BOSS: The Complete Order Flow Read
TYPE: BOSS_BATTLE
CELEBRATION: FINAL BOSS: The Complete Order Flow Read complete.

[ORDERFLOW_SIM] Who is aggressive?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Buyers
Sellers
Neither
WHY: Buyer initiated prints dominate.

[ORDERFLOW_SIM] Where is liquidity defending?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
At the refreshing offer
Below the distant bid
Nowhere
WHY: The offer replenishes after fills.

[ORDERFLOW_SIM] Is price responding?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
No. Price stalls
Yes. Price accepts higher
Yes. Delta shows buyers in control
WHY: Aggression makes little progress. Positive delta without price progress is not acceptance.

[ORDERFLOW_SIM] Which evidence conflicts?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Positive delta and stalled price
Fast tape and positive delta
VWAP and resistance
WHY: Positive delta conflicts with weak price progress.

[ORDERFLOW_SIM] What's the strongest read?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Possible seller absorption
Buyer continuation remains favored
Buyer exhaustion is developing
WHY: Refreshing offers and stalled price point to absorption. Continuation needs progress and exhaustion needs fading aggression, but the tape is still fast.

[ORDERFLOW_SIM] What invalidates the read?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Price accepts above resistance
Delta turning even more positive
The offer refreshing again
WHY: Acceptance above the level defeats the absorbing seller. More one-sided delta or another refresh would strengthen the read, not invalidate it.

[ORDERFLOW_SIM] What execution risk is present?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Slippage near changing depth
Overfilling from resting limit orders
A locked spread blocking execution
WHY: Fast activity and changing depth increase slippage. The other risks are not created by this tape.

[BOOK_COMPARE] Which side shows thin liquidity?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B
Book A
Both
WHY: Book B has small size and gaps.

[ORDERFLOW_SIM] Is direction confirmed?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
Not enough evidence
Buyers fully control
Sellers fully control
WHY: Conflicting evidence prevents confirmation.

[EVIDENCE_SELECT] Select what to review afterward.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1, 2
Book behavior
Tape response
Footprint delta
Trade profit only
WHY: Review each evidence source separately from outcome.


TEST OUT METADATA

UNIT 1
QUESTIONS PER ATTEMPT: 8
PASSING SCORE: 7
POOL SIZE: 16

UNIT 2
QUESTIONS PER ATTEMPT: 8
PASSING SCORE: 7
POOL SIZE: 16

UNIT 3
QUESTIONS PER ATTEMPT: 9
PASSING SCORE: 8
POOL SIZE: 18

UNIT 4
QUESTIONS PER ATTEMPT: 9
PASSING SCORE: 8
POOL SIZE: 18

UNIT 5
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20

UNIT 6
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20

UNIT 7
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20

UNIT 8
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20

UNIT 9
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20

UNIT 10
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20
