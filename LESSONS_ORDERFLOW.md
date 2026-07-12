# Order Flow strategy course authoring source

Course id: `orderflow` · accent `#14B8A6` · standalone strategy track.
Mirrors `Moko/GameData.json`. Correct answers appear first for choice and fill questions.
No intro blocks. Most questions render an order book, chart, or live chart.

Interactive mechanics:
  [AGGRESSOR] Watch a live ladder and choose the aggressive side.
  [BOOKDRAG] Route a market order to the bid or ask.
  [BOOK_COMPARE] Compare thick and thin Level II depth.
  [EVIDENCE_SELECT] Choose the clues that complete an evidence stack.
  [MARK_LEVEL] Mark relevant support, resistance, or inferred liquidity.
  [REPLAY_COMPARE] Compare acceptance with replenishment and rejection.
  [TAP_CANDLE] Select a candle directly on a chart.
  [TRENDLINE] Connect two candles on a chart.
  [LIVE_CHART] Read pressure while candles update.
  [ORDERFLOW_SIM] Combine book, tape, footprint, and price response.
  [TIME_SALES] Read an animated feed of completed trades.
  [TIME_SALES_TAP] Select evidence directly from the animated tape.
  [FOOTPRINT] Compare bid and ask volume at each price.
  [FOOTPRINT_TAP] Select an imbalance directly on the footprint.

TOTAL UNITS: 10
TOTAL LESSONS: 77
TOTAL QUESTIONS: 479

UNIT 1 — Order Flow Foundations
TIER: Beginner

NODE 1
TITLE: What Is Order Flow?
TYPE: STANDARD
CELEBRATION: What Is Order Flow? complete.

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
CELEBRATION: Aggressive vs. Passive Orders complete.

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

NODE 3
TITLE: The Bid, Ask & Spread
TYPE: STANDARD
CELEBRATION: The Bid, Ask & Spread complete.

[MC] Pick the bid.
SKILL: the_bid_ask_spread
Highest buyer price
Lowest seller price
Last traded price
WHY: The bid is the best resting buy price.

[MC] Pick the ask.
SKILL: the_bid_ask_spread
Lowest seller price
Highest buyer price
Average daily price
WHY: The ask is the best resting sell price.

[MC] What's the bid ask gap called?
SKILL: the_bid_ask_spread
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
SKILL: the_bid_ask_spread
Market buy => Ask
Market sell => Bid
Spread => Ask minus bid
WHY: Buy at the ask. Sell at the bid.

NODE 4
TITLE: Lifting the Offer & Hitting the Bid
TYPE: STANDARD
CELEBRATION: Lifting the Offer & Hitting the Bid complete.

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
WHY: A complete read combines action, liquidity, and response.

[MC] What does the spread measure?
SKILL: boss_battle_foundations_under_pressure
The distance between best bid and ask
The last candle range
Total traded volume
WHY: The spread separates the best resting bid and ask.

[ORDER] Build the order to price chain.
SKILL: market_sequence
Aggressor crosses the spread
Resting liquidity trades
Available price changes
Chart records the response
WHY: Aggression interacts with liquidity before price records the result.


UNIT 2 — The Order Book
TIER: Beginner

NODE 6
TITLE: Reading the Order Book
TYPE: STANDARD
CELEBRATION: Reading the Order Book complete.

[MC] What does Level II show?
SKILL: reading_the_order_book
Depth of resting orders across price levels.
Only the best bid and ask.
Every trade already executed.
WHY: Level II is the whole ladder of resting limit orders. Level I is just the top of book; executed trades live in time & sales.

[MC] Where do resting buy orders sit?
SKILL: reading_the_order_book
The bid side.
The ask side.
The spread.
WHY: Buyers rest on the bid. Sellers rest on the ask, and the spread is the gap between them.

[MC] What does Level I show?
SKILL: reading_the_order_book
Only the best bid and ask.
The full resting depth on both sides.
The day's executed trades.
WHY: Level I is the top of the book. the single best bid and best ask.

[MC] Where do resting sell orders sit?
SKILL: reading_the_order_book
The ask side.
The bid side.
The spread.
WHY: Sellers rest on the ask side, above the spread.

[MATCH] Match each feed to what it shows.
SKILL: reading_the_order_book
Level I => Best bid and ask
Level II => Full resting depth
Time & Sales => Executed trades
WHY: Three lenses: top of book, the full book, and the trades that already happened.

[BOOKDRAG] Tap the side this buy fills against.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: A market buy lifts the ask.

[AGGRESSOR] Tap the aggressor.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: The offers are being taken, so the buyer is the aggressor lifting them.

NODE 7
TITLE: Size & Liquidity
TYPE: STANDARD
CELEBRATION: Size & Liquidity complete.

[MC] What does the number beside a price show?
SKILL: size_liquidity
The size resting there.
The trades done there.
Its distance from the last price.
WHY: The number is resting size. how many shares sit waiting at that price.

[MC] A book with large size at every level is…
SKILL: size_liquidity
Liquid.
Illiquid.
Volatile.
WHY: Plenty of resting size means liquid: price needs a lot of aggression to move.

[TF] A thin book moves on fewer orders than a thick one.
SKILL: size_liquidity
ANSWER: True
WHY: Less resting size means each aggressive order pushes price further.

[MATCH] Match each book to how it moves.
SKILL: size_liquidity
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

NODE 8
TITLE: Large Orders as Walls
TYPE: STANDARD
CELEBRATION: Large Orders as Walls complete.

[BOOK_COMPARE] Which book shows the larger wall?
VISUAL: Two Level II ladders appear side by side. Book A concentrates 1,500 shares at one ask price while surrounding levels remain near 100. Book B has ordinary size across every level.
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

NODE 9
TITLE: Pulling, Replenishment & Spoofing
TYPE: STANDARD
CELEBRATION: Pulling, Replenishment & Spoofing complete.

[REPLAY_COMPARE] Which wall absorbed selling?
VISUAL: Replay A shows sellers hitting a large bid that replenishes while price holds. Replay B shows a large bid getting pulled before price falls through.
SKILL: scenario_comparison
Replay A
Replay B
Neither replay
WHY: Replay A replenishes while trading and price holds. Replay B pulls before the decline.

[MC] Repeated deceptive posting and cancellation intended to mislead may constitute…
SKILL: pulling_replenishment_spoofing
Spoofing.
Absorption.
A breakout.
WHY: Repeated deceptive posting and cancellation intended to mislead may constitute spoofing. One cancelled order alone does not prove intent.

[TF] A resting order is a firm promise to trade.
SKILL: pulling_replenishment_spoofing
ANSWER: False
WHY: It can be cancelled before anyone hits it.

[MATCH] Match each behavior.
SKILL: pulling_replenishment_spoofing
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

NODE 10
TITLE: What Actually Moves Price
TYPE: STANDARD
CELEBRATION: What Actually Moves Price complete.

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

NODE 11
TITLE: Order Book Challenge
TYPE: STANDARD
CELEBRATION: Order Book Challenge complete.

[MC] What does Level II show?
SKILL: order_book_challenge
Available depth from the relevant venue or feed.
Just the best bid and ask.
Executed trades.
WHY: Level II is the full ladder of resting orders on both sides.

[MC] What does the evidence support?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: order_book_challenge
CHART: sideways
Combine aggression, liquidity, and price response
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
WHY: A complete read combines who acts where liquidity rests and how price responds.

[BOOKDRAG] Route this order.
VISUAL: A draggable market buy card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_buy
ANSWER: the ask
WHY: Market buys take asks. Market sells take bids.

[MATCH] Match each clue.
SKILL: order_book_challenge
Foundations and Book Mixed Review => Aggression liquidity and response
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
SKILL: order_book_challenge
CHART: sideways
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

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

NODE 12
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

[BOOK_COMPARE] Which book has the larger wall?
VISUAL: Two Level II ladders appear side by side. Book A concentrates 1,500 shares at one ask price while surrounding levels remain near 100. Book B has ordinary size across every level.
SKILL: book_depth
Book A
Book B
Neither book
WHY: Book A concentrates unusually large size at one level.

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

[ORDER] Build the wall validation process.
SKILL: market_sequence
Locate unusual resting size
Watch executions reach it
Check whether size replenishes
Judge the price response
WHY: A wall matters only after its behavior and price response are observed.


UNIT 3 — Tape Reading
TIER: Intermediate

NODE 13
TITLE: Reading Time & Sales
TYPE: STANDARD
CELEBRATION: Reading Time & Sales complete.

[TIME_SALES] What information does each row provide?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Execution time price size and initiating side
Resting bid and ask size before execution
Total candle volume without trade direction
WHY: Each row is a completed trade with time price size and side.

[TIME_SALES] Which tape behavior best supports the reading the tape read?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Prints reveal completed trades
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Prints reveal completed trades.

[TIME_SALES] Which side is initiating these trades?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Sellers
Buyers
Neither side can initiate a trade
WHY: Trades at the bid are seller initiated.

[TIME_SALES_TAP] In reading the tape, tap the most informative print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_interaction
EVENT: large_print
TARGET: 1
WHY: The selected execution carries the key tape evidence.

[TIME_SALES_TAP] In reading time and sales, tap the most informative print.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_interaction
EVENT: large_print
TARGET: 3
WHY: The selected execution carries the key tape evidence.

[MC] Did price confirm the tape?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: reading_time_sales
CHART: sideways
Price response remains inconclusive
Buyers are fully confirmed
Sellers are fully confirmed
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[MATCH] Match each clue.
SKILL: reading_time_sales
Reading Time and Sales => Price size and side
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

NODE 14
TITLE: Speed & Size
TYPE: STANDARD
CELEBRATION: Speed & Size complete.

[TIME_SALES] The prints begin slowly and then arrive faster. What changed?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_reading
EVENT: accelerating
Faster prints can reveal rising activity
Displayed depth changed but no completed trade confirms participation
Candle direction identifies the initiating side of every execution
WHY: Faster prints can reveal rising activity.

[TIME_SALES] Which change in the feed shows unusually large participation?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_reading
EVENT: large_print
Larger trades can show stronger participation
The spread narrowed so trade pace no longer matters
One large print establishes persistent control
WHY: Larger trades can show stronger participation.

[TIME_SALES_TAP] Tap the first print where the tape begins accelerating.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_interaction
EVENT: accelerating
TARGET: 6
WHY: This print begins the faster arrival sequence.

[TIME_SALES_TAP] Tap the unusually large executed trade.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one unusually large execution among ordinary prints.
SKILL: tape_interaction
EVENT: large_print
TARGET: 4
WHY: This execution is much larger than the surrounding prints.

[MC] Did price confirm the tape?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: speed_size
CHART: sideways
No. Price barely moved
Yes. Faster tape confirms buyers
Yes. Volatility confirms direction
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[AGGRESSOR] Who's crossing the spread?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Buyers take offers. Sellers take bids.

NODE 15
TITLE: Buyer vs. Seller Initiated Prints
TYPE: STANDARD
CELEBRATION: Buyer vs. Seller Initiated Prints complete.

[TIME_SALES] Where are the buyer initiated trades executing?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Trades at the ask suggest buyer aggression
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Trades at the ask suggest buyer aggression.

[TIME_SALES] Where are the seller initiated trades executing?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Trades at the bid suggest seller aggression
Displayed depth changed but no completed trade confirms participation
Candle direction identifies the initiating side of every execution
WHY: Trades at the bid suggest seller aggression.

[TIME_SALES_TAP] Tap a buyer initiated execution at the ask.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the target row showing a buyer initiated execution at the ask.
SKILL: tape_interaction
EVENT: buyer_target
TARGET: 7
WHY: The selected trade executes at the ask and is buyer initiated.

[TIME_SALES_TAP] Tap a seller initiated execution at the bid.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the target row showing a seller initiated execution at the bid.
SKILL: tape_interaction
EVENT: seller_target
TARGET: 5
WHY: The selected trade executes at the bid and is seller initiated.

[MC] Did price confirm the tape?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
SKILL: buyer_vs_seller_initiated_prints
CHART: range
Price response remains inconclusive
Buyer control is confirmed
Seller control is confirmed
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

NODE 16
TITLE: Repeated Prints & Sequence Breaks
TYPE: STANDARD
CELEBRATION: Repeated Prints & Sequence Breaks complete.

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
SKILL: repeated_prints_sequence_breaks
CHART: uptrend
Yes. Higher prices continued
No. Repetition never matters
Inconclusive despite higher highs
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[EVIDENCE_SELECT] Select the two strongest evidence checks for Repeated Prints & Sequence Breaks.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Repeated Prints & Sequence Breaks?
SKILL: repeated_prints_sequence_breaks
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 17
TITLE: Acceleration, Slowdown & False Urgency
TYPE: STANDARD
CELEBRATION: Acceleration, Slowdown & False Urgency complete.

[TIME_SALES] What changed first before activity expanded?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_reading
EVENT: accelerating
A faster pace can precede expansion
The spread narrowed so trade pace no longer matters
One large print establishes persistent control
WHY: A faster pace can precede expansion.

[TIME_SALES] Fast prints lose pace without price progress. What weakened?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Fast prints need price confirmation
A faster feed confirms acceptance regardless of price response
Alternating print colors mean no side can be aggressive
WHY: Fast prints need price confirmation.

[TIME_SALES_TAP] Tap where the tape first changes to a faster pace.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with the interval between prints shrinking after the target row.
SKILL: tape_interaction
EVENT: accelerating
TARGET: 3
WHY: The interval between prints begins shrinking here.

[TIME_SALES_TAP] Tap where fast activity begins losing follow through.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_interaction
EVENT: stall
TARGET: 6
WHY: Prints continue but size and pace begin fading here.

[MC] Did price confirm the tape?
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
SKILL: acceleration_slowdown_false_urgency
CHART: breakout
Yes. Price expanded higher
No. Pace cannot confirm
Inconclusive after acceptance
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

NODE 18
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
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: tape_at_key_levels
CHART: resistanceRejection
No. Buying failed at resistance
Yes. Fast buying confirmed control
Inconclusive despite rejection
WHY: Use the chart only to judge whether price confirmed the tape evidence.

[EVIDENCE_SELECT] Select the two strongest evidence checks for Tape at Key Levels.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Tape at Key Levels?
SKILL: tape_at_key_levels
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 19
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

NODE 20
TITLE: What Is Absorption?
TYPE: STANDARD
CELEBRATION: What Is Absorption? complete.

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

[EVIDENCE_SELECT] Select the two strongest evidence checks for What Is Absorption?.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret What Is Absorption??
SKILL: what_is_absorption
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 21
TITLE: Buyer vs. Seller Absorption
TYPE: STANDARD
CELEBRATION: Buyer vs. Seller Absorption complete.

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

[TIME_SALES] What are buyers failing to do?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Clear the refreshing offer
Pressure and price accelerate together
No aggressive executions appear
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] Which explanation fits best?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: buyer_vs_seller_absorption
CHART: supportBounce
Buyers absorb selling near support
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Buyers absorb selling near support.

[MC] What's the strongest conclusion?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: buyer_vs_seller_absorption
CHART: resistanceRejection
Sellers absorb buying near resistance
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Sellers absorb buying near resistance.

NODE 22
TITLE: Repeated Tests & Hidden Liquidity
TYPE: STANDARD
CELEBRATION: Repeated Tests & Hidden Liquidity complete.

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

[ORDERFLOW_SIM] What suggests hidden liquidity?
VISUAL: Level II repeatedly shows 100 shares at the offer. Each 100 share execution clears the display, then another 100 immediately reappears at the same price while Time and Sales keeps printing buys.
SKILL: multi_signal_read
Displayed size keeps replenishing
Pressure and price accelerate together
No aggressive executions appear
WHY: Absorption requires pressure plus a weak corresponding price response.

[MC] What best connects the evidence?
VISUAL: Price tests the same support area twice and rebounds after the second test.
SKILL: repeated_tests_hidden_liquidity
CHART: doubleBottom
A level that survives tests may contain absorption
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: A level that survives tests may contain absorption.

[EVIDENCE_SELECT] Select two hidden liquidity clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Refreshing displayed size
Repeated executions at one price
Positive delta alone
Candle color
WHY: Repeated same price fills plus replenishment directly suggest hidden liquidity.

NODE 23
TITLE: What Is Exhaustion?
TYPE: STANDARD
CELEBRATION: What Is Exhaustion? complete.

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

[EVIDENCE_SELECT] Select the two strongest evidence checks for What Is Exhaustion?.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret What Is Exhaustion??
SKILL: what_is_exhaustion
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 24
TITLE: Buyer vs. Seller Exhaustion
TYPE: STANDARD
CELEBRATION: Buyer vs. Seller Exhaustion complete.

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

[EVIDENCE_SELECT] Select the two strongest evidence checks for Buyer vs. Seller Exhaustion.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Buyer vs. Seller Exhaustion?
SKILL: buyer_vs_seller_exhaustion
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 25
TITLE: Absorption vs. Exhaustion
TYPE: STANDARD
CELEBRATION: Absorption vs. Exhaustion complete.

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

[EVIDENCE_SELECT] Select the two strongest evidence checks for Absorption vs. Exhaustion.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Absorption vs. Exhaustion?
SKILL: absorption_vs_exhaustion
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 26
TITLE: Absorption Practice Replays
TYPE: PRACTICE_REPLAY
CELEBRATION: Absorption Practice Replays complete.

[ORDERFLOW_SIM] Buying is aggressive but price cannot clear resistance. What is strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Buyers are active but may be absorbed by refreshing sellers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Aggressive buyers can be absorbed by passive sellers at resistance.

[ORDERFLOW_SIM] Selling is aggressive but price cannot break support. What is strongest?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Sellers are active but may be absorbed by refreshing buyers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Aggressive sellers can be absorbed by passive buyers at support.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Strong pressure with little movement suggests absorption
The candle alone proves the cause
Aggression confirms continuation
Displayed size reveals hidden liquidity
WHY: Strong pressure with little movement suggests absorption.

[MC] What does the evidence support?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
SKILL: absorption_practice_replays
CHART: rejectionWickDown
Separate active pressure from the market response
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
WHY: Separate active pressure from the market response.

[MC] Which read is best supported?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: absorption_practice_replays
CHART: resistanceRejection
Aggressive buyers can be absorbed by passive sellers at resistance
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Aggressive buyers can be absorbed by passive sellers at resistance.

[MC] What's the most reasonable read?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: absorption_practice_replays
CHART: supportBounce
Aggressive sellers can be absorbed by passive buyers at support
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Aggressive sellers can be absorbed by passive buyers at support.

NODE 27
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

[ORDERFLOW_SIM] Selling stays aggressive while support holds. What's strongest?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Possible buyer absorption
Seller continuation remains favored
Seller exhaustion is developing
WHY: Selling remains active while support holds.

[ORDERFLOW_SIM] Buying stays aggressive while resistance holds. What's strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Possible seller absorption
Buyer continuation remains favored
Buyer exhaustion is developing
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

NODE 28
TITLE: Reading Footprints & Imbalances
TYPE: STANDARD
CELEBRATION: Reading Footprints & Imbalances complete.

[FOOTPRINT] What does the bid and ask split inside each row represent?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Executed selling at the bid and buying at the ask
Resting limit orders waiting at each price
Total candle volume without side separation
WHY: A footprint separates executed bid volume from executed ask volume at each price.

[FOOTPRINT] What comparison defines the imbalance?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Compare diagonal bid and ask volume by ratio
Use the largest same row difference
Compare ask depth with bid executions
WHY: Diagonal comparison and a defined ratio distinguish conventional imbalance from a simple same price execution difference.

[FOOTPRINT_TAP] Tap the row with most executed volume.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
SKILL: footprint_interaction
EVENT: total_target
TARGET: 0
WHY: This row has the largest bid plus ask total.

[FOOTPRINT_TAP] Tap the first diagonal ask imbalance.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing ask volume at the target price exceeding bid volume at the diagonally adjacent lower price by a clear ratio.
SKILL: footprint_interaction
EVENT: diagonal_ask
TARGET: 1
WHY: Ask execution exceeds the adjacent lower bid by ratio.

[MC] Which explanation fits best?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: reading_footprints_imbalances
CHART: sideways
A footprint shows executed volume at each price
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: A footprint shows executed volume at each price.

[MC] What comparison defines the imbalance?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: reading_footprints_imbalances
CHART: volatile
Compare diagonal bid and ask volume by ratio
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: A conventional footprint imbalance compares diagonally adjacent bid and ask volume using a ratio threshold.

[MATCH] Match each clue.
SKILL: reading_footprints_imbalances
Reading a Footprint Chart => Bid and ask volume by price
Aggressive order => Trades immediately
Passive order => Rests as liquidity
WHY: Match the signal with its order flow clue.

NODE 29
TITLE: Buyer vs. Seller Imbalances
TYPE: STANDARD
CELEBRATION: Buyer vs. Seller Imbalances complete.

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
TARGET: 2
WHY: This row has the widest directional execution advantage.

[FOOTPRINT_TAP] Tap the strongest ask side advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_interaction
EVENT: lift
TARGET: 3
WHY: Aggressive buyers execute at the ask.

[FOOTPRINT_TAP] Tap the strongest bid side advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_interaction
EVENT: hit
TARGET: 4
WHY: Aggressive sellers execute at the bid.

[MC] What best connects the evidence?
SKILL: buyer_vs_seller_imbalances
Imbalance means one side is more aggressive
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Imbalance means one side is more aggressive.

[MC] Which read needs fewer assumptions?
SKILL: buyer_vs_seller_imbalances
Buyer imbalance can push price higher
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Buyer imbalance can push price higher.

[MC] What matters most here?
SKILL: buyer_vs_seller_imbalances
Seller imbalance can push price lower
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Seller imbalance can push price lower.

[ORDER] Build the read.
SKILL: market_sequence
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 30
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
TARGET: 5
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

[MC] What is the best way to interpret Momentum Ignition?
SKILL: momentum_ignition
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 31
TITLE: Momentum Continuation & Failure
TYPE: STANDARD
CELEBRATION: Momentum Continuation & Failure complete.

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
TARGET: 6
WHY: Consecutive ask imbalances support continued buyer pressure.

[FOOTPRINT_TAP] Tap where directional pressure disappears.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
SKILL: footprint_interaction
EVENT: balanced_target
TARGET: 0
WHY: Execution becomes balanced as momentum loses force.

[MC] How should this be interpreted?
SKILL: momentum_continuation_failure
Renewed buying can continue momentum
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Renewed buying can continue momentum.

[MC] What does the response suggest?
SKILL: momentum_continuation_failure
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

NODE 32
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

[EVIDENCE_SELECT] Select the two strongest evidence checks for Stacked Pressure.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Stacked Pressure?
SKILL: stacked_pressure
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 33
TITLE: Delta vs. Volume
TYPE: STANDARD
CELEBRATION: Delta vs. Volume complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Net aggression compares buying with selling
Several ask heavy rows prove sellers withdrew
High total volume must contain directional delta
One footprint candle is enough to ignore location
WHY: Net aggression compares buying with selling.

[FOOTPRINT] Price and delta disagree. Why?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Volume is total activity. Delta is net aggression
Delta determines the next price
Volume and delta are identical
The disagreement cancels both readings
WHY: Volume measures total trading while delta compares aggressive buying and selling.

[FOOTPRINT_TAP] Tap the row adding most positive delta.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest positive ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_positive
TARGET: 2
WHY: This row contributes the largest ask minus bid volume.

[MC] What's the best read?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: delta_vs_volume
CHART: volatile
Volume is total activity. Delta is net aggression
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Volume measures total trading while delta compares aggressive buying and selling.

[MC] What's the most reasonable read?
SKILL: delta_vs_volume
Net aggression compares buying with selling
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Net aggression compares buying with selling.

[FOOTPRINT_TAP] Tap the highest volume row.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
SKILL: footprint_interaction
EVENT: total_target
TARGET: 3
WHY: Total volume adds bid and ask executions, unlike delta.

[ORDER] Build the read.
SKILL: market_sequence
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 34
TITLE: Positive vs. Negative Delta Divergence
TYPE: STANDARD
CELEBRATION: Positive vs. Negative Delta Divergence complete.

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
SKILL: positive_vs_negative_delta_divergence
CHART: bearishEngulfing
Possible seller absorption or trapped buyers
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Positive delta with falling price can reveal seller absorption or trapped buyers.

[MC] Which explanation fits best?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
SKILL: positive_vs_negative_delta_divergence
CHART: bullishEngulfing
Possible buyer absorption or trapped sellers
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Negative delta with rising price can reveal buyer absorption or trapped sellers.

[FOOTPRINT_TAP] Tap the row contradicting falling price.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest positive ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_positive
TARGET: 4
WHY: Strong positive delta conflicts with the downward price response.

[FOOTPRINT_TAP] Tap the row contradicting rising price.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest negative ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_negative
TARGET: 5
WHY: Strong negative delta conflicts with the upward price response.

[ORDER] Build the read.
VISUAL: A large bearish candle covers the prior bullish body after an attempted rise.
SKILL: market_sequence
CHART: bearishEngulfing
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 35
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
TARGET: 6
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

[MC] What is the best way to interpret Price and Pressure Divergence?
SKILL: price_and_pressure_divergence
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 36
TITLE: Footprint & Momentum Challenge
TYPE: STANDARD
CELEBRATION: Footprint & Momentum Challenge complete.

[FOOTPRINT] What's the best footprint read?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Sustained imbalance matters more than one burst
The largest total row proves directional delta
The bid ask split represents resting limit orders
One same price difference confirms a stacked diagonal imbalance
WHY: Sustained imbalance matters more than one burst.

[FOOTPRINT_TAP] Tap where sustained pressure begins.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing three consecutive rows showing ask side execution imbalances.
SKILL: footprint_interaction
EVENT: stacked_ask
TARGET: 0
WHY: The first stacked row begins persistent ask side pressure.

[FOOTPRINT_TAP] Tap the row where buyer pressure concentrates.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_interaction
EVENT: lift
TARGET: 1
WHY: Concentrated ask executions can help ignite momentum.

[FOOTPRINT_TAP] Tap where directional pressure disappears.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
SKILL: footprint_interaction
EVENT: balanced_target
TARGET: 2
WHY: Execution becomes balanced as momentum loses force.

[FOOTPRINT_TAP] Tap the execution clue opposing price.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest negative ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_negative
TARGET: 3
WHY: The selected negative delta row contradicts the price direction.

[MC] What best connects the evidence?
SKILL: footprint_momentum_challenge
Sustained imbalance matters more than one burst
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Sustained imbalance matters more than one burst.

[MC] Which conclusion fits the response?
SKILL: footprint_momentum_challenge
Sudden aggression can ignite momentum
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: Sudden aggression can ignite momentum.

[MC] What does the response suggest?
SKILL: footprint_momentum_challenge
Momentum weakens when price stops responding
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Momentum weakens when price stops responding.

NODE 37
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
TARGET: 4
WHY: Ask volume exceeds the adjacent lower bid by ratio.

[FOOTPRINT_TAP] Tap the strongest ask advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_interaction
EVENT: lift
TARGET: 5
WHY: This row has the strongest aggressive buying.

[FOOTPRINT_TAP] Tap the strongest bid advantage.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_interaction
EVENT: hit
TARGET: 6
WHY: This row has the strongest aggressive selling.

[FOOTPRINT_TAP] Tap where stacked pressure begins.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing three consecutive rows showing ask side execution imbalances.
SKILL: footprint_interaction
EVENT: stacked_ask
TARGET: 0
WHY: Three consecutive ask imbalances start here.

[MC] How do volume and delta differ?
SKILL: boss_battle_footprint_momentum
Volume totals trades; delta nets aggression
They are identical
Delta shows resting depth
WHY: Delta compares ask and bid executions.

[ORDERFLOW_SIM] Positive delta, stalled price. Why?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Possible seller absorption
Buyer control remains favored
Buyer exhaustion is developing
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

NODE 38
TITLE: Liquidity Pools & Stop Clusters
TYPE: STANDARD
CELEBRATION: Liquidity Pools & Stop Clusters complete.

[BOOK_COMPARE] Which book holds the larger liquidity pool?
VISUAL: Two Level II ladders appear side by side. Book A clusters large resting orders across three adjacent prices near an obvious level. Book B has modest evenly distributed depth.
SKILL: book_depth
Book A, with thick clustered depth
Book B, with gaps and thin depth
Both show equal liquidity
WHY: Nearby depth changes how much pressure price needs to travel.

[EVIDENCE_SELECT] Select clues suggesting nearby stop liquidity.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
An obvious prior low
Repeated tests of that level
A distant candle
Displayed bids alone prove stops
WHY: The interaction must match the evidence required by this specific setup.

[MC] Which read needs fewer assumptions?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
SKILL: liquidity_pools_stop_clusters
CHART: range
Liquidity often gathers near obvious levels
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Liquidity often gathers near obvious levels.

[MC] Where might stops cluster?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: liquidity_pools_stop_clusters
CHART: supportBounce
Beyond obvious highs, lows, and levels
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Traders often infer that stops may cluster beyond obvious support resistance highs and lows.

[MATCH] Match each clue.
SKILL: liquidity_pools_stop_clusters
Liquidity Pools => Clustered orders
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MARK_LEVEL] Mark the support hiding inferred sell stops.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: liquidity_location
CHART: supportBounce
WHY: Stops are inferred beyond obvious levels rather than directly visible before triggering.

NODE 39
TITLE: Buy Stops vs. Sell Stops
TYPE: STANDARD
CELEBRATION: Buy Stops vs. Sell Stops complete.

[MARK_LEVEL] Mark where buy stops may cluster.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
SKILL: liquidity_location
CHART: breakout
WHY: Buy stops may cluster beyond obvious resistance or prior highs.

[MC] How should this be interpreted?
VISUAL: Price drives below a visible support level with expanding bearish candles.
SKILL: buy_stops_vs_sell_stops
CHART: breakdown
Sell stops can fuel a downside break
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Sell stops can fuel a downside break.

[EVIDENCE_SELECT] Select clues that may fuel an upside trigger.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
An obvious prior high
Price pressing beneath it
A slow print far below
A bid wall under support
WHY: The interaction must match the evidence required by this specific setup.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price drives below a visible support level with expanding bearish candles. The candles are tappable and the learner must select the requested candle.
SKILL: buy_stops_vs_sell_stops
CHART: breakdown
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[MATCH] Match each clue.
SKILL: buy_stops_vs_sell_stops
Buy Stops => Stops above resistance
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[MARK_LEVEL] Mark the level sell stops may sit below.
VISUAL: Price drives below a visible support level with expanding bearish candles.
SKILL: liquidity_location
CHART: breakdown
WHY: Stops are inferred beyond obvious levels rather than directly visible before triggering.

NODE 40
TITLE: What Is a Liquidity Sweep?
TYPE: STANDARD
CELEBRATION: What Is a Liquidity Sweep? complete.

[EVIDENCE_SELECT] Select clues showing liquidity was taken and rejected.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Price trades through the level
Price immediately returns inside
Price holds beyond the level
Execution continues away
WHY: The interaction must match the evidence required by this specific setup.

[MATCH] Match each clue.
SKILL: what_is_a_liquidity_sweep
Liquidity Sweep => Quick level breach
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] What does the response suggest?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
SKILL: what_is_a_liquidity_sweep
CHART: rejectionWickDown
A sweep takes liquidity then returns
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: A sweep takes liquidity then returns.

[EVIDENCE_SELECT] Select the two strongest evidence checks for What Is a Liquidity Sweep?.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret What Is a Liquidity Sweep??
SKILL: what_is_a_liquidity_sweep
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 41
TITLE: Upside vs. Downside Sweeps
TYPE: STANDARD
CELEBRATION: Upside vs. Downside Sweeps complete.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick. The candles are tappable and the learner must select the requested candle.
SKILL: upside_vs_downside_sweeps
CHART: rejectionWickUp
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

[TAP_CANDLE] Tap the rejection after the sweep.
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick. The candles are tappable and the learner must select the requested candle.
SKILL: upside_vs_downside_sweeps
CHART: rejectionWickDown
TARGET: 4
WHY: Price response distinguishes rejection from acceptance.

[EVIDENCE_SELECT] Select clues supporting an upside sweep.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
The prior high trades
Price rejects back below it
Price builds acceptance above
Offers stay cleared
WHY: The interaction must match the evidence required by this specific setup.

[MC] What's the most reasonable read?
VISUAL: A candle with a small upper body and long lower wick shows rejection of lower prices.
SKILL: upside_vs_downside_sweeps
CHART: hammer
A downside sweep can trap late sellers
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: A downside sweep can trap late sellers.

[MC] Which read is best supported?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: upside_vs_downside_sweeps
CHART: rejectionWickUp
An upside sweep can trap late buyers
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: An upside sweep can trap late buyers.

[MATCH] Match each clue.
SKILL: upside_vs_downside_sweeps
Downside Sweep => Failed push below
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[ORDER] Build the read.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: market_sequence
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

NODE 42
TITLE: Sweep vs. Breakout Acceptance
TYPE: STANDARD
CELEBRATION: Sweep vs. Breakout Acceptance complete.

[EVIDENCE_SELECT] Select clues showing acceptance instead of rejection.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution persists beyond the level
Price holds outside the range
Price immediately returns inside
Aggression disappears
WHY: The interaction must match the evidence required by this specific setup.

[REPLAY_COMPARE] Which replay gains acceptance?
VISUAL: Replay A trades through a level and rejects immediately without acceptance. Replay B trades through with persistent execution and holds beyond the level.
SKILL: scenario_comparison
Replay B
Replay A
Both replays
WHY: Replay B holds beyond the level. Replay A rejects immediately.

[MC] Which comparison best separates these two ideas?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: sweep_vs_breakout_acceptance
CHART: breakoutRetest
Sweeps reject the level. Breakouts gain acceptance.
A sweep always has slower tape than a breakout
Any trade beyond the level confirms a breakout
WHY: Sweeps reject the level. Breakouts gain acceptance.

[EVIDENCE_SELECT] Select the two strongest evidence checks for Sweep vs. Breakout Acceptance.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Sweep vs. Breakout Acceptance?
SKILL: sweep_vs_breakout_acceptance
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 43
TITLE: Thin vs. Thick Liquidity
TYPE: STANDARD
CELEBRATION: Thin vs. Thick Liquidity complete.

[MC] Which explanation fits best?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
SKILL: thin_vs_thick_liquidity
CHART: gapUp
Thin liquidity lets price travel quickly
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Thin liquidity lets price travel quickly.

[BOOK_COMPARE] Which book should move more easily?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B, because depth is thin
Book A, because depth is thick
Both should move equally
WHY: Thin nearby depth and gaps can let price travel with less incoming pressure.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price opens well above the prior trading area with little activity between the two zones. The candles are tappable and the learner must select the requested candle.
SKILL: thin_vs_thick_liquidity
CHART: gapUp
TARGET: 2
WHY: The selected candle shows whether execution produced follow through.

[MC] What does thick depth change?
SKILL: thin_vs_thick_liquidity
More liquidity must trade or withdraw
Price is guaranteed to reverse
Aggressors can ignore nearby size
WHY: Thick displayed depth can slow travel, but it may still trade or be pulled.

[MC] Which comparison best separates these two ideas?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: thin_vs_thick_liquidity
CHART: volatile
Thick books resist travel. Thin books allow easier travel.
A thick book guarantees reversal
A thin book proves aggressive buyers are present
WHY: Thick books resist travel. Thin books allow easier travel.

NODE 44
TITLE: Icebergs & Hidden Replenishment
TYPE: STANDARD
CELEBRATION: Icebergs & Hidden Replenishment complete.

[ORDERFLOW_SIM] The offer refills after buy prints. Why?
VISUAL: Level II repeatedly shows 100 shares at the offer. Each 100 share execution clears the display, then another 100 immediately reappears at the same price while Time and Sales keeps printing buys.
SKILL: multi_signal_read
A possible sell iceberg is replenishing hidden size
Buyers have already secured a breakout
The tape is showing canceled orders
Displayed size cannot change after a fill
WHY: Repeated execution against refreshing displayed size is consistent with an iceberg.

[EVIDENCE_SELECT] Select clues suggesting hidden replenishment.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Displayed size repeatedly refills
Executions repeat at one price
Positive delta alone
One large candle
WHY: The interaction must match the evidence required by this specific setup.

[MC] What best connects the evidence?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: icebergs_hidden_replenishment
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

[MC] What is the best way to interpret Icebergs & Hidden Replenishment?
SKILL: icebergs_hidden_replenishment
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 45
TITLE: Liquidity Challenge
TYPE: STANDARD
CELEBRATION: Liquidity Challenge complete.

[ORDERFLOW_SIM] Price trades beyond the level and immediately returns. What is strongest?
VISUAL: Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.
SKILL: multi_signal_read
Liquidity was taken but acceptance failed
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: A sweep takes liquidity but fails to gain acceptance.

[EVIDENCE_SELECT] Select the two essential clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Event location
Price response
Candle color alone
One isolated print
WHY: A complete read separates aggression, liquidity, and price response.

[EVIDENCE_SELECT] Select the two liquidity clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Nearby resting depth
Execution at the level
A distant candle
Company news
WHY: Advanced reads combine at least two aligned evidence sources.

[MC] What does the evidence support?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: liquidity_challenge
CHART: rejectionWickUp
A sweep takes liquidity but fails to gain acceptance
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: A sweep takes liquidity but fails to gain acceptance.

[MC] Which read needs fewer assumptions?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: liquidity_challenge
CHART: volatile
Judge liquidity events by location and response
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Judge liquidity events by location and response.

[MC] What matters most here?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: liquidity_challenge
CHART: breakoutRetest
Combine pressure with liquidity and price response
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Combine pressure with liquidity and price response.

[ORDER] Build the read.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: market_sequence
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

[MATCH] Match each clue.
SKILL: liquidity_challenge
Liquidity Review => Location and response
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

NODE 46
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
SKILL: boss_battle_sweep_or_acceptance
CHART: rejectionWickUp
Possible upside sweep
Accepted breakout
Buyer exhaustion at the level
WHY: Price trades above and returns inside.

[MC] What does this rejection suggest?
VISUAL: Price briefly trades below a level and closes back above it, leaving a long lower wick.
SKILL: boss_battle_sweep_or_acceptance
CHART: rejectionWickDown
Possible downside sweep
Accepted breakdown
Seller continuation remains favored
WHY: Price trades below and returns inside.

[BOOK_COMPARE] Which book should move more easily?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B
Book A
Both equally
WHY: Thin depth lets price travel more easily.

[ORDERFLOW_SIM] The offer keeps refilling. Why?
VISUAL: Level II repeatedly shows 100 shares at the offer. Each 100 share execution clears the display, then another 100 immediately reappears at the same price while Time and Sales keeps printing buys.
SKILL: multi_signal_read
Possible iceberg
Buyer exhaustion
Breakout acceptance
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

NODE 47
TITLE: Breakout vs. Breakdown Pressure
TYPE: STANDARD
CELEBRATION: Breakout vs. Breakdown Pressure complete.

[REPLAY_COMPARE] Which replay confirms a breakout?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[MC] How should this be interpreted?
VISUAL: Price drives below a visible support level with expanding bearish candles.
SKILL: breakout_vs_breakdown_pressure
CHART: breakdown
Bids are consumed, withdrawn, or both
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: A downside break can develop as sellers consume bids buyers withdraw liquidity or both.

[EVIDENCE_SELECT] Select the two acceptance clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Persistent execution
Price holds beyond the level
Immediate return inside
One isolated print
WHY: Advanced reads combine at least two aligned evidence sources.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price drives below a visible support level with expanding bearish candles. The candles are tappable and the learner must select the requested candle.
SKILL: breakout_vs_breakdown_pressure
CHART: breakdown
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

[MATCH] Match each clue.
SKILL: breakout_vs_breakdown_pressure
Breakout Pressure => Offers consumed withdrawn or thin
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[ORDER] Build the decision sequence.
SKILL: market_sequence
Sellers hit bids
Bids trade or withdraw
Price moves below support
Acceptance is tested
WHY: Order flow decisions move from evidence to response and risk.

NODE 48
TITLE: Acceptance Above vs. Below
TYPE: STANDARD
CELEBRATION: Acceptance Above vs. Below complete.

[EVIDENCE_SELECT] Select the clues showing price accepted above resistance.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Buying persists above the level
Price holds above resistance
Price immediately returns inside
The offer keeps rejecting price
WHY: The interaction must match the evidence required by this specific setup.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price breaks support, returns to test it from below, then reacts lower. The candles are tappable and the learner must select the requested candle.
SKILL: acceptance_above_vs_below
CHART: breakdownRetest
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

[LIVE_CHART] Which price behavior supports the read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
SKILL: acceptance_above_vs_below
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[EVIDENCE_SELECT] Select the clues showing price accepted below support.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Selling persists below the level
Price holds below support
Price immediately reclaims support
The bid repeatedly absorbs selling
WHY: The interaction must match the evidence required by this specific setup.

[MATCH] Match each clue.
SKILL: acceptance_above_vs_below
Acceptance Above => Price holding above
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] Which read is best supported?
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
SKILL: acceptance_above_vs_below
CHART: breakdownRetest
Holding below a level shows acceptance
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Holding below a level shows acceptance.

[MC] What does the response suggest?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: acceptance_above_vs_below
CHART: breakoutRetest
Holding above a level shows acceptance
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Holding above a level shows acceptance.

NODE 49
TITLE: Breakout Acceptance Practice Replay
TYPE: PRACTICE_REPLAY
CELEBRATION: Breakout Acceptance Practice Replay complete.

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

[EVIDENCE_SELECT] Select the two strongest evidence checks for Breakout Acceptance Practice Replay.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

NODE 50
TITLE: Failed Breakouts vs. Failed Breakdowns
TYPE: STANDARD
CELEBRATION: Failed Breakouts vs. Failed Breakdowns complete.

[REPLAY_COMPARE] Which replay traps breakout buyers?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay B
Replay A
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[MC] What does the evidence support?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: failed_breakouts_vs_failed_breakdowns
CHART: supportBounce
A quick return above support signals failure
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: A quick return above support signals failure.

[LIVE_CHART] What changed in price response?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
SKILL: failed_breakouts_vs_failed_breakdowns
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[EVIDENCE_SELECT] Select the clues showing the breakdown failed.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Price reclaims support
Selling loses follow through
Price holds below support
Seller execution accelerates lower
WHY: The interaction must match the evidence required by this specific setup.

[MC] What's the best read?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: failed_breakouts_vs_failed_breakdowns
CHART: resistanceRejection
A quick return below resistance signals failure
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: A quick return below resistance signals failure.

[MATCH] Match each clue.
SKILL: failed_breakouts_vs_failed_breakdowns
Failed Breakdown => Return above support
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[TAP_CANDLE] Tap where the breakout fails.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The candles are tappable and the learner must select the requested candle.
SKILL: failed_breakouts_vs_failed_breakdowns
CHART: resistanceRejection
TARGET: 3
WHY: Price response distinguishes rejection from acceptance.

NODE 51
TITLE: Breakout and Breakdown Retests
TYPE: STANDARD
CELEBRATION: Breakout and Breakdown Retests complete.

[REPLAY_COMPARE] Which replay shows a defended break?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[EVIDENCE_SELECT] Select the clues showing acceptance held on the retest.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Former support rejects price
Selling resumes after the retest
Price reclaims the range
Buyers clear the nearby offer
WHY: The interaction must match the evidence required by this specific setup.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
SKILL: breakout_and_breakdown_retests
CHART: breakoutRetest
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

[LIVE_CHART] What does the developing response support?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
SKILL: breakout_and_breakdown_retests
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[TAP_CANDLE] Tap the defended retest.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
SKILL: breakout_and_breakdown_retests
CHART: breakoutRetest
TARGET: 2
WHY: Price response distinguishes rejection from acceptance.

[MATCH] Match each clue.
SKILL: breakout_and_breakdown_retests
Breakdown Retest => Resistance on retest
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[MC] What's the strongest conclusion?
VISUAL: Price breaks support, returns to test it from below, then reacts lower.
SKILL: breakout_and_breakdown_retests
CHART: breakdownRetest
A rejected retest can confirm a breakdown
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: A rejected retest can confirm a breakdown.

NODE 52
TITLE: Chasing, Confirmation & Common Misconceptions
TYPE: STANDARD
CELEBRATION: Chasing, Confirmation & Common Misconceptions complete.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price opens well above the prior trading area with little activity between the two zones. The candles are tappable and the learner must select the requested candle.
SKILL: chasing_confirmation_common_misconceptions
CHART: gapUp
TARGET: 4
WHY: The selected candle shows whether execution produced follow through.

[TF] A large visible wall guarantees a reversal.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: chasing_confirmation_common_misconceptions
CHART: resistanceRejection
ANSWER: False
WHY: Walls can trade pull or fail.

[EVIDENCE_SELECT] Select the clues still missing before acceptance is confirmed.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Sustained trade above the level
A hold or successful retest
One fast buy print
A single wide candle
WHY: The interaction must match the evidence required by this specific setup.

[TF] Fast tape guarantees a breakout.
VISUAL: Price pushes through a visible resistance level with expanding bullish candles.
SKILL: chasing_confirmation_common_misconceptions
CHART: breakout
ANSWER: False
WHY: Speed needs acceptance and follow through.

[MC] What best connects the evidence?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
SKILL: chasing_confirmation_common_misconceptions
CHART: gapUp
Late entries carry worse risk and reward
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Late entries carry worse risk and reward.

[MC] Positive delta appears but price cannot rise. What is the best explanation?
VISUAL: A small candle body with a long upper wick shows rejection of higher prices.
SKILL: chasing_confirmation_common_misconceptions
CHART: shootingStar
Buying may be absorbed by passive sellers
Positive delta guarantees delayed upside
The chart invalidates all tape data
WHY: Aggressive buying without progress can reveal seller absorption.

[ORDER] Build the read.
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
SKILL: market_sequence
CHART: gapUp
Observe the order book
Compare trades with liquidity
Wait for price confirmation
Manage the risk
WHY: Read pressure, liquidity, price, then confirmation.

NODE 53
TITLE: Breakout Challenge
TYPE: STANDARD
CELEBRATION: Breakout Challenge complete.

[REPLAY_COMPARE] Which replay has genuine acceptance?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[EVIDENCE_SELECT] Select the clues showing price accepted above resistance.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Buying persists above the level
Price holds above resistance
Price immediately returns inside
The offer keeps rejecting price
WHY: The interaction must match the evidence required by this specific setup.

[REPLAY_COMPARE] Which replay traps breakout buyers?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay B
Replay A
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[REPLAY_COMPARE] Which replay shows a defended break?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[LIVE_CHART] What does follow through add?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
SKILL: breakout_challenge
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[LIVE_CHART] Which price behavior supports the read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
SKILL: breakout_challenge
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[LIVE_CHART] What changed in price response?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
SKILL: breakout_challenge
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher. The candles are tappable and the learner must select the requested candle.
SKILL: breakout_challenge
CHART: breakoutRetest
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

NODE 54
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
SKILL: boss_battle_breakout_or_failure
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
SKILL: boss_battle_breakout_or_failure
CHART: resistanceRejection
Price returns below resistance
Tape stays fast
Delta stays positive
WHY: Returning inside shows failed acceptance.

[MC] What invalidates the breakdown?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: boss_battle_breakout_or_failure
CHART: supportBounce
Price returns above support
Tape stays fast
Delta stays negative
WHY: Returning inside shows failed acceptance.

[MC] Why wait for a retest?
SKILL: boss_battle_breakout_or_failure
To observe continued acceptance
To guarantee profit
To avoid all slippage
WHY: A retest can reveal whether the level now holds.

[ORDERFLOW_SIM] What's the strongest read?
VISUAL: Price approaches resistance, offers thin and are consumed, buyer initiated prints persist, stacked ask side execution appears, and price holds above the broken level.
SKILL: multi_signal_read
Accepted breakout
Liquidity sweep
Not enough trading
WHY: Pressure persists and price holds beyond.


UNIT 8 — Pullbacks and Continuation
TIER: Advanced

NODE 55
TITLE: Healthy Pullbacks & Pullback Depth
TYPE: STANDARD
CELEBRATION: Healthy Pullbacks & Pullback Depth complete.

[EVIDENCE_SELECT] Select the two strongest clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Shallow pullback
Trend pressure returns
Counter pressure accelerates
Key level fails
WHY: Advanced continuation requires structure plus confirming execution evidence.

[MC] How should this be interpreted?
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
SKILL: healthy_pullbacks_pullback_depth
CHART: ascendingChannel
Shallow defended pullbacks show trend strength
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Shallow defended pullbacks show trend strength.

[EVIDENCE_SELECT] Select the two continuation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Structure remains intact
Trend pressure returns
Counter pressure accelerates
The key level fails
WHY: Advanced reads combine at least two aligned evidence sources.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary. The learner draws directly between two candles to mark the structure.
SKILL: healthy_pullbacks_pullback_depth
CHART: ascendingChannel
TARGET: 0 => 3
WHY: Structure supplies location. Execution evidence supplies the read.

[MATCH] Match each clue.
SKILL: healthy_pullbacks_pullback_depth
Healthy Pullbacks => Lighter selling
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

[FOOTPRINT_TAP] Tap the most balanced execution row.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
SKILL: footprint_interaction
EVENT: balanced_target
TARGET: 1
WHY: The selected row contains the requested execution profile.

NODE 56
TITLE: Bullish vs. Bearish Pullbacks
TYPE: STANDARD
CELEBRATION: Bullish vs. Bearish Pullbacks complete.

[EVIDENCE_SELECT] Select the two continuation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Structure remains intact
Trend pressure returns
Counter pressure accelerates
The key level fails
WHY: Continuation needs intact structure plus returning trend pressure.

[TIME_SALES] Which tape clue supports continuation?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Seller prints regain persistence
Buy prints accelerate at support
Trade pace becomes balanced
WHY: Use completed executions to judge whether trend pressure returned.

[LIVE_CHART] Which price behavior supports the read?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
SKILL: bullish_vs_bearish_pullbacks
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MC] What's the most reasonable read?
VISUAL: A sharp decline pauses in a small upward sloping channel before sellers test control again.
SKILL: bullish_vs_bearish_pullbacks
CHART: bearFlag
Bearish continuation begins when sellers return
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Bearish continuation begins when sellers return.

[MATCH] Match each clue.
SKILL: bullish_vs_bearish_pullbacks
Seller Pullback => Lighter buying
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[MC] What does the response suggest?
VISUAL: Each rebound ends below the previous high while price continues making lower lows.
SKILL: bullish_vs_bearish_pullbacks
CHART: lowerHighsDowntrend
A bearish pullback shows weaker buying
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: A bearish pullback shows weaker buying.

NODE 57
TITLE: Continuation Triggers
TYPE: STANDARD
CELEBRATION: Continuation Triggers complete.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
SKILL: continuation_triggers
CHART: bullFlag
TARGET: 0 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[EVIDENCE_SELECT] Select the two continuation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Structure remains intact
Trend pressure returns
Counter pressure accelerates
The key level fails
WHY: Continuation needs intact structure plus returning trend pressure.

[MC] Which read is best supported?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
SKILL: continuation_triggers
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

[MC] What is the best way to interpret Continuation Triggers?
SKILL: continuation_triggers
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 58
TITLE: Order Flow at VWAP & Moving Averages
TYPE: STANDARD
CELEBRATION: Order Flow at VWAP & Moving Averages complete.

[EVIDENCE_SELECT] Select the two strongest clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
VWAP holds as location
Trend aggression returns
Price loses VWAP
Counter tape accelerates
WHY: Advanced continuation requires structure plus confirming execution evidence.

[MC] What does the evidence support?
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
SKILL: order_flow_at_vwap_moving_averages
CHART: priceAboveMA
The average provides location but execution evidence determines the read
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: The average provides location but execution evidence determines the read.

[LIVE_CHART] What changed in price response?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
SKILL: order_flow_at_vwap_moving_averages
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[EVIDENCE_SELECT] Select the two continuation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Structure remains intact
Trend pressure returns
Counter pressure accelerates
The key level fails
WHY: Continuation needs intact structure plus returning trend pressure.

[MC] What's the best read?
VISUAL: Candles trade above the VWAP line while pullbacks test it as potential support.
SKILL: order_flow_at_vwap_moving_averages
CHART: priceAboveVWAP
VWAP provides location while order flow determines the response
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: VWAP provides location while order flow determines the response.

[MATCH] Match each clue.
SKILL: order_flow_at_vwap_moving_averages
Order Flow at a Moving Average => Aggression near the average
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[FOOTPRINT_TAP] Tap the busiest row near VWAP.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
SKILL: footprint_interaction
EVENT: total_target
TARGET: 2
WHY: The selected row contains the requested execution profile.

NODE 59
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

[EVIDENCE_SELECT] Select the two strongest evidence checks for Pullback Failure.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Pullback Failure?
SKILL: pullback_failure
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 60
TITLE: Conflicting Signals
TYPE: STANDARD
CELEBRATION: Conflicting Signals complete.

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
SKILL: conflicting_signals
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

NODE 61
TITLE: Volume Context: Chop vs. Low Volume Trend
TYPE: STANDARD
CELEBRATION: Volume Context: Chop vs. Low Volume Trend complete.

[TIME_SALES] What defines the tape?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Fast two sided execution
Tape speed confirms acceptance
One print resolves the read
WHY: High volume without directional progress can show two sided absorption.

[TIME_SALES] What does the tape show?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Steady movement without urgent prints
Tape speed confirms acceptance
One print resolves the read
WHY: A trend can travel on low volume when little liquidity opposes it.

[FOOTPRINT] What does the footprint add?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Heavy volume without directional progress
The largest cell decides direction
Volume guarantees a trend
WHY: High volume without directional progress can show two sided absorption.

[FOOTPRINT] Is execution strongly directional?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
No. Thin opposition still allows travel
The largest cell decides direction
Volume guarantees a trend
WHY: A trend can travel on low volume when little liquidity opposes it.

[MC] What best connects the evidence?
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction.
SKILL: volume_context_chop_vs_low_volume_trend
CHART: range
High volume without directional progress can show two sided absorption
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: High volume without directional progress can show two sided absorption.

[MC] Which read needs fewer assumptions?
VISUAL: Candles climb between two rising parallel boundaries with pullbacks holding the lower boundary.
SKILL: volume_context_chop_vs_low_volume_trend
CHART: ascendingChannel
Thin opposition can allow a low volume trend
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: A trend can travel on low volume when little liquidity opposes it.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Candles rotate between clear upper and lower boundaries without sustained direction. The candles are tappable and the learner must select the requested candle.
SKILL: volume_context_chop_vs_low_volume_trend
CHART: range
TARGET: 0
WHY: The selected candle shows whether execution produced follow through.

NODE 62
TITLE: Confirmation & Continuation Challenge
TYPE: STANDARD
CELEBRATION: Confirmation & Continuation Challenge complete.

[EVIDENCE_SELECT] Select the two strongest clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Trend side aggression
Confirming price response
One isolated print
An untested wall
WHY: Advanced continuation requires structure plus confirming execution evidence.

[MC] How should this be interpreted?
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again.
SKILL: confirmation_continuation_challenge
CHART: bullFlag
Continuation needs structure and renewed pressure
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Continuation needs structure and renewed pressure.

[ORDERFLOW_SIM] Book tape and price response disagree. What is strongest?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
The evidence conflicts so no directional read is confirmed
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: When evidence conflicts the strongest conclusion may be no clear read.

[EVIDENCE_SELECT] Select the two continuation clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Structure remains intact
Trend pressure returns
Counter pressure accelerates
The key level fails
WHY: Continuation needs intact structure plus returning trend pressure.

[TRENDLINE] Mark the structure that provides location for the order flow read.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
SKILL: confirmation_continuation_challenge
CHART: bullFlag
TARGET: 0 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[MC] What matters most here?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
SKILL: confirmation_continuation_challenge
CHART: spinningTop
Conflicting evidence means no confirmed read
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: When evidence conflicts the strongest conclusion may be no clear read.

[LIVE_CHART] Which price behavior supports the read?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
SKILL: confirmation_continuation_challenge
DIRECTION: sideways
Price is not gaining directional acceptance
Upward price response is developing
Downward price response is developing
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Match each clue.
SKILL: confirmation_continuation_challenge
Entry After Confirmation => Pressure returns
Fast tape without progress => Urgency without confirmation
Sweep => Liquidity taken followed by rejection
WHY: Match the signal with its order flow clue.

NODE 63
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
SKILL: boss_battle_continue_fail_or_wait
CHART: priceAboveVWAP
Execution response at the level
VWAP guarantees support
Candle color alone
WHY: VWAP gives location; flow gives the read.

[MC] What matters at the average?
VISUAL: Candles hold above a rising moving average and react near it during pullbacks.
SKILL: boss_battle_continue_fail_or_wait
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

NODE 64
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

[EVIDENCE_SELECT] Select the two strongest evidence checks for Reversal Pressure.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Reversal Pressure?
SKILL: reversal_pressure
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 65
TITLE: Buyer Traps vs. Seller Traps
TYPE: STANDARD
CELEBRATION: Buyer Traps vs. Seller Traps complete.

[TIME_SALES] What shows buyers became trapped?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Buy prints fail above resistance
A large opposing print outweighs the executions that follow
Price location is unnecessary once a reversal candle closes
WHY: A buyer trap forms when a breakout fails.

[TIME_SALES] What shows sellers became trapped?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Sell prints fail below support
The candle pattern identifies every initiating trade
The earliest pressure cannot be contradicted later
WHY: A seller trap forms when a breakdown fails.

[FOOTPRINT] What contradicts the positive delta?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Price returns below resistance
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[FOOTPRINT] What contradicts the negative delta?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Price returns above support
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

[REPLAY_COMPARE] Which replay trapped sellers?
VISUAL: Replay A trades through a level and rejects immediately without acceptance. Replay B trades through with persistent execution and holds beyond the level.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: The rejected break fails to gain acceptance and traps the initiating side.

NODE 66
TITLE: Exhaustion Reversals
TYPE: STANDARD
CELEBRATION: Exhaustion Reversals complete.

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
SKILL: exhaustion_reversals
CHART: doji
Exhaustion can prepare a reversal
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Exhaustion can prepare a reversal.

[EVIDENCE_SELECT] Select the two strongest evidence checks for Exhaustion Reversals.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Exhaustion Reversals?
SKILL: exhaustion_reversals
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 67
TITLE: Absorption Reversals
TYPE: STANDARD
CELEBRATION: Absorption Reversals complete.

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
SKILL: absorption_reversals
CHART: rejectionWickDown
Absorbed selling can support a reversal
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Absorbed selling can support a reversal.

[EVIDENCE_SELECT] Select the two strongest evidence checks for Absorption Reversals.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret Absorption Reversals?
SKILL: absorption_reversals
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 68
TITLE: Double Top vs. Double Bottom Flow
TYPE: STANDARD
CELEBRATION: Double Top vs. Double Bottom Flow complete.

[TIME_SALES] How does the second test differ?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints dominating at the ask.
SKILL: tape_reading
EVENT: lift
Buyer urgency is weaker
A large opposing print outweighs the executions that follow
Price location is unnecessary once a reversal candle closes
WHY: Repeated failure can shift control to sellers.

[TIME_SALES] Which side weakens on the retest?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Aggressive sellers
The candle pattern identifies every initiating trade
The earliest pressure cannot be contradicted later
WHY: Repeated failure can shift control to buyers.

[FOOTPRINT] What changes on the retest?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Seller response strengthens
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[FOOTPRINT] What changes on the second test?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Buyer response strengthens
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] What's the strongest conclusion?
VISUAL: Price tests the same resistance area twice and retreats after the second test.
SKILL: double_top_vs_double_bottom_flow
CHART: doubleTop
Repeated failure can shift control to sellers
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Repeated failure can shift control to sellers.

[MC] What best connects the evidence?
VISUAL: Price tests the same support area twice and rebounds after the second test.
SKILL: double_top_vs_double_bottom_flow
CHART: doubleBottom
Repeated failure can shift control to buyers
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Repeated failure can shift control to buyers.

NODE 69
TITLE: Reversal Confirmation & Insufficient Evidence
TYPE: STANDARD
CELEBRATION: Reversal Confirmation & Insufficient Evidence complete.

[TIME_SALES] What confirms the reversal?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Opposing prints gain follow through
A rejection wick proves passive absorption
The second test should inherit the first test's order flow
WHY: Confirmation reduces premature reversal entries.

[ORDERFLOW_SIM] Which evidence source prevents an immediate reversal conclusion?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
Aggression and price response still conflict
The candle pattern guarantees confirmation
Positive delta makes location irrelevant
WHY: A reversal needs a control change and confirming response.

[FOOTPRINT] What must execution produce?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
A confirming price response
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[TIME_SALES] What completes the reversal read?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Control change plus confirmation
Positive delta confirms a reversal regardless of price response
Slower tape guarantees the opposing side has control
WHY: A reversal needs control change and confirmation.

[MC] Which read needs fewer assumptions?
VISUAL: A large bullish candle covers the prior bearish body after an attempted decline.
SKILL: reversal_confirmation_insufficient_evidence
CHART: bullishEngulfing
Confirmation reduces premature reversal entries
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Confirmation reduces premature reversal entries.

[FOOTPRINT] What does the footprint verify?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Aggressive control changed
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[MC] What matters most here?
VISUAL: Three troughs form with the middle trough deepest before price challenges the neckline.
SKILL: reversal_confirmation_insufficient_evidence
CHART: inverseHeadShoulders
A reversal needs control change and confirmation
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: A reversal needs control change and confirmation.

NODE 70
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

[MC] What matters on the second high test?
VISUAL: Price tests the same resistance area twice and retreats after the second test.
SKILL: boss_battle_trap_or_reversal
CHART: doubleTop
Weaker buying and stronger defense
The shape alone
Equal candle colors
WHY: Compare execution and response across tests.

[MC] What matters on the second low test?
VISUAL: Price tests the same support area twice and rebounds after the second test.
SKILL: boss_battle_trap_or_reversal
CHART: doubleBottom
Weaker selling and stronger defense
The shape alone
Equal candle colors
WHY: Compare execution and response across tests.

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
SKILL: boss_battle_trap_or_reversal
Until control and response align
Until one large print
Until any wick appears
WHY: Expert reversal reads require confirmation.


UNIT 10 — Execution and Risk
TIER: Expert

NODE 71
TITLE: Planning the Entry & Choosing the Order Type
TYPE: STANDARD
CELEBRATION: Planning the Entry & Choosing the Order Type complete.

[MC] Which conclusion fits the response?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: planning_the_entry_choosing_the_order_type
CHART: breakoutRetest
A clear trigger keeps execution disciplined
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: A clear trigger keeps execution disciplined.

[MC] How should this be interpreted?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: planning_the_entry_choosing_the_order_type
CHART: sideways
Order choice balances speed with price control
Thin liquidity implies the move has strong aggressive sponsorship
Negative delta prevents price from rising
Refreshing bids matter only after sellers stop trading
WHY: Order choice balances speed with price control.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Defined trigger
Confirming response
One fast print
Candle color
WHY: Expert execution decisions combine market evidence with risk.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
SKILL: planning_the_entry_choosing_the_order_type
CHART: sideways
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

[REPLAY_COMPARE] Which replay shows a confirmed trigger?
VISUAL: Replay A reaches the trigger level, shows confirming execution, and price responds. Replay B shows one fast print, no meaningful confirmation, and stalled price.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: Replay A reaches the trigger, confirms it, and produces a price response.

[MC] What tradeoff guides order choice?
SKILL: planning_the_entry_choosing_the_order_type
Speed versus price control
Candle color versus volume
Bid size versus chart scale
WHY: Market and limit orders trade speed against control of execution price.

NODE 72
TITLE: Slippage & Thin Liquidity Risk
TYPE: STANDARD
CELEBRATION: Slippage & Thin Liquidity Risk complete.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Thin nearby depth
Widening spread
Positive delta
A resting wall far away
WHY: Expert execution decisions combine market evidence with risk.

[ORDER] Build the decision sequence.
SKILL: market_sequence
Inspect nearby depth
Estimate slippage risk
Reduce size if needed
Define invalidation
WHY: Order flow decisions move from evidence to response and risk.

[BOOK_COMPARE] Which book creates greater slippage risk?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B
Book A
Both equally
WHY: Book B has thinner nearby depth and gaps.

[MC] What's the most reasonable read?
VISUAL: Candles expand in range as the surrounding volatility bands spread farther apart.
SKILL: slippage_thin_liquidity_risk
CHART: bandsWidening
Thin liquidity can require smaller risk and more cautious execution
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Thin liquidity can require smaller risk and more cautious execution.

[MC] What does the response suggest?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: slippage_thin_liquidity_risk
CHART: volatile
Thin liquidity can increase slippage
A failed breakout is confirmed before price returns through the level
More displayed depth necessarily means more actual liquidity
A second test should be read the same way as the first
WHY: Thin liquidity can increase slippage.

NODE 73
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

[MC] Which read is best supported?
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: order_flow_invalidation
CHART: supportBounce
Beyond the level that disproves the read
Large executions are directional even when price does not respond
A moving average reaction can substitute for execution evidence
Balanced delta means neither side traded aggressively
WHY: Risk belongs beyond the evidence that would invalidate the order flow read.

[ORDER] Build the read.
VISUAL: A decline reaches support and rebounds with buyers defending the lower area.
SKILL: market_sequence
CHART: supportBounce
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

[MC] What is the best way to interpret Order Flow Invalidation?
SKILL: order_flow_invalidation
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 74
TITLE: No Clear Read
TYPE: STANDARD
CELEBRATION: No Clear Read complete.

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
SKILL: no_clear_read
CHART: spinningTop
Conflicting evidence is a valid reason to stay out
Displayed liquidity is stronger evidence than completed executions
A short aggressive burst can outweigh a stalled price response
The candle response makes tape confirmation optional
WHY: Conflicting evidence is a valid reason to stay out.

[MC] What does conflicting evidence suggest?
SKILL: no_clear_read
No clear read yet
Follow the fastest signal
Ignore price response
WHY: Conflicting evidence supports patience rather than a forced conclusion.

[EVIDENCE_SELECT] Select the two strongest evidence checks for No Clear Read.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution behavior
Confirming price response
Candle color alone
A company profile
WHY: The read needs executed activity and the price response it produces.

[MC] What is the best way to interpret No Clear Read?
SKILL: no_clear_read
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 75
TITLE: Exiting Into Liquidity
TYPE: STANDARD
CELEBRATION: Exiting Into Liquidity complete.

[MC] What does the evidence support?
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: exiting_into_liquidity
CHART: resistanceRejection
Liquidity can improve planned exits
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Liquidity can improve planned exits.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Available opposing liquidity
Current execution pace
Candle color
Moving average slope
WHY: Expert execution decisions combine market evidence with risk.

[MARK_LEVEL] Mark the opposing liquidity relevant to the exit.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: liquidity_location
CHART: resistanceRejection
WHY: Nearby opposing liquidity is more relevant than a distant level.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The candles are tappable and the learner must select the requested candle.
SKILL: exiting_into_liquidity
CHART: resistanceRejection
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

[MC] What is the best way to interpret Exiting Into Liquidity?
SKILL: exiting_into_liquidity
Combine location, execution, and response
Treat one print as confirmation
Assume displayed size cannot change
WHY: Order flow conclusions are strongest when several evidence sources align.

NODE 76
TITLE: Reviewing the Full Order Flow Read
TYPE: STANDARD
CELEBRATION: Reviewing the Full Order Flow Read complete.

[MC] Which explanation fits best?
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area.
SKILL: reviewing_the_full_order_flow_read
CHART: sideways
Review each evidence source separately from the trade outcome
High total volume normally implies strongly directional delta
A large wall deserves more weight than repeated fills against it
One unusually large trade is more reliable than subsequent response
WHY: Review each evidence source separately from the trade outcome.

[ORDERFLOW_SIM] Who is aggressive?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Buyers lifting offers
Sellers hitting bids
Neither side trading
WHY: Buyer initiated prints dominate the tape.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: Small mixed candles overlap inside a narrow horizontal trading area. The candles are tappable and the learner must select the requested candle.
SKILL: reviewing_the_full_order_flow_read
CHART: sideways
TARGET: 1
WHY: The selected candle shows whether execution produced follow through.

[ORDERFLOW_SIM] Where is liquidity defending?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
At the refreshing offer
Below the distant bid
No liquidity is visible
WHY: The offer repeatedly replenishes after fills.

[REPLAY_COMPARE] Which replay shows acceptance?
VISUAL: Replay A shows offers clearing and price holding above resistance. Replay B shows replenishment and price falling back inside.
SKILL: scenario_comparison
Replay A
Replay B
Neither replay
WHY: Replay A clears offers and holds above the level. Replay B refreshes and rejects.

[ORDERFLOW_SIM] Is buying moving price?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
No. Price is stalling
Yes. Price is accepting higher
Price response is irrelevant
WHY: Aggression is strong, but upward progress remains weak.

[ORDERFLOW_SIM] Which clue conflicts with delta?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Price stalls at resistance
Buyer prints stay fast
Ask volume stays positive
WHY: Positive delta conflicts with the lack of upward price progress.

[ORDERFLOW_SIM] What's the strongest read?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Possible seller absorption
Confirmed buyer continuation
Guaranteed reversal
WHY: Refreshing offers and stalled price support possible seller absorption.

NODE 77
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
Response is irrelevant
WHY: Aggression makes little progress.

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
WHY: Refreshing offers and stalled price support absorption.

[ORDERFLOW_SIM] What invalidates the read?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Price accepts above resistance
Another buy print
Stable spread
WHY: Acceptance higher invalidates seller absorption.

[ORDERFLOW_SIM] What execution risk is present?
VISUAL: A championship replay combines price and VWAP, changing Level II liquidity, Time and Sales, and footprint delta so the learner must weigh all four evidence sources.
SKILL: multi_signal_read
Slippage near changing depth
No execution risk
Guaranteed fill price
WHY: Fast activity and changing depth increase slippage.

[BOOK_COMPARE] Which book shows thinner liquidity?
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
COMPETENCY BLUEPRINT: u1.aggressive_buyer, u1.aggressive_seller, u1.market_buy_routing, u1.market_sell_routing, u1.spread, u1.aggressive_vs_passive, u1.order_price_chain, u1.combined_read
COMPETENCY MAPPINGS: u1.aggressive_buyer => aggressor_side, lifting_the_offer_hitting_the_bid; u1.aggressive_seller => aggressor_side, lifting_the_offer_hitting_the_bid; u1.market_buy_routing => lifting_the_offer_hitting_the_bid, order_routing; u1.market_sell_routing => aggressor_side, lifting_the_offer_hitting_the_bid; u1.spread => the_bid_ask_spread; u1.aggressive_vs_passive => aggressive_vs_passive_orders; u1.order_price_chain => aggressor_side, lifting_the_offer_hitting_the_bid; u1.combined_read => what_is_order_flow
JUMP QUESTIONS: N/A
JUMP PASSING SCORE: N/A
JUMP PREREQUISITES: N/A

UNIT 2
QUESTIONS PER ATTEMPT: 8
PASSING SCORE: 7
POOL SIZE: 16
COMPETENCY BLUEPRINT: u2.level_two, u2.resting_sides, u2.thick_liquidity, u2.thin_liquidity, u2.wall, u2.wall_behavior, u2.spoofing, u2.combined_book_read
COMPETENCY MAPPINGS: u2.level_two => reading_the_order_book; u2.resting_sides => reading_the_order_book; u2.thick_liquidity => size_liquidity; u2.thin_liquidity => size_liquidity; u2.wall => book_depth, large_orders_as_walls; u2.wall_behavior => large_orders_as_walls; u2.spoofing => pulling_replenishment_spoofing, scenario_comparison; u2.combined_book_read => order_book_challenge
JUMP QUESTIONS: 8
JUMP PASSING SCORE: 7
JUMP PREREQUISITES: u1.market_buy_routing, u1.combined_read, u1.aggressive_seller, u1.market_sell_routing

UNIT 3
QUESTIONS PER ATTEMPT: 9
PASSING SCORE: 8
POOL SIZE: 18
COMPETENCY BLUEPRINT: u3.buyer_initiated, u3.seller_initiated, u3.large_print, u3.tape_speed, u3.persistent_aggression, u3.sequence_break, u3.false_urgency, u3.price_confirmation, u3.combined_tape_read
COMPETENCY MAPPINGS: u3.buyer_initiated => tape_reading; u3.seller_initiated => tape_interaction; u3.large_print => tape_reading; u3.tape_speed => tape_interaction; u3.persistent_aggression => tape_interaction, tape_reading; u3.sequence_break => evidence_synthesis, repeated_prints_sequence_breaks; u3.false_urgency => tape_reading; u3.price_confirmation => tape_interaction, tape_reading; u3.combined_tape_read => tape_reading
JUMP QUESTIONS: 10
JUMP PASSING SCORE: 8
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u2.combined_book_read, u1.aggressive_seller, u2.resting_sides

UNIT 4
QUESTIONS PER ATTEMPT: 9
PASSING SCORE: 8
POOL SIZE: 18
COMPETENCY BLUEPRINT: u4.absorption, u4.buyer_absorption, u4.seller_absorption, u4.repeated_tests, u4.hidden_liquidity, u4.buyer_exhaustion, u4.seller_exhaustion, u4.absorption_vs_exhaustion, u4.combined_absorption_read
COMPETENCY MAPPINGS: u4.absorption => multi_signal_read, tape_reading; u4.buyer_absorption => multi_signal_read, tape_reading; u4.seller_absorption => buyer_vs_seller_absorption, tape_reading; u4.repeated_tests => multi_signal_read, tape_reading; u4.hidden_liquidity => multi_signal_read, repeated_tests_hidden_liquidity; u4.buyer_exhaustion => tape_interaction, tape_reading; u4.seller_exhaustion => evidence_synthesis, footprint_reading; u4.absorption_vs_exhaustion => tape_reading; u4.combined_absorption_read => multi_signal_read
JUMP QUESTIONS: 12
JUMP PASSING SCORE: 10
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u3.combined_tape_read, u1.aggressive_seller, u2.resting_sides

UNIT 5
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20
COMPETENCY BLUEPRINT: u5.footprint_basics, u5.diagonal_imbalance, u5.buyer_imbalance, u5.seller_imbalance, u5.stacked_pressure, u5.momentum_failure, u5.delta_vs_volume, u5.positive_delta_divergence, u5.negative_delta_divergence, u5.combined_footprint_read
COMPETENCY MAPPINGS: u5.footprint_basics => footprint_reading; u5.diagonal_imbalance => footprint_interaction; u5.buyer_imbalance => footprint_interaction, footprint_reading; u5.seller_imbalance => footprint_interaction; u5.stacked_pressure => footprint_interaction, footprint_reading; u5.momentum_failure => footprint_interaction, footprint_reading; u5.delta_vs_volume => footprint_reading; u5.positive_delta_divergence => footprint_reading, positive_vs_negative_delta_divergence; u5.negative_delta_divergence => footprint_interaction, positive_vs_negative_delta_divergence; u5.combined_footprint_read => footprint_interaction, footprint_reading
JUMP QUESTIONS: 14
JUMP PASSING SCORE: 12
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u4.combined_absorption_read, u1.aggressive_seller, u2.resting_sides

UNIT 6
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20
COMPETENCY BLUEPRINT: u6.liquidity_pool, u6.stop_cluster, u6.buy_stops, u6.sell_stops, u6.upside_sweep, u6.downside_sweep, u6.sweep_vs_acceptance, u6.book_depth, u6.iceberg, u6.combined_liquidity_read
COMPETENCY MAPPINGS: u6.liquidity_pool => book_depth, evidence_synthesis; u6.stop_cluster => liquidity_pools_stop_clusters; u6.buy_stops => buy_stops_vs_sell_stops, liquidity_location; u6.sell_stops => buy_stops_vs_sell_stops, evidence_synthesis; u6.upside_sweep => upside_vs_downside_sweeps; u6.downside_sweep => evidence_synthesis, upside_vs_downside_sweeps; u6.sweep_vs_acceptance => evidence_synthesis, scenario_comparison; u6.book_depth => book_depth, thin_vs_thick_liquidity; u6.iceberg => evidence_synthesis, multi_signal_read; u6.combined_liquidity_read => evidence_synthesis, multi_signal_read
JUMP QUESTIONS: 14
JUMP PASSING SCORE: 12
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u5.combined_footprint_read, u1.aggressive_seller

UNIT 7
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20
COMPETENCY BLUEPRINT: u7.breakout_pressure, u7.breakdown_pressure, u7.acceptance_above, u7.acceptance_below, u7.failed_breakout, u7.failed_breakdown, u7.breakout_retest, u7.breakdown_retest, u7.sweep_vs_breakout, u7.combined_breakout_read
COMPETENCY MAPPINGS: u7.breakout_pressure => breakout_vs_breakdown_pressure, scenario_comparison; u7.breakdown_pressure => breakout_vs_breakdown_pressure, evidence_synthesis; u7.acceptance_above => acceptance_above_vs_below, evidence_synthesis; u7.acceptance_below => acceptance_above_vs_below, evidence_synthesis; u7.failed_breakout => failed_breakouts_vs_failed_breakdowns, scenario_comparison; u7.failed_breakdown => evidence_synthesis, failed_breakouts_vs_failed_breakdowns; u7.breakout_retest => evidence_synthesis, scenario_comparison; u7.breakdown_retest => breakout_and_breakdown_retests; u7.sweep_vs_breakout => chasing_confirmation_common_misconceptions; u7.combined_breakout_read => evidence_synthesis, scenario_comparison
JUMP QUESTIONS: 16
JUMP PASSING SCORE: 13
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u6.sweep_vs_acceptance, u6.combined_liquidity_read, u1.aggressive_seller

UNIT 8
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20
COMPETENCY BLUEPRINT: u8.healthy_pullback, u8.pullback_depth, u8.continuation_trigger, u8.bearish_continuation, u8.flow_at_vwap, u8.flow_at_average, u8.pullback_failure, u8.conflicting_signals, u8.volume_context, u8.no_clear_read
COMPETENCY MAPPINGS: u8.healthy_pullback => evidence_synthesis, healthy_pullbacks_pullback_depth; u8.pullback_depth => evidence_synthesis, healthy_pullbacks_pullback_depth; u8.continuation_trigger => continuation_triggers, evidence_synthesis; u8.bearish_continuation => evidence_synthesis, tape_reading; u8.flow_at_vwap => evidence_synthesis, order_flow_at_vwap_moving_averages; u8.flow_at_average => evidence_synthesis, order_flow_at_vwap_moving_averages; u8.pullback_failure => pullback_failure; u8.conflicting_signals => footprint_reading, tape_reading; u8.volume_context => tape_reading; u8.no_clear_read => confirmation_continuation_challenge, evidence_synthesis
JUMP QUESTIONS: 16
JUMP PASSING SCORE: 13
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u6.sweep_vs_acceptance, u7.failed_breakdown, u7.combined_breakout_read

UNIT 9
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20
COMPETENCY BLUEPRINT: u9.reversal_pressure, u9.buyer_trap, u9.seller_trap, u9.buyer_exhaustion_reversal, u9.seller_exhaustion_reversal, u9.absorption_reversal, u9.double_top_flow, u9.double_bottom_flow, u9.reversal_confirmation, u9.insufficient_evidence
COMPETENCY MAPPINGS: u9.reversal_pressure => footprint_reading, tape_reading; u9.buyer_trap => tape_reading; u9.seller_trap => footprint_reading; u9.buyer_exhaustion_reversal => footprint_reading, tape_reading; u9.seller_exhaustion_reversal => evidence_synthesis, exhaustion_reversals; u9.absorption_reversal => footprint_reading, tape_reading; u9.double_top_flow => tape_reading; u9.double_bottom_flow => footprint_reading; u9.reversal_confirmation => multi_signal_read, tape_reading; u9.insufficient_evidence => footprint_reading, tape_reading
JUMP QUESTIONS: 18
JUMP PASSING SCORE: 15
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u6.sweep_vs_acceptance, u7.failed_breakdown, u8.pullback_failure, u8.no_clear_read

UNIT 10
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 20
COMPETENCY BLUEPRINT: u10.entry_plan, u10.order_type, u10.slippage, u10.invalidation, u10.thin_liquidity_risk, u10.no_clear_read, u10.exit_liquidity, u10.review_process, u10.multi_source_evidence, u10.combined_execution_read
COMPETENCY MAPPINGS: u10.entry_plan => planning_the_entry_choosing_the_order_type; u10.order_type => evidence_synthesis, planning_the_entry_choosing_the_order_type; u10.slippage => evidence_synthesis, market_sequence; u10.invalidation => evidence_synthesis, order_flow_invalidation; u10.thin_liquidity_risk => book_depth, slippage_thin_liquidity_risk; u10.no_clear_read => evidence_synthesis, no_clear_read; u10.exit_liquidity => evidence_synthesis, exiting_into_liquidity; u10.review_process => multi_signal_read, reviewing_the_full_order_flow_read; u10.multi_source_evidence => multi_signal_read, reviewing_the_full_order_flow_read; u10.combined_execution_read => multi_signal_read, scenario_comparison
JUMP QUESTIONS: 20
JUMP PASSING SCORE: 16
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u6.sweep_vs_acceptance, u7.failed_breakdown, u8.pullback_failure, u9.reversal_confirmation, u9.insufficient_evidence
