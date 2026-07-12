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

[EVIDENCE_SELECT] Select the three parts of a complete order flow read.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1, 2
Aggressor activity
Available liquidity
Price response
Candle color alone
WHY: A complete read combines who acts, where liquidity sits, and how price responds.

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

NODE 4
TITLE: Lifting the Offer & Hitting the Bid
TYPE: STANDARD
CELEBRATION: Lifting the Offer & Hitting the Bid complete.

[MC] Which action lifts the offer?
SKILL: lifting_offer_hitting_bid
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
SKILL: lifting_offer_hitting_bid
They hit the bid
They post above the ask
They raise the bid
WHY: Aggressive sellers cross the spread and execute against bids.

[MATCH] Match each action.
SKILL: lifting_offer_hitting_bid
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
Available depth across price levels from the relevant venue or feed.
Only the best bid and ask.
Every trade already executed.
WHY: Level II shows available resting depth across prices from the relevant venue or feed.

[MC] Where do resting buy orders sit?
SKILL: reading_the_order_book
The bid side.
The ask side.
The spread.
WHY: Buyers rest on the bid. Sellers rest on the ask, and the spread is the gap between them.

[MC] What does Level I show?
SKILL: reading_the_order_book
Only the best bid and ask.
Available depth across prices from the relevant venue or feed.
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
Level II => Available depth from the relevant venue or feed
Time & Sales => Executed trades
WHY: These lenses show top of book, available feed depth, and completed trades.

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

[MC] A book with large displayed size at every nearby level...
SKILL: size_liquidity
Shows greater displayed liquidity.
Proves every order will remain.
Guarantees low volatility.
WHY: Large displayed size suggests greater displayed liquidity, but orders can change or cancel.

[TF] A thin book moves on fewer orders than a thick one.
SKILL: size_liquidity
ANSWER: True
WHY: Sparse nearby depth can allow less incoming pressure to move price farther.

[MATCH] Match each book to how it moves.
SKILL: size_liquidity
Thick book => Hard to move
Thin book => Easy to move
Resting size => Liquidity at a price
WHY: Depth is what absorbs aggression; without it, price jumps.

[AGGRESSOR] In Size & Liquidity, identify the side consuming resting liquidity.
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
Spoofing => Deceptive order placement intended to mislead
WHY: Cancellation alone is not spoofing. Intent to mislead is central to the definition.

[AGGRESSOR] In Pulling, Replenishment & Spoofing, identify the side consuming resting liquidity.
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Offers being taken means the buyer is the aggressor.

[BOOKDRAG] Route the sell used in Pulling, Replenishment & Spoofing to its execution side.
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

[MC] What does Level II add to the inside bid and ask?
SKILL: order_book_challenge
Resting depth across multiple price levels
Only the last completed trade
Guaranteed future orders
WHY: Level II adds visible resting depth from the relevant feed.

[BOOK_COMPARE] Which book has thinner nearby depth?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B
Book A
Both are equal
WHY: Book B has smaller size and gaps near price.

[BOOKDRAG] Route the market sell to its fill side.
VISUAL: A draggable market sell card sits beside a Level II ladder with bid and ask drop targets.
SKILL: order_routing
ORDER: market_sell
ANSWER: the bid
WHY: A market sell executes against the bid.

[REPLAY_COMPARE] Which replay shows a wall holding rather than pulling?
VISUAL: Replay A shows several uneven waves of selling absorbed by a bid that keeps returning while price holds. Replay B shows the bid thinning and price slipping through.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: Replay A trades, replenishes, and holds price.

[AGGRESSOR] Offers are being consumed. Who is aggressive?
VISUAL: An animated Level II ladder shows prices between bid and ask columns, with ask sizes being consumed by incoming buy orders.
SKILL: aggressor_side
EVENT: lift
ANSWER: The buyer
WHY: Buyers are lifting the offer.

[EVIDENCE_SELECT] Select the three parts of a complete book read.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1, 2
Aggressor activity
Resting liquidity behavior
Price response
Candle color alone
WHY: A complete read combines action, liquidity, and response.

[ORDERFLOW_SIM] Buyers stay aggressive, the offer refreshes, and price stalls. What's strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
The refreshing offer is containing aggressive buying
Price is gaining clean acceptance above the offer
Buyer urgency is clearly fading
WHY: The beginner observation is that replenishing liquidity contains active buying. Unit 4 later names this behavior absorption.

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

[TIME_SALES_TAP] Tap the buyer initiated print that breaks the seller sequence.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with one buyer initiated print at the ask interrupting a seller initiated sequence.
SKILL: tape_interaction
EVENT: buyer_sequence_break
TARGET: 3
WHY: This ask side execution interrupts the seller initiated sequence.

[ORDERFLOW_SIM] Did price confirm the tape?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Price response remains inconclusive
Buyers are fully confirmed
Sellers are fully confirmed
WHY: The composite view shows both executed pressure and the price response used to judge confirmation.

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

[ORDERFLOW_SIM] Did price confirm the tape?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
No. Price barely moved
Yes. Faster tape confirms buyers
Yes. Volatility confirms direction
WHY: The composite view shows both executed pressure and the price response used to judge confirmation.

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

[ORDERFLOW_SIM] Did price confirm the tape?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Price response remains inconclusive
Buyer control is confirmed
Seller control is confirmed
WHY: The composite view shows both executed pressure and the price response used to judge confirmation.

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

[ORDERFLOW_SIM] Did price confirm the tape?
VISUAL: Price approaches resistance, offers thin and are consumed, buyer initiated prints persist, stacked ask side execution appears, and price holds above the broken level. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Yes. Higher prices continued
No. Repetition never matters
Inconclusive despite higher highs
WHY: The composite view shows both executed pressure and the price response used to judge confirmation.

[EVIDENCE_SELECT] Which two clues make repeated prints meaningful?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
One side keeps initiating
Price responds to the sequence
One isolated print
Candle color changes
WHY: Persistence matters when execution produces a matching response.

[MC] What makes a sequence break important?
SKILL: repeated_prints_sequence_breaks
The opposing print changes the established execution pattern
It is always the largest print
It guarantees a reversal
WHY: A sequence break matters when it interrupts persistent aggression.

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

[ORDERFLOW_SIM] Did price confirm the tape?
VISUAL: Price approaches resistance, offers thin and are consumed, buyer initiated prints persist, stacked ask side execution appears, and price holds above the broken level. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Yes. Price expanded higher
No. Pace cannot confirm
Inconclusive after acceptance
WHY: The composite view shows both executed pressure and the price response used to judge confirmation.

[EVIDENCE_SELECT] Select both confirmation clues for Acceleration, Slowdown & False Urgency.
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

[ORDERFLOW_SIM] Did price confirm the tape?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
No. Buying failed at resistance
Yes. Fast buying confirmed control
Inconclusive despite rejection
WHY: The composite view shows both executed pressure and the price response used to judge confirmation.

[EVIDENCE_SELECT] Which two clues make tape activity meaningful at a key level?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution reaches the level
Price shows acceptance or rejection
The session logo changes
A distant candle is large
WHY: Location and response give tape activity context.

[MC] How should fast buying at resistance be interpreted?
SKILL: tape_at_key_levels
Check whether price accepts above or rejects
Assume buyers control the next candle
Ignore the resting offer
WHY: Fast tape needs a confirming response at the level.

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

[ORDERFLOW_SIM] Persistent buyer prints clear offers and price holds higher. Did price confirm the buying?
VISUAL: Price approaches resistance, offers thin and are consumed, buyer initiated prints persist, stacked ask side execution appears, and price holds above the broken level. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Yes. Price advanced and held
No. Price stalled against replenishment
The price response remains inconclusive
WHY: The composite evidence shows both persistent buying and higher accepted prices.

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
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
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

[REPLAY_COMPARE] Which replay shows pressure being absorbed?
VISUAL: Replay A shows varied buy sizes continuing into an offer that replenishes while price stays pinned. Replay B shows both buy size and pace fading before price stalls.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: Replay A keeps aggression active while replenishment prevents progress.

[EVIDENCE_SELECT] Which two clues best support absorption?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Aggressive execution stays active
Price makes little corresponding progress
Aggression disappears
Price accepts cleanly through the level
WHY: Absorption combines continued pressure with weak price progress.

[MC] How should absorption be interpreted?
SKILL: what_is_absorption
Passive liquidity is containing active pressure
Aggression has completely stopped
A reversal is guaranteed
WHY: Absorption describes pressure being contained, not a guaranteed reversal.

NODE 21
TITLE: Buyer vs. Seller Absorption
TYPE: STANDARD
CELEBRATION: Buyer vs. Seller Absorption complete.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
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

[ORDERFLOW_SIM] Sellers keep hitting a refreshing bid while support holds. What's strongest?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Possible buyer absorption
Seller continuation remains favored
Seller exhaustion is proven
WHY: Active selling makes little progress while the bid replenishes.

[ORDERFLOW_SIM] Buyers keep lifting a refreshing offer while resistance holds. What's strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Possible seller absorption
Buyer continuation remains favored
Buyer exhaustion is proven
WHY: Active buying makes little progress while the offer replenishes.

NODE 22
TITLE: Repeated Tests & Hidden Liquidity
TYPE: STANDARD
CELEBRATION: Repeated Tests & Hidden Liquidity complete.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
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
VISUAL: Level II repeatedly shows 100 shares at the offer. Each 100 share execution clears the display, then another 100 immediately reappears at the same price while Time and Sales keeps printing buys. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Displayed size keeps replenishing
Pressure and price accelerate together
No aggressive executions appear
WHY: Absorption requires pressure plus a weak corresponding price response.

[ORDERFLOW_SIM] Repeated selling tests the level, the bid replenishes, and price still holds. What's strongest?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Possible absorption at the defended level
A downside break is confirmed
The visible bid proves every hidden order
WHY: Repeated execution with replenishment and weak downward progress supports possible absorption.

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

[TIME_SALES_TAP] Tap where activity starts losing follow through in What Is Exhaustion.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_interaction
EVENT: stall
TARGET: 6
WHY: Prints continue but size and pace begin fading here.

[TIME_SALES] Which tape change would support exhaustion?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Initiated pace and size fade near the extreme
Aggression accelerates with price progress
Displayed depth alone guarantees reversal
WHY: Exhaustion is visible as aggressive activity itself fades.

[EVIDENCE_SELECT] Which two clues best support exhaustion?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Print pace or size fades
Price stops extending in the original direction
Aggression accelerates
Price accepts farther through the level
WHY: Exhaustion means the initiating pressure itself is fading.

[MC] How should exhaustion be interpreted?
SKILL: what_is_exhaustion
The aggressive side is losing urgency
Passive size must be hidden
The opposing side has guaranteed control
WHY: Exhaustion weakens the prior move but still needs confirmation.

NODE 24
TITLE: Buyer vs. Seller Exhaustion
TYPE: STANDARD
CELEBRATION: Buyer vs. Seller Exhaustion complete.

[TIME_SALES] Which side is losing urgency?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with buyer initiated prints at the ask losing pace and trade size.
SKILL: tape_reading
EVENT: buyer_fading
Aggressive buyers
Aggressive sellers
Neither initiating side
WHY: Buyer initiated prints at the ask visibly lose pace and size.

[TIME_SALES_TAP] Tap where activity starts losing follow through in Buyer vs. Seller Exhaustion.
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_interaction
EVENT: stall
TARGET: 4
WHY: Prints continue but size and pace begin fading here.

[TIME_SALES] Which tape change supports seller exhaustion near a low?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Aggressive seller prints lose pace and size
Seller prints accelerate through support
Buyer initiated prints disappear completely
WHY: Seller exhaustion means the initiating sellers themselves lose urgency.

[EVIDENCE_SELECT] Which two observations identify the exhausting side?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Its initiated prints lose pace
Its price progress weakens
Opposing liquidity disappears
The spread never changes
WHY: Compare each side's urgency with the progress it produces.

[MC] What separates buyer exhaustion from seller exhaustion?
SKILL: buyer_vs_seller_exhaustion
Which initiating side loses pressure
The candle color alone
Whether total volume is high
WHY: Buyer and seller exhaustion mirror each other on opposite sides.

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

[EVIDENCE_SELECT] Which two clues distinguish absorption from exhaustion?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Whether aggression remains strong
Whether price still makes progress
The company sector
The latest candle color
WHY: Absorption keeps pressure active; exhaustion shows that pressure fading.

[MC] Strong aggression continues but price stalls. Which explanation fits?
SKILL: absorption_vs_exhaustion
Absorption
Exhaustion
Clean acceptance
WHY: Continued aggression without progress is the defining absorption pattern.

NODE 26
TITLE: Absorption Practice Replays
TYPE: PRACTICE_REPLAY
CELEBRATION: Absorption Practice Replays complete.

[ORDERFLOW_SIM] Buying is aggressive but price cannot clear resistance. What is strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Buyers are active but may be absorbed by refreshing sellers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Aggressive buyers can be absorbed by passive sellers at resistance.

[ORDERFLOW_SIM] Selling is aggressive but price cannot break support. What is strongest?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Sellers are active but may be absorbed by refreshing buyers
The fastest evidence guarantees the next move
Displayed size alone determines the outcome
The candle should be read without execution context
WHY: Aggressive sellers can be absorbed by passive buyers at support.

[ORDERFLOW_SIM] What does the combined evidence show?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Strong pressure with little movement suggests absorption
The candle alone proves the cause
Aggression confirms continuation
Displayed size reveals hidden liquidity
WHY: Strong pressure with little movement suggests absorption.

[REPLAY_COMPARE] Which replay shows sustained pressure being contained rather than pressure fading?
VISUAL: Replay A shows varied buy sizes continuing into an offer that replenishes while price stays pinned. Replay B shows both buy size and pace fading before price stalls.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: Replay A keeps aggression active against replenishment. Replay B shows exhaustion.

[ORDERFLOW_SIM] Buying remains active, the offer refreshes, and price cannot clear resistance. What's strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Possible seller absorption
Buyer continuation is confirmed
Buying has completely stopped
WHY: The simulation exposes active buying, replenishment, and weak upward response.

[ORDERFLOW_SIM] Selling remains active, the bid refreshes, and price cannot break support. What's strongest?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Possible buyer absorption
Seller continuation is confirmed
Selling has completely stopped
WHY: The simulation exposes active selling, replenishment, and weak downward response.

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
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
SKILL: multi_signal_read
Possible buyer absorption
Seller continuation remains favored
Seller exhaustion is developing
WHY: Selling remains active while support holds.

[ORDERFLOW_SIM] Buying stays aggressive while resistance holds. What's strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
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
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading. A preview label explains that delta compares aggressive buying with selling, is supplemental here, and will be taught in Unit 5.
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

[FOOTPRINT] What information does this balanced footprint provide?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Executed bid and ask volume at each price
Resting orders that have not traded
Only the candle's final direction
WHY: A footprint displays completed executions separated by side and price.

[MC] Why isn't the largest same price difference automatically a diagonal imbalance?
SKILL: reading_footprints_imbalances
A conventional imbalance compares diagonally adjacent executions by ratio
The largest cell always determines direction
Only total candle volume matters
WHY: Diagonal imbalance uses adjacent prices and a defined ratio rather than one same price difference.

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

[FOOTPRINT] What does this ask heavy footprint support?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Buyer imbalance
Seller imbalance
Balanced execution
WHY: Ask side execution dominates across the relevant prices.

[FOOTPRINT] What does this bid heavy footprint support?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest bid side execution advantage.
SKILL: footprint_reading
EVENT: hit
Seller imbalance
Buyer imbalance
Balanced execution
WHY: Bid side execution dominates across the relevant prices.

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

[ORDER] Build the momentum ignition read.
SKILL: market_sequence
Buyer pressure appears
Offers get consumed
Price reaches higher levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

[MC] What makes a burst a possible momentum ignition?
SKILL: momentum_ignition
It overwhelms nearby opposition and moves price
It contains one large print
It occurs after any green candle
WHY: A burst matters when it changes both liquidity and price.

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

[ORDER] Build the momentum continuation & failure read.
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

[EVIDENCE_SELECT] Which evidence makes stacked pressure more meaningful?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Several consecutive directional imbalances
Price progresses with the stack
One isolated large cell
Balanced execution at every price
WHY: A stack is consecutive and stronger when price responds.

[MC] What separates stacked pressure from one imbalance?
SKILL: stacked_pressure
Directional imbalance repeats across adjacent prices
The largest row has high volume
Displayed depth is perfectly even
WHY: Stacking requires consecutive imbalances rather than one cell.

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

[FOOTPRINT] How do volume and delta differ?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Volume is total activity. Delta is net aggression
Delta determines the next price
Volume and delta are identical
The disagreement cancels both readings
WHY: Volume totals executed activity while delta nets aggressive buying against aggressive selling.

[FOOTPRINT_TAP] Tap the row adding most positive delta.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest positive ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_positive
TARGET: 2
WHY: This row contributes the largest ask minus bid volume.

[FOOTPRINT] Which quantity measures net aggressive buying minus selling?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Delta
Total volume
Displayed depth
WHY: Volume totals execution while delta nets ask and bid side execution.

[MC] What does net aggression compare?
SKILL: delta_vs_volume
Net aggression compares buying with selling
Fast tape near resistance is stronger than failure to gain acceptance
A liquidity sweep and breakout differ mainly by candle size
Order flow evidence remains valid regardless of changing volatility
WHY: Net aggression compares aggressive buying with aggressive selling.

[FOOTPRINT_TAP] Tap the highest volume row.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the largest combined executed volume.
SKILL: footprint_interaction
EVENT: total_target
TARGET: 3
WHY: Total volume adds bid and ask executions, unlike delta.

[ORDER] Build the delta vs. volume read.
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

[ORDERFLOW_SIM] Positive delta builds while price stalls at resistance. What best explains the disagreement?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Possible seller absorption or trapped buyers
Positive delta guarantees delayed upside
The price response should be ignored
WHY: Aggressive buying is visible, but it is not producing the expected upward response.

[FOOTPRINT] Price falls while footprint delta remains positive. What's strongest?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest positive ask minus bid delta.
SKILL: footprint_reading
EVENT: delta_positive
Possible seller absorption or trapped buyers
Positive delta guarantees higher prices
The footprint should be ignored
WHY: Aggressive buying is failing to produce the expected upward response.

[FOOTPRINT] Price rises while footprint delta remains negative. What's strongest?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest negative ask minus bid delta.
SKILL: footprint_reading
EVENT: delta_negative
Possible buyer absorption or trapped sellers
Negative delta guarantees lower prices
Price and execution cannot disagree
WHY: Aggressive selling is failing to produce the expected downward response.

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

[ORDER] Build the divergence reading process.
SKILL: market_sequence
Measure executed delta
Compare the price response
Inspect location and liquidity
Form the divergence hypothesis
WHY: Divergence starts by comparing executed pressure with the response it actually produced.

NODE 35
TITLE: Price and Pressure Divergence
TYPE: STANDARD
CELEBRATION: Price and Pressure Divergence complete.

[ORDERFLOW_SIM] Positive execution pressure grows while upward price progress fades. What's strongest?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
Price and pressure disagreement warns of weakness
Positive delta confirms continuation
The refreshing offer is irrelevant
WHY: The multi source view makes the execution and price contradiction visible.

[FOOTPRINT_TAP] Rising price is shown beside this footprint. Tap the negative delta row opposing it.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest negative ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_negative
TARGET: 6
WHY: The selected negative delta row conflicts with the stated rising price context.

[MC] What does price pressure disagreement suggest?
SKILL: price_and_pressure_divergence
Price and pressure disagreement warns of weakness
The current book is more useful than the executions that changed it
Location adds little once the tape accelerates
The earliest signal should anchor the read even after conditions change
WHY: Price and pressure disagreement warns of weakness.

[ORDER] Build the price and pressure divergence read.
SKILL: market_sequence
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

[MC] Positive pressure appears while price weakens. What is the best conclusion?
SKILL: price_and_pressure_divergence
The buying is not achieving the expected response
Higher prices are guaranteed later
The execution data should be ignored
WHY: Pressure without its expected response is a warning, not a signal by itself.

NODE 36
TITLE: Footprint & Momentum Challenge
TYPE: STANDARD
CELEBRATION: Footprint & Momentum Challenge complete.

[FOOTPRINT] How do the footprint rows combine into one directional read?
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

[FOOTPRINT_TAP] Tap where sustained buyer pressure is most concentrated.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_interaction
EVENT: lift
TARGET: 1
WHY: Concentrated ask executions can help ignite momentum.

[FOOTPRINT_TAP] Tap where the prior directional footprint loses control.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row with the smallest bid ask execution difference.
SKILL: footprint_interaction
EVENT: balanced_target
TARGET: 2
WHY: Execution becomes balanced as momentum loses force.

[FOOTPRINT_TAP] Rising price is shown beside this footprint. Tap the negative delta row that conflicts with it.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one row contributing the largest negative ask minus bid delta.
SKILL: footprint_interaction
EVENT: delta_negative
TARGET: 3
WHY: The selected row shows aggressive selling even as price rises.

[MC] Which interpretation best combines delta with price response?
SKILL: footprint_momentum_challenge
Delta matters most when price produces the expected response
Positive delta is sufficient confirmation for higher prices
The largest footprint row determines the next move
Price response can be ignored when delta is persistent
WHY: Delta and the corresponding price response must be interpreted together.

[MC] Which momentum conclusion best fits this new response?
SKILL: footprint_momentum_challenge
Sudden aggression can ignite momentum
Acceptance is present as soon as one trade prints beyond a level
Passive absorption and fading aggression produce the same evidence
A high volume candle reveals which side initiated every trade
WHY: Sudden aggression can ignite momentum.

[MC] What does the changing response imply about momentum?
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

[MC] How can inferred sell stops below support affect a breakdown?
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

[EVIDENCE_SELECT] Which two clues identify a liquidity sweep?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Price trades beyond an obvious level
Price quickly returns without acceptance
Price holds beyond the level
Execution continues cleanly away
WHY: A sweep takes liquidity and then rejects rather than accepting.

[MC] How should a brief breach followed by immediate rejection be read?
SKILL: what_is_a_liquidity_sweep
Possible liquidity sweep
Confirmed breakout acceptance
Guaranteed reversal
WHY: The return inside shows that trade beyond the level was not accepted.

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

[TAP_CANDLE] Tap the rejection after the downside sweep.
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

[ORDERFLOW_SIM] Price trades below the prior low and immediately reclaims it. Is this a downside sweep or acceptance?
VISUAL: Price trades below a prior low as sell stops trigger and seller initiated prints surge, then bids rebuild, buying responds, and price immediately reclaims the breached level.
SKILL: multi_signal_read
Possible downside sweep
Accepted breakdown
Seller continuation remains favored
WHY: The breach takes liquidity but fails to gain acceptance below.

[MC] Which upside sweep interpretation is best supported?
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

[EVIDENCE_SELECT] Which two clues favor breakout acceptance over a sweep?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution persists beyond the level
Price holds outside the prior range
Price immediately returns inside
Aggression disappears after the breach
WHY: Acceptance requires continued trade and a hold beyond the level.

[MC] What best separates a sweep from an accepted breakout?
SKILL: sweep_vs_breakout_acceptance
Whether price holds beyond the breached level
Whether one large order traded
The direction of the prior candle
WHY: The key distinction is rejection versus sustained acceptance.

NODE 43
TITLE: Thin vs. Thick Liquidity
TYPE: STANDARD
CELEBRATION: Thin vs. Thick Liquidity complete.

[BOOK_COMPARE] Which book lets price travel with less incoming pressure?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B
Book A
Both equally
WHY: Book B has thinner nearby depth and gaps.

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

[ORDERFLOW_SIM] Displayed size repeatedly refills after same price executions. What's strongest?
VISUAL: Level II repeatedly shows 100 shares at the offer. Each 100 share execution clears the display, then another 100 immediately reappears at the same price while Time and Sales keeps printing buys.
SKILL: multi_signal_read
A possible iceberg is replenishing hidden size
The candle proves a breakout
Every cancelled order is spoofing
WHY: Repeated fills plus replenishment may indicate hidden liquidity.

[REPLAY_COMPARE] Which replay shows repeated execution against replenishing displayed size?
VISUAL: Replay A shows varied buy sizes continuing into an offer that replenishes while price stays pinned. Replay B shows both buy size and pace fading before price stalls.
SKILL: scenario_comparison
Replay A
Replay B
Neither
WHY: Replay A keeps executing into liquidity that returns while price remains pinned.

[MC] What makes repeated same price fills suspicious for hidden size?
SKILL: icebergs_hidden_replenishment
Displayed liquidity keeps returning after it trades
Every print has the same color
Price must break out next
WHY: The visible amount understates what continues to execute.

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

[MC] Which liquidity conclusion is best supported by the full setup?
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: liquidity_challenge
CHART: rejectionWickUp
A sweep takes liquidity but fails to gain acceptance
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: A sweep takes liquidity but fails to gain acceptance.

[MC] Which sweep interpretation needs fewer assumptions here?
VISUAL: Alternating wide candles and long wicks show rapid movement with changing control.
SKILL: liquidity_challenge
CHART: volatile
Judge liquidity events by location and response
Repeated tests always make a liquidity level stronger
A fast rejection proves the resting wall was genuine
Stable displayed size means hidden liquidity cannot be present
WHY: Judge liquidity events by location and response.

[MC] Which liquidity behavior carries the most weight?
VISUAL: Price breaks resistance, returns to test it from above, then attempts to continue higher.
SKILL: liquidity_challenge
CHART: breakoutRetest
Combine pressure with liquidity and price response
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: Combine pressure with liquidity and price response.

[ORDER] Order the liquidity evidence from location to response.
VISUAL: Price briefly trades above a level and closes back below it, leaving a long upper wick.
SKILL: market_sequence
CHART: rejectionWickUp
Seller pressure appears
Bids get consumed
Price reaches lower levels
The chart confirms the move
WHY: Read pressure, liquidity, price, then confirmation.

[MATCH] Match each liquidity clue with the behavior it supports.
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

[BOOK_COMPARE] Which depth profile in Boss Battle: Sweep or Acceptance? should let price travel more easily?
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

[ORDERFLOW_SIM] Seller initiated prints persist as bids thin and price accepts below support. What's strongest?
VISUAL: Seller initiated prints persist into bids that are being consumed or withdrawn, footprint execution favors sellers, and price establishes sustained trade below support.
SKILL: multi_signal_read
Breakdown pressure is producing acceptance
A downside sweep has already rejected
Buyer absorption is confirmed
WHY: The simulation shows selling, weakening bids, and sustained trade below support.

[EVIDENCE_SELECT] Select the two clues supporting breakdown pressure.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Seller execution persists
Bids thin or get consumed
Price immediately reclaims support
Buying accelerates above the level
WHY: Breakdown pressure combines active selling with weakening bid liquidity.

[TAP_CANDLE] Tap the price response that matters most for Breakout vs. Breakdown Pressure.
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

[EVIDENCE_SELECT] Which two observations confirm the replay gained acceptance?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Offers clear with persistent buying
Price establishes trade above resistance
Price immediately falls back inside
The offer keeps rejecting every attempt
WHY: Execution and sustained trade above the level confirm acceptance.

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

[ORDERFLOW_SIM] Price breaks support, fails to hold below it, and quickly reclaims it. What's strongest?
VISUAL: Price trades below a prior low as sell stops trigger and seller initiated prints surge, then bids rebuild, buying responds, and price immediately reclaims the breached level.
SKILL: multi_signal_read
The breakdown failed
Downside acceptance is established
The initial breach guarantees continuation
WHY: Trading below support followed by an immediate reclaim shows failed acceptance.

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

[ORDERFLOW_SIM] Price trades above resistance, fails to hold, and returns below it. What's strongest?
VISUAL: Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.
SKILL: multi_signal_read
The breakout failed
Upside acceptance is established
Positive delta guarantees continuation
WHY: The visible breach and return inside show failed acceptance.

[MATCH] Match each clue.
SKILL: failed_breakouts_vs_failed_breakdowns
Failed Breakdown => Return above support
Iceberg => Displayed size repeatedly replenishes
Acceptance => Price holds beyond the level
WHY: Match the signal with its order flow clue.

[REPLAY_COMPARE] Which replay shows a breakout attempt failing back below resistance?
VISUAL: Replay A breaks and holds with persistent buying. Replay B breaks, fails, returns inside, and gives control to sellers.
SKILL: scenario_comparison
Replay B
Replay A
Neither replay
WHY: Replay B first trades above resistance, then loses the level and returns inside.

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

[TAP_CANDLE] Tap the price response that matters most for Chasing, Confirmation & Common Misconceptions.
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

[ORDERFLOW_SIM] Fast buying appears, but the offer refreshes and price stalls. Is breakout acceptance confirmed?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
No. Fast tape still needs price acceptance
Yes. Speed alone confirms it
Yes. Positive delta guarantees it
WHY: Fast tape is urgency, not confirmation.

[MC] What best connects the evidence?
VISUAL: Price opens well above the prior trading area with little activity between the two zones.
SKILL: chasing_confirmation_common_misconceptions
CHART: gapUp
Late entries carry worse risk and reward
Positive delta is usually sufficient confirmation for higher prices
A pull in liquidity is equivalent to aggressive execution
Slower counter pressure automatically confirms continuation
WHY: Late entries carry worse risk and reward.

[ORDERFLOW_SIM] Footprint delta stays positive while a refreshing offer prevents higher prices. What's strongest?
VISUAL: Price stalls at resistance above VWAP while an offer refreshes, buyer initiated prints accelerate, and positive footprint delta produces little upward progress.
SKILL: multi_signal_read
Buying may be absorbed by passive sellers
Positive delta guarantees delayed upside
The execution data should be ignored
WHY: Positive delta with weak price progress can support possible seller absorption.

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
VISUAL: Replay A pauses above the break, defends a deeper retest, and resumes higher. Replay B loses the level after an initially strong burst and sellers take control.
SKILL: scenario_comparison
Replay A
Replay B
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[EVIDENCE_SELECT] Select the clues showing trade became established beyond the level.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Buying persists above the level
Price holds above resistance
Price immediately returns inside
The offer keeps rejecting price
WHY: The interaction must match the evidence required by this specific setup.

[REPLAY_COMPARE] Which replay turns the initial break into a buyer trap?
VISUAL: Replay A pauses above the break, defends a deeper retest, and resumes higher. Replay B loses the level after an initially strong burst and sellers take control.
SKILL: scenario_comparison
Replay B
Replay A
Not enough evidence
WHY: Acceptance needs continued execution and price holding beyond the level.

[REPLAY_COMPARE] Which replay survives the deeper retest?
VISUAL: Replay A pauses above the break, defends a deeper retest, and resumes higher. Replay B loses the level after an initially strong burst and sellers take control.
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

[LIVE_CHART] Which evolving price response confirms acceptance?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
SKILL: breakout_challenge
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[LIVE_CHART] Where does breakout follow through begin to fail?
VISUAL: A live candlestick chart adds new candles over time, with price currently building downward.
SKILL: breakout_challenge
DIRECTION: down
Downward price response is developing
Upward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[TAP_CANDLE] Tap the candle that best confirms the order flow response.
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

[ORDERFLOW_SIM] What supports the breakdown?
VISUAL: Seller initiated prints persist into bids that are being consumed or withdrawn, footprint execution favors sellers, and price establishes sustained trade below support.
SKILL: multi_signal_read
Persistent seller execution and acceptance below support
One bearish candle
A distant resting offer
WHY: Tape, Level II, footprint, and price all support sustained downside acceptance.

[EVIDENCE_SELECT] Select acceptance clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Persistent execution
Price holds beyond
Immediate return inside
Refreshing opposition
WHY: Execution and holding response support acceptance.

[ORDERFLOW_SIM] What invalidates the breakout?
VISUAL: Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.
SKILL: multi_signal_read
Price returns below resistance after trading above it
Buyer prints remain visible
Positive delta appears during the breach
WHY: The break is visible before price loses the level and returns inside.

[ORDERFLOW_SIM] What invalidates the breakdown?
VISUAL: Price trades below a prior low as sell stops trigger and seller initiated prints surge, then bids rebuild, buying responds, and price immediately reclaims the breached level.
SKILL: multi_signal_read
Price returns above support after trading below it
Seller prints remain visible
Negative delta appears during the breach
WHY: The break below support fails when price quickly reclaims the level.

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

[EVIDENCE_SELECT] Select the clues showing the pullback remains healthy.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Counter pressure stays lighter
Trend structure remains defended
Counter pressure accelerates
The key level fails
WHY: Continuation needs lesson specific structure and confirming execution.

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

[EVIDENCE_SELECT] Select the clues supporting continuation after the pullback.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Trend side pressure returns
Price resumes from defended structure
Counter pressure takes control
Price loses the reference level
WHY: Continuation needs lesson specific structure and confirming execution.

[TIME_SALES] Which tape clue supports continuation?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Seller prints regain persistence
Buy prints accelerate at support
Trade pace becomes balanced
WHY: Use completed executions to judge whether trend pressure returned.

[LIVE_CHART] Which live price behavior supports Bullish vs. Bearish Pullbacks?
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

[EVIDENCE_SELECT] Select the clues showing trend pressure has actually returned.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Trend side execution accelerates
Price makes renewed progress
One isolated print appears
Counter pressure strengthens
WHY: Continuation needs lesson specific structure and confirming execution.

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

[MC] What turns a pullback into a continuation setup?
SKILL: continuation_triggers
Trend side aggression returns and price responds
One fast print appears
Volume is higher than yesterday
WHY: Continuation begins when the trend side regains effective control.

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

[LIVE_CHART] What changed in the order flow at vwap & moving averages response?
VISUAL: A live candlestick chart adds new candles over time, with price currently building upward.
SKILL: order_flow_at_vwap_moving_averages
DIRECTION: up
Upward price response is developing
Downward price response is developing
Price is not gaining directional acceptance
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[EVIDENCE_SELECT] Select the clues confirming the reference level held.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Execution defends the reference
Price responds in the trend direction
Price accepts through the reference
Counter tape accelerates
WHY: Continuation needs lesson specific structure and confirming execution.

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

[FOOTPRINT_TAP] Tap the busiest footprint row aligned with VWAP.
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing a VWAP badge aligned with the target row carrying the largest combined executed volume.
SKILL: footprint_interaction
EVENT: vwap_target
TARGET: 2
WHY: The VWAP badge identifies the relevant price row, which also carries the highest total execution.

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
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with seller initiated prints dominating at the bid.
SKILL: tape_reading
EVENT: hit
Seller initiated prints accelerate at the bid
Buyer pressure regains control
The spread proves continuation
WHY: Accelerating seller initiated execution is the counterpressure invalidating the bullish continuation attempt.

[EVIDENCE_SELECT] Which two clues show the pullback is failing?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Countertrend aggression strengthens
Trend structure breaks
Trend pressure returns
The reference level holds
WHY: Growing counter pressure plus lost structure weakens continuation.

[MC] When should a continuation idea be invalidated?
SKILL: pullback_failure
Counter pressure takes control and the key level fails
One opposing print appears
The tape briefly slows
WHY: Failure requires evidence that the original structure and control are gone.

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

[ORDERFLOW_SIM] What contradicts the fast buyer tape?
VISUAL: Price rises above VWAP with positive delta and fast buyer prints, but a large offer refreshes and upward price progress begins fading.
SKILL: multi_signal_read
Positive delta and price response diverge
The largest footprint cell decides direction
Tape speed guarantees acceptance
WHY: The tape is aggressive, but the footprint, refreshing offer, and fading price response conflict with it.

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

[ORDERFLOW_SIM] What defines this high volume chop?
VISUAL: A range shows little net progress while Time and Sales alternates rapidly between buyers and sellers and the footprint displays heavy balanced execution on both sides.
SKILL: multi_signal_read
Fast two sided execution with little price progress
Measured one sided tape with efficient travel
Sparse opposing depth and low activity
WHY: Heavy alternating execution produces volume without directional progress.

[ORDERFLOW_SIM] What defines this low volume trend?
VISUAL: Price advances steadily as Level II shows sparse opposing offers, Time and Sales prints at a measured pace, and the footprint shows modest directional execution rather than a volume surge.
SKILL: multi_signal_read
Measured execution and thin opposition allow steady travel
Fast two sided execution pins price
Heavy opposing depth blocks every move
WHY: Sparse opposition allows modest execution to move price efficiently.

[FOOTPRINT] What does the footprint add?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Heavy volume without directional progress
The largest cell decides direction
Volume guarantees a trend
WHY: High volume without directional progress can show two sided absorption.

[ORDERFLOW_SIM] Is execution strongly directional?
VISUAL: Price advances steadily as Level II shows sparse opposing offers, Time and Sales prints at a measured pace, and the footprint shows modest directional execution rather than a volume surge.
SKILL: multi_signal_read
No. Modest pressure travels through thin opposing depth
Yes. A large directional footprint proves it
No. Price is not moving
WHY: Level II shows thin opposition while execution remains modest and price still travels.

[ORDERFLOW_SIM] Heavy two sided execution produces little price progress. What's strongest?
VISUAL: A range shows little net progress while Time and Sales alternates rapidly between buyers and sellers and the footprint displays heavy balanced execution on both sides.
SKILL: multi_signal_read
Possible high volume chop
Clean directional momentum
No meaningful trading occurred
WHY: High execution volume without directional progress can reflect two sided absorption.

[ORDERFLOW_SIM] Price trends steadily while the opposing book stays thin. What's strongest?
VISUAL: Price advances steadily as Level II shows sparse opposing offers, Time and Sales prints at a measured pace, and the footprint shows modest directional execution rather than a volume surge.
SKILL: multi_signal_read
Thin opposition can allow a low volume trend
High volume is required for every trend
The tape proves absorption
WHY: Price can travel efficiently when little liquidity opposes it.

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

[EVIDENCE_SELECT] Select the two clues that survive the mixed continuation test.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Trend side aggression
Confirming price response
One isolated print
An untested wall
WHY: Advanced continuation requires structure plus confirming execution evidence.

[MC] Which interpretation best resolves the mixed continuation evidence?
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

[EVIDENCE_SELECT] Select the strongest continuation evidence.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Structure holds under the pullback
Renewed trend pressure moves price
One fast print appears
The latest candle matches the trend
WHY: Continuation needs lesson specific structure and confirming execution.

[TRENDLINE] Connect the structural anchors relevant to this continuation read.
VISUAL: A sharp advance pauses in a compact downward sloping channel before buyers test control again. The learner draws directly between two candles to mark the structure.
SKILL: confirmation_continuation_challenge
CHART: bullFlag
TARGET: 0 => 4
WHY: Structure supplies location. Execution evidence supplies the read.

[MC] What's the strongest conclusion from the conflicting continuation evidence?
VISUAL: A small candle body with upper and lower wicks shows two sided movement and little progress.
SKILL: confirmation_continuation_challenge
CHART: spinningTop
Conflicting evidence means no confirmed read
Price progress can be ignored when aggression is persistent
A narrow spread confirms directional control
The largest footprint row determines the entire candle read
WHY: When evidence conflicts the strongest conclusion may be no clear read.

[LIVE_CHART] Which live response fails to confirm that trend pressure returned?
VISUAL: A live candlestick chart adds new candles over time, with price currently alternating inside a range.
SKILL: confirmation_continuation_challenge
DIRECTION: sideways
Price is not gaining directional acceptance
Upward price response is developing
Downward price response is developing
WHY: Price response confirms or contradicts the execution evidence shown elsewhere in the lesson.

[MATCH] Match each continuation clue with the conclusion it supports.
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
Directional pressure is cleanly one sided
The quieter side has already lost control
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

[ORDERFLOW_SIM] What changed in control?
VISUAL: Seller initiated prints dominate into support, price stops falling, seller pace weakens, buyers begin lifting offers, and price starts responding upward.
SKILL: multi_signal_read
Seller aggression stopped moving price and buyer pressure emerged
Seller control strengthened through support
One opposing print guaranteed reversal
WHY: The sequence shows selling, stalled downside progress, fading seller pace, and an opposing response.

[FOOTPRINT] What confirms the control change?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing one target row carrying the largest ask side execution advantage.
SKILL: footprint_reading
EVENT: lift
Opposing aggression gains strength
The pattern target is guaranteed
Only resting liquidity matters
WHY: Tape and footprint evidence reveal what changed beneath the candle pattern.

[ORDERFLOW_SIM] Which reversal read is best supported?
VISUAL: Seller initiated prints dominate into support, price stops falling, seller pace weakens, buyers begin lifting offers, and price starts responding upward.
SKILL: multi_signal_read
A visible control change is developing
The bullish candle alone confirms reversal
Seller aggression guarantees continuation
WHY: Tape, liquidity, and price response show the prior side losing control and opposition emerging.

[EVIDENCE_SELECT] Which two clues support a change in reversal pressure?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
The prior side stops making progress
Opposing aggression gains follow through
One rejection wick forms
Total volume stays constant
WHY: A reversal needs weakening prior control and effective opposing pressure.

[MC] What is the strongest evidence that control may be changing?
SKILL: reversal_pressure
Opposing aggression begins producing price progress
One large opposing print
A familiar candle pattern appears
WHY: Control change is stronger when execution receives a confirming response.

NODE 65
TITLE: Buyer Traps vs. Seller Traps
TYPE: STANDARD
CELEBRATION: Buyer Traps vs. Seller Traps complete.

[ORDERFLOW_SIM] What shows buyers became trapped?
VISUAL: Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.
SKILL: multi_signal_read
Buying above resistance fails and price returns below
Buyer prints appear above resistance
Positive delta remains visible
WHY: The attempted break fails to hold and reverses back below the level.

[ORDERFLOW_SIM] What shows sellers became trapped?
VISUAL: Price trades below a prior low as sell stops trigger and seller initiated prints surge, then bids rebuild, buying responds, and price immediately reclaims the breached level.
SKILL: multi_signal_read
Selling below support fails and price reclaims above
Seller prints appear below support
Negative delta remains visible
WHY: The attempted breakdown fails to hold and reverses above the level.

[ORDERFLOW_SIM] What contradicts the positive delta?
VISUAL: Price briefly trades above resistance as offers disappear and buy prints surge, then sell liquidity rebuilds and price immediately returns below the level.
SKILL: multi_signal_read
Price returns below resistance
Buyer initiated prints appear
Offers briefly thin
WHY: Positive delta fails to produce acceptance and price returns inside.

[ORDERFLOW_SIM] What contradicts the negative delta?
VISUAL: Price trades below a prior low as sell stops trigger and seller initiated prints surge, then bids rebuild, buying responds, and price immediately reclaims the breached level.
SKILL: multi_signal_read
Price returns above support
Seller initiated prints appear
Bids briefly thin
WHY: Negative delta fails to produce acceptance and price reclaims support.

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

[TIME_SALES] At the low, which tape change supports a seller exhaustion reversal?
VISUAL: An animated Time and Sales table lists time, execution price, and trade size, with pace and trade size fading after the target row.
SKILL: tape_reading
EVENT: stall
Seller initiated prints lose pace and size
Seller aggression accelerates lower
Buyer pressure disappears
WHY: Fading seller aggression can prepare a bullish control change.

[FOOTPRINT] At the high, which footprint change supports a buyer exhaustion reversal?
VISUAL: A footprint grid places bid volume left of price and ask volume right of price, showing similar bid and ask volume across the price rows.
SKILL: footprint_reading
EVENT: balanced
Buyer execution loses directional dominance
Ask execution accelerates higher
Every row becomes strongly ask heavy
WHY: Fading buyer dominance can prepare a bearish control change.

[MC] What does the evidence support?
VISUAL: A narrow candle body with wicks on both sides shows little net price progress.
SKILL: exhaustion_reversals
CHART: doji
Exhaustion can prepare a reversal
Tape speed matters more than the level where it occurs
A replenishing order is probably new unrelated liquidity
Brief trade beyond the level is enough to establish acceptance
WHY: Exhaustion can prepare a reversal.

[EVIDENCE_SELECT] Which two clues best support an exhaustion reversal?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Prior aggression fades
Opposing price response develops
Original aggression accelerates
Price continues cleanly in the original direction
WHY: Exhaustion plus an opposing response supports reversal.

[MC] What must follow exhaustion before a reversal is stronger?
SKILL: exhaustion_reversals
Opposing control and price confirmation
A guaranteed target
A larger candle wick
WHY: Fading pressure alone does not confirm that the other side has taken control.

NODE 67
TITLE: Absorption Reversals
TYPE: STANDARD
CELEBRATION: Absorption Reversals complete.

[ORDERFLOW_SIM] What shows pressure being absorbed?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Heavy seller prints make little downward progress
Seller execution disappears before support
Negative delta guarantees a breakdown
WHY: Strong selling is visible while price barely declines against a replenishing bid.

[ORDERFLOW_SIM] What supports possible passive defense?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
The bid replenishes as repeated selling stalls
One ask heavy footprint row
A lower wick without execution evidence
WHY: Repeated executions, replenishment, and stalled price jointly support possible passive defense.

[ORDERFLOW_SIM] Which explanation fits best?
VISUAL: Price holds support below VWAP while a bid refreshes, seller initiated prints accelerate, and negative footprint delta produces little downward progress.
SKILL: multi_signal_read
Possible buyer absorption can support a reversal
The lower wick alone proves absorption
Negative delta guarantees continuation
WHY: Tape, Level II, and price response support possible buyer absorption without making it certain.

[EVIDENCE_SELECT] Which two clues best support an absorption reversal?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Heavy aggression makes little progress
Opposing execution begins moving price
The defended level immediately fails
Aggression disappears before reaching the level
WHY: Contained pressure followed by opposing control supports reversal.

[MC] When does absorption become a stronger reversal case?
SKILL: absorption_reversals
The absorbed side fails and opposing pressure gains follow through
Displayed size appears once
Delta stays directional
WHY: Absorption needs a subsequent control change before it supports reversal.

NODE 68
TITLE: Double Top vs. Double Bottom Flow
TYPE: STANDARD
CELEBRATION: Double Top vs. Double Bottom Flow complete.

[REPLAY_COMPARE] How does the second high test differ?
VISUAL: Replay A shows the first resistance test with strong buyer execution. Replay B shows a second test with weaker buying, stronger seller response, and a return below resistance.
SKILL: scenario_comparison
Replay B shows weaker buyer urgency
Replay A shows weaker buyer urgency
The tests show identical execution
WHY: The second panel shows buying weakening while seller response strengthens.

[REPLAY_COMPARE] Which side weakens on the second low test?
VISUAL: Replay A shows the first support test with strong seller execution. Replay B shows a second test with weaker selling, stronger buyer response, and a reclaim above support.
SKILL: scenario_comparison
Aggressive sellers
Aggressive buyers
Neither side
WHY: The second panel shows seller pace and size fading before buyers respond.

[REPLAY_COMPARE] What changes on the second high test?
VISUAL: Replay A shows the first resistance test with strong buyer execution. Replay B shows a second test with weaker buying, stronger seller response, and a return below resistance.
SKILL: scenario_comparison
Seller response strengthens
Buyer acceptance strengthens
Execution remains identical
WHY: The comparison shows stronger seller response on the retest.

[REPLAY_COMPARE] What changes on the second low test?
VISUAL: Replay A shows the first support test with strong seller execution. Replay B shows a second test with weaker selling, stronger buyer response, and a reclaim above support.
SKILL: scenario_comparison
Buyer response strengthens
Seller acceptance strengthens
Execution remains identical
WHY: The comparison shows stronger buyer response on the retest.

[REPLAY_COMPARE] What is the strongest conclusion from both high tests?
VISUAL: Replay A shows the first resistance test with strong buyer execution. Replay B shows a second test with weaker buying, stronger seller response, and a return below resistance.
SKILL: scenario_comparison
Repeated failure with weaker buying can shift control toward sellers
The double top shape confirms a reversal by itself
Both tests show identical buyer pressure
WHY: The comparison shows weaker buying, stronger seller response, and failed acceptance on the second test.

[REPLAY_COMPARE] What is the strongest conclusion from both low tests?
VISUAL: Replay A shows the first support test with strong seller execution. Replay B shows a second test with weaker selling, stronger buyer response, and a reclaim above support.
SKILL: scenario_comparison
Repeated failure with weaker selling can shift control toward buyers
The double bottom shape confirms a reversal by itself
Both tests show identical seller pressure
WHY: The comparison shows weaker selling, stronger buyer response, and a reclaim on the second test.

NODE 69
TITLE: Reversal Confirmation & Insufficient Evidence
TYPE: STANDARD
CELEBRATION: Reversal Confirmation & Insufficient Evidence complete.

[ORDERFLOW_SIM] What confirms the reversal?
VISUAL: Seller initiated prints dominate into support, price stops falling, seller pace weakens, buyers begin lifting offers, and price starts responding upward.
SKILL: multi_signal_read
The prior side stalls, opposing pressure strengthens, and price responds
One opposing print appears
A candle pattern forms without execution confirmation
WHY: The full transition from prior control to opposing follow through is visible.

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

[ORDERFLOW_SIM] What completes the reversal read?
VISUAL: Seller initiated prints dominate into support, price stops falling, seller pace weakens, buyers begin lifting offers, and price starts responding upward.
SKILL: multi_signal_read
The prior side stalls, opposing pressure strengthens, and price responds
One opposing print appears
A candle pattern forms without execution confirmation
WHY: The full transition from prior control to opposing follow through is visible.

[ORDERFLOW_SIM] Which reversal entry needs fewer assumptions?
VISUAL: Seller initiated prints dominate into support, price stops falling, seller pace weakens, buyers begin lifting offers, and price starts responding upward.
SKILL: multi_signal_read
Waiting for control change and confirming price response
Entering from the candle pattern alone
Entering after one opposing print
WHY: Visible execution and price confirmation reduce reliance on pattern assumptions.

[ORDERFLOW_SIM] What verifies that aggressive control changed?
VISUAL: Seller initiated prints dominate into support, price stops falling, seller pace weakens, buyers begin lifting offers, and price starts responding upward.
SKILL: multi_signal_read
The prior side stalls, opposing pressure strengthens, and price responds
One opposing print appears
A candle pattern forms without execution confirmation
WHY: The full transition from prior control to opposing follow through is visible.

[ORDERFLOW_SIM] What matters most before treating this as a reversal?
VISUAL: Seller initiated prints dominate into support, price stops falling, seller pace weakens, buyers begin lifting offers, and price starts responding upward.
SKILL: multi_signal_read
Control change and confirming price response
The chart structure alone
One large opposing execution
WHY: A reversal requires the prior side to lose control and the opposing side to produce a confirming response.

NODE 70
TITLE: Boss Battle: Trap or Reversal?
TYPE: BOSS_BATTLE
CELEBRATION: Boss Battle: Trap or Reversal? complete.

[REPLAY_COMPARE] Which replay creates the buyer trap in Boss Battle: Trap or Reversal?
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

[REPLAY_COMPARE] What matters on the second high test?
VISUAL: Replay A shows the first resistance test with strong buyer execution. Replay B shows a second test with weaker buying, stronger seller response, and a return below resistance.
SKILL: scenario_comparison
Replay B shows weaker buying and stronger defense
The double top shape alone
Both tests have the same execution
WHY: The side by side execution comparison reveals weakening buying and firmer defense.

[REPLAY_COMPARE] What matters on the second low test?
VISUAL: Replay A shows the first support test with strong seller execution. Replay B shows a second test with weaker selling, stronger buyer response, and a reclaim above support.
SKILL: scenario_comparison
Replay B shows weaker selling and stronger defense
The double bottom shape alone
Both tests have the same execution
WHY: The side by side execution comparison reveals weakening selling and firmer defense.

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

[MC] When urgency matters more than exact price control, which order best fits?
SKILL: planning_the_entry_choosing_the_order_type
A market order
A distant limit order
An unsubmitted order
WHY: A market order prioritizes immediate execution while accepting less price control.

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

[ORDER] Build the decision sequence for Slippage & Thin Liquidity Risk.
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

[BOOK_COMPARE] Which book requires more cautious risk sizing?
VISUAL: Two Level II ladders appear side by side. Book A has large resting size at every nearby price. Book B has small size and gaps between levels.
SKILL: book_depth
Book B
Book A
Both equally
WHY: Thin, unstable depth can increase execution risk.

[ORDERFLOW_SIM] Nearby depth is sparse and the spread widens during execution. What's strongest?
VISUAL: Level II shows small nearby size with gaps, the spread widens during a market order, Time and Sales jumps across prices, and the simulated fill lands worse than the initial quote.
SKILL: multi_signal_read
Slippage risk is elevated
The fill price is guaranteed
Delta removes execution risk
WHY: Sparse depth and a widening spread can move the fill away from the intended price.

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

[MC] Where should the read be invalidated?
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

[MC] Where should invalidation be defined?
SKILL: order_flow_invalidation
Beyond the evidence that would disprove the setup
At an arbitrary fixed distance
After the trade becomes profitable
WHY: Risk belongs where the underlying order flow thesis is no longer valid.

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

[EVIDENCE_SELECT] Which two clues justify a no clear read decision?
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Evidence sources conflict
Price response remains unconfirmed
One clue points directionally
The spread is stable
WHY: Conflicting evidence and no confirmation are valid reasons to wait.

[MC] What is the best action when book, tape, and price disagree?
SKILL: no_clear_read
Wait for clearer alignment
Follow the fastest source
Assume the footprint is always correct
WHY: No trade is a valid decision when evidence conflicts.

NODE 75
TITLE: Exiting Into Liquidity
TYPE: STANDARD
CELEBRATION: Exiting Into Liquidity complete.

[ORDERFLOW_SIM] What does the evidence support?
VISUAL: Price approaches resistance while Level II shows concentrated opposing ask depth, Time and Sales remains active, and the chart identifies the planned exit area without guaranteeing the displayed liquidity will remain.
SKILL: multi_signal_read
Visible opposing depth can help plan an exit area
The exit price is guaranteed
Resistance predicts the next trend
WHY: Level II shows potential counterparties near the planned exit, but displayed liquidity can change.

[EVIDENCE_SELECT] Select the two relevant clues.
VISUAL: Four evidence cards separate aggression, liquidity, price response, and an irrelevant clue. The learner must select the required combination.
SKILL: evidence_synthesis
SELECT: 0, 1
Available opposing liquidity
Current execution pace
Candle color
Moving average slope
WHY: Expert execution decisions combine market evidence with risk.

[MARK_LEVEL] Mark the area where opposing liquidity may be expected.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection.
SKILL: liquidity_location
CHART: resistanceRejection
WHY: The chart marks a potential exit area near resistance, not directly observed resting orders.

[TAP_CANDLE] Tap the clearest price response.
VISUAL: An advance reaches resistance and turns lower with visible upper wick rejection. The candles are tappable and the learner must select the requested candle.
SKILL: exiting_into_liquidity
CHART: resistanceRejection
TARGET: 3
WHY: The selected candle shows whether execution produced follow through.

[MC] Why can opposing liquidity be useful for an exit?
SKILL: exiting_into_liquidity
It may provide counterparties near the planned price
It guarantees zero slippage
It predicts the next trend
WHY: Available counterparties can improve execution but never guarantee a fill.

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
Stable displayed depth should limit most slippage
The current spread is more important than depth changes
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
POOL SIZE: 12
COMPETENCY BLUEPRINT: u1.aggressive_buyer, u1.aggressive_seller, u1.market_buy_routing, u1.market_sell_routing, u1.spread, u1.aggressive_vs_passive, u1.order_price_chain, u1.combined_read
COMPETENCY MAPPINGS: u1.aggressive_buyer => aggressor_side; u1.aggressive_seller => aggressor_side; u1.market_buy_routing => order_routing; u1.market_sell_routing => order_routing; u1.spread => bid_ask_spread; u1.aggressive_vs_passive => aggressive_vs_passive_orders; u1.order_price_chain => market_sequence; u1.combined_read => evidence_synthesis
COMPETENCY SOURCE UNITS: u1.aggressive_buyer => 1; u1.aggressive_seller => 1; u1.market_buy_routing => 1; u1.market_sell_routing => 1; u1.spread => 1; u1.aggressive_vs_passive => 1; u1.order_price_chain => 1; u1.combined_read => 1
COMPETENCY SOURCE NODES: u1.aggressive_buyer => 4; u1.aggressive_seller => 4; u1.market_buy_routing => 2; u1.market_sell_routing => 2; u1.spread => 3; u1.aggressive_vs_passive => 2; u1.order_price_chain => 1; u1.combined_read => 1
ELIGIBLE QUESTION IDS: u1.aggressive_buyer => orderflow.u1.n4.q2; u1.aggressive_seller => orderflow.u1.n4.q3; u1.market_buy_routing => orderflow.u1.n2.q3; u1.market_sell_routing => orderflow.u1.n2.q4; u1.spread => orderflow.u1.n3.q1, orderflow.u1.n3.q2, orderflow.u1.n3.q3; u1.aggressive_vs_passive => orderflow.u1.n2.q1, orderflow.u1.n2.q2, orderflow.u1.n2.q6; u1.order_price_chain => orderflow.u1.n1.q6; u1.combined_read => orderflow.u1.n1.q5
JUMP QUESTIONS: N/A
JUMP PASSING SCORE: N/A
JUMP PREREQUISITE QUESTIONS: N/A
JUMP TARGET QUESTIONS: N/A
JUMP MIN PREREQUISITE SCORE: N/A
JUMP MIN TARGET SCORE: N/A
JUMP PREREQUISITES: N/A

UNIT 2
QUESTIONS PER ATTEMPT: 8
PASSING SCORE: 7
POOL SIZE: 15
COMPETENCY BLUEPRINT: u2.level_two, u2.resting_sides, u2.thick_liquidity, u2.thin_liquidity, u2.wall, u2.wall_behavior, u2.spoofing, u2.combined_book_read
COMPETENCY MAPPINGS: u2.level_two => reading_the_order_book; u2.resting_sides => reading_the_order_book; u2.thick_liquidity => size_liquidity; u2.thin_liquidity => size_liquidity; u2.wall => book_depth, large_orders_as_walls; u2.wall_behavior => large_orders_as_walls, market_sequence; u2.spoofing => pulling_and_spoofing; u2.combined_book_read => evidence_synthesis, multi_signal_read
COMPETENCY SOURCE UNITS: u2.level_two => 2; u2.resting_sides => 2; u2.thick_liquidity => 2; u2.thin_liquidity => 2; u2.wall => 2; u2.wall_behavior => 2; u2.spoofing => 2; u2.combined_book_read => 2
COMPETENCY SOURCE NODES: u2.level_two => 6; u2.resting_sides => 6; u2.thick_liquidity => 7; u2.thin_liquidity => 7; u2.wall => 8; u2.wall_behavior => 8; u2.spoofing => 9; u2.combined_book_read => 11
ELIGIBLE QUESTION IDS: u2.level_two => orderflow.u2.n6.q1; u2.resting_sides => orderflow.u2.n6.q2, orderflow.u2.n6.q4; u2.thick_liquidity => orderflow.u2.n7.q2; u2.thin_liquidity => orderflow.u2.n7.q3, orderflow.u2.n7.q4; u2.wall => orderflow.u2.n8.q1, orderflow.u2.n8.q2; u2.wall_behavior => orderflow.u2.n8.q3, orderflow.u2.n8.q4, orderflow.u2.n8.q5; u2.spoofing => orderflow.u2.n9.q2, orderflow.u2.n9.q3; u2.combined_book_read => orderflow.u2.n11.q6, orderflow.u2.n11.q7
JUMP QUESTIONS: 8
JUMP PASSING SCORE: 7
JUMP PREREQUISITE QUESTIONS: 4
JUMP TARGET QUESTIONS: 4
JUMP MIN PREREQUISITE SCORE: 3
JUMP MIN TARGET SCORE: 3
JUMP PREREQUISITES: u1.market_buy_routing, u1.combined_read, u1.aggressive_seller, u1.market_sell_routing

UNIT 3
QUESTIONS PER ATTEMPT: 9
PASSING SCORE: 8
POOL SIZE: 18
COMPETENCY BLUEPRINT: u3.buyer_initiated, u3.seller_initiated, u3.large_print, u3.tape_speed, u3.persistent_aggression, u3.sequence_break, u3.false_urgency, u3.price_confirmation, u3.combined_tape_read
COMPETENCY MAPPINGS: u3.buyer_initiated => tape_interaction, tape_reading; u3.seller_initiated => tape_interaction, tape_reading; u3.large_print => tape_interaction, tape_reading; u3.tape_speed => tape_interaction, tape_reading; u3.persistent_aggression => evidence_synthesis, tape_reading; u3.sequence_break => repeated_prints_sequence_breaks, tape_interaction; u3.false_urgency => tape_interaction, tape_reading; u3.price_confirmation => evidence_synthesis, multi_signal_read; u3.combined_tape_read => multi_signal_read, tape_reading
COMPETENCY SOURCE UNITS: u3.buyer_initiated => 3; u3.seller_initiated => 3; u3.large_print => 3; u3.tape_speed => 3; u3.persistent_aggression => 3; u3.sequence_break => 3; u3.false_urgency => 3; u3.price_confirmation => 3; u3.combined_tape_read => 3
COMPETENCY SOURCE NODES: u3.buyer_initiated => 15; u3.seller_initiated => 15; u3.large_print => 14; u3.tape_speed => 14; u3.persistent_aggression => 16; u3.sequence_break => 16; u3.false_urgency => 17; u3.price_confirmation => 18; u3.combined_tape_read => 13
ELIGIBLE QUESTION IDS: u3.buyer_initiated => orderflow.u3.n15.q1, orderflow.u3.n15.q3; u3.seller_initiated => orderflow.u3.n15.q2, orderflow.u3.n15.q4; u3.large_print => orderflow.u3.n14.q2, orderflow.u3.n14.q4; u3.tape_speed => orderflow.u3.n14.q1, orderflow.u3.n14.q3; u3.persistent_aggression => orderflow.u3.n16.q1, orderflow.u3.n16.q4; u3.sequence_break => orderflow.u3.n16.q2, orderflow.u3.n16.q5; u3.false_urgency => orderflow.u3.n17.q2, orderflow.u3.n17.q4; u3.price_confirmation => orderflow.u3.n18.q3, orderflow.u3.n18.q4; u3.combined_tape_read => orderflow.u3.n13.q1, orderflow.u3.n13.q6
JUMP QUESTIONS: 10
JUMP PASSING SCORE: 8
JUMP PREREQUISITE QUESTIONS: 5
JUMP TARGET QUESTIONS: 5
JUMP MIN PREREQUISITE SCORE: 4
JUMP MIN TARGET SCORE: 4
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u2.combined_book_read, u1.aggressive_seller, u2.resting_sides

UNIT 4
QUESTIONS PER ATTEMPT: 9
PASSING SCORE: 8
POOL SIZE: 21
COMPETENCY BLUEPRINT: u4.absorption, u4.buyer_absorption, u4.seller_absorption, u4.repeated_tests, u4.hidden_liquidity, u4.buyer_exhaustion, u4.seller_exhaustion, u4.absorption_vs_exhaustion, u4.combined_absorption_read
COMPETENCY MAPPINGS: u4.absorption => evidence_synthesis, multi_signal_read, scenario_comparison; u4.buyer_absorption => multi_signal_read, tape_reading; u4.seller_absorption => multi_signal_read, tape_reading; u4.repeated_tests => multi_signal_read, tape_reading; u4.hidden_liquidity => evidence_synthesis, multi_signal_read; u4.buyer_exhaustion => tape_reading; u4.seller_exhaustion => tape_reading; u4.absorption_vs_exhaustion => scenario_comparison, tape_reading; u4.combined_absorption_read => multi_signal_read, scenario_comparison
COMPETENCY SOURCE UNITS: u4.absorption => 4; u4.buyer_absorption => 4; u4.seller_absorption => 4; u4.repeated_tests => 4; u4.hidden_liquidity => 4; u4.buyer_exhaustion => 4; u4.seller_exhaustion => 4; u4.absorption_vs_exhaustion => 4; u4.combined_absorption_read => 4
COMPETENCY SOURCE NODES: u4.absorption => 20; u4.buyer_absorption => 21; u4.seller_absorption => 21; u4.repeated_tests => 22; u4.hidden_liquidity => 22; u4.buyer_exhaustion => 24; u4.seller_exhaustion => 24; u4.absorption_vs_exhaustion => 25; u4.combined_absorption_read => 26
ELIGIBLE QUESTION IDS: u4.absorption => orderflow.u4.n20.q1, orderflow.u4.n20.q3, orderflow.u4.n20.q4; u4.buyer_absorption => orderflow.u4.n21.q1, orderflow.u4.n21.q2, orderflow.u4.n21.q4; u4.seller_absorption => orderflow.u4.n21.q3, orderflow.u4.n21.q5; u4.repeated_tests => orderflow.u4.n22.q1, orderflow.u4.n22.q2, orderflow.u4.n22.q4; u4.hidden_liquidity => orderflow.u4.n22.q3, orderflow.u4.n22.q5; u4.buyer_exhaustion => orderflow.u4.n24.q1; u4.seller_exhaustion => orderflow.u4.n24.q3; u4.absorption_vs_exhaustion => orderflow.u4.n25.q1, orderflow.u4.n25.q2, orderflow.u4.n25.q3; u4.combined_absorption_read => orderflow.u4.n26.q1, orderflow.u4.n26.q2, orderflow.u4.n26.q4
JUMP QUESTIONS: 12
JUMP PASSING SCORE: 10
JUMP PREREQUISITE QUESTIONS: 6
JUMP TARGET QUESTIONS: 6
JUMP MIN PREREQUISITE SCORE: 5
JUMP MIN TARGET SCORE: 5
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u3.combined_tape_read, u1.aggressive_seller, u2.resting_sides

UNIT 5
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 24
COMPETENCY BLUEPRINT: u5.footprint_basics, u5.diagonal_imbalance, u5.buyer_imbalance, u5.seller_imbalance, u5.stacked_pressure, u5.momentum_failure, u5.delta_vs_volume, u5.positive_delta_divergence, u5.negative_delta_divergence, u5.combined_footprint_read
COMPETENCY MAPPINGS: u5.footprint_basics => footprint_reading; u5.diagonal_imbalance => footprint_interaction, footprint_reading, reading_footprints_imbalances; u5.buyer_imbalance => footprint_interaction, footprint_reading; u5.seller_imbalance => footprint_interaction, footprint_reading; u5.stacked_pressure => evidence_synthesis, footprint_interaction, stacked_pressure; u5.momentum_failure => footprint_interaction, momentum_continuation_failure; u5.delta_vs_volume => footprint_interaction, footprint_reading; u5.positive_delta_divergence => footprint_interaction, footprint_reading; u5.negative_delta_divergence => footprint_interaction, footprint_reading; u5.combined_footprint_read => footprint_interaction, footprint_momentum_challenge, footprint_reading
COMPETENCY SOURCE UNITS: u5.footprint_basics => 5; u5.diagonal_imbalance => 5; u5.buyer_imbalance => 5; u5.seller_imbalance => 5; u5.stacked_pressure => 5; u5.momentum_failure => 5; u5.delta_vs_volume => 5; u5.positive_delta_divergence => 5; u5.negative_delta_divergence => 5; u5.combined_footprint_read => 5
COMPETENCY SOURCE NODES: u5.footprint_basics => 28; u5.diagonal_imbalance => 28; u5.buyer_imbalance => 29; u5.seller_imbalance => 29; u5.stacked_pressure => 32; u5.momentum_failure => 31; u5.delta_vs_volume => 33; u5.positive_delta_divergence => 34; u5.negative_delta_divergence => 34; u5.combined_footprint_read => 36
ELIGIBLE QUESTION IDS: u5.footprint_basics => orderflow.u5.n28.q1, orderflow.u5.n28.q5; u5.diagonal_imbalance => orderflow.u5.n28.q2, orderflow.u5.n28.q4, orderflow.u5.n28.q6; u5.buyer_imbalance => orderflow.u5.n29.q3, orderflow.u5.n29.q5; u5.seller_imbalance => orderflow.u5.n29.q4, orderflow.u5.n29.q6; u5.stacked_pressure => orderflow.u5.n32.q2, orderflow.u5.n32.q4, orderflow.u5.n32.q5; u5.momentum_failure => orderflow.u5.n31.q3, orderflow.u5.n31.q5; u5.delta_vs_volume => orderflow.u5.n33.q2, orderflow.u5.n33.q4, orderflow.u5.n33.q6; u5.positive_delta_divergence => orderflow.u5.n34.q2, orderflow.u5.n34.q4; u5.negative_delta_divergence => orderflow.u5.n34.q3, orderflow.u5.n34.q5; u5.combined_footprint_read => orderflow.u5.n36.q1, orderflow.u5.n36.q5, orderflow.u5.n36.q6
JUMP QUESTIONS: 14
JUMP PASSING SCORE: 12
JUMP PREREQUISITE QUESTIONS: 7
JUMP TARGET QUESTIONS: 7
JUMP MIN PREREQUISITE SCORE: 6
JUMP MIN TARGET SCORE: 6
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u4.combined_absorption_read, u1.aggressive_seller, u2.resting_sides

UNIT 6
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 26
COMPETENCY BLUEPRINT: u6.liquidity_pool, u6.stop_cluster, u6.buy_stops, u6.sell_stops, u6.upside_sweep, u6.downside_sweep, u6.sweep_vs_acceptance, u6.book_depth, u6.iceberg, u6.combined_liquidity_read
COMPETENCY MAPPINGS: u6.liquidity_pool => book_depth; u6.stop_cluster => evidence_synthesis, liquidity_location, liquidity_pools_stop_clusters; u6.buy_stops => evidence_synthesis, liquidity_location; u6.sell_stops => buy_stops_vs_sell_stops, liquidity_location; u6.upside_sweep => evidence_synthesis, upside_vs_downside_sweeps; u6.downside_sweep => multi_signal_read, upside_vs_downside_sweeps; u6.sweep_vs_acceptance => evidence_synthesis, scenario_comparison, sweep_vs_breakout_acceptance; u6.book_depth => book_depth, thin_vs_thick_liquidity; u6.iceberg => evidence_synthesis, multi_signal_read, scenario_comparison; u6.combined_liquidity_read => evidence_synthesis, liquidity_challenge, multi_signal_read
COMPETENCY SOURCE UNITS: u6.liquidity_pool => 6; u6.stop_cluster => 6; u6.buy_stops => 6; u6.sell_stops => 6; u6.upside_sweep => 6; u6.downside_sweep => 6; u6.sweep_vs_acceptance => 6; u6.book_depth => 6; u6.iceberg => 6; u6.combined_liquidity_read => 6
COMPETENCY SOURCE NODES: u6.liquidity_pool => 38; u6.stop_cluster => 38; u6.buy_stops => 39; u6.sell_stops => 39; u6.upside_sweep => 41; u6.downside_sweep => 41; u6.sweep_vs_acceptance => 42; u6.book_depth => 43; u6.iceberg => 44; u6.combined_liquidity_read => 45
ELIGIBLE QUESTION IDS: u6.liquidity_pool => orderflow.u6.n38.q1; u6.stop_cluster => orderflow.u6.n38.q2, orderflow.u6.n38.q4, orderflow.u6.n38.q6; u6.buy_stops => orderflow.u6.n39.q1, orderflow.u6.n39.q3; u6.sell_stops => orderflow.u6.n39.q2, orderflow.u6.n39.q6; u6.upside_sweep => orderflow.u6.n41.q3, orderflow.u6.n41.q5; u6.downside_sweep => orderflow.u6.n41.q2, orderflow.u6.n41.q4; u6.sweep_vs_acceptance => orderflow.u6.n42.q1, orderflow.u6.n42.q2, orderflow.u6.n42.q4, orderflow.u6.n42.q5; u6.book_depth => orderflow.u6.n43.q1, orderflow.u6.n43.q2, orderflow.u6.n43.q4; u6.iceberg => orderflow.u6.n44.q1, orderflow.u6.n44.q2, orderflow.u6.n44.q3, orderflow.u6.n44.q4; u6.combined_liquidity_read => orderflow.u6.n45.q1, orderflow.u6.n45.q2, orderflow.u6.n45.q6
JUMP QUESTIONS: 14
JUMP PASSING SCORE: 12
JUMP PREREQUISITE QUESTIONS: 7
JUMP TARGET QUESTIONS: 7
JUMP MIN PREREQUISITE SCORE: 6
JUMP MIN TARGET SCORE: 6
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u5.combined_footprint_read, u1.aggressive_seller

UNIT 7
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 21
COMPETENCY BLUEPRINT: u7.breakout_pressure, u7.breakdown_pressure, u7.acceptance_above, u7.acceptance_below, u7.failed_breakout, u7.failed_breakdown, u7.breakout_retest, u7.breakdown_retest, u7.sweep_vs_breakout, u7.combined_breakout_read
COMPETENCY MAPPINGS: u7.breakout_pressure => scenario_comparison; u7.breakdown_pressure => evidence_synthesis, multi_signal_read; u7.acceptance_above => acceptance_above_vs_below, evidence_synthesis; u7.acceptance_below => acceptance_above_vs_below, evidence_synthesis; u7.failed_breakout => multi_signal_read, scenario_comparison; u7.failed_breakdown => evidence_synthesis, multi_signal_read; u7.breakout_retest => breakout_and_breakdown_retests, scenario_comparison; u7.breakdown_retest => breakout_and_breakdown_retests, evidence_synthesis; u7.sweep_vs_breakout => evidence_synthesis, multi_signal_read; u7.combined_breakout_read => breakout_challenge, evidence_synthesis, scenario_comparison
COMPETENCY SOURCE UNITS: u7.breakout_pressure => 7; u7.breakdown_pressure => 7; u7.acceptance_above => 7; u7.acceptance_below => 7; u7.failed_breakout => 7; u7.failed_breakdown => 7; u7.breakout_retest => 7; u7.breakdown_retest => 7; u7.sweep_vs_breakout => 7; u7.combined_breakout_read => 7
COMPETENCY SOURCE NODES: u7.breakout_pressure => 47; u7.breakdown_pressure => 47; u7.acceptance_above => 48; u7.acceptance_below => 48; u7.failed_breakout => 50; u7.failed_breakdown => 50; u7.breakout_retest => 51; u7.breakdown_retest => 51; u7.sweep_vs_breakout => 52; u7.combined_breakout_read => 53
ELIGIBLE QUESTION IDS: u7.breakout_pressure => orderflow.u7.n47.q1; u7.breakdown_pressure => orderflow.u7.n47.q2, orderflow.u7.n47.q3; u7.acceptance_above => orderflow.u7.n48.q1, orderflow.u7.n48.q2; u7.acceptance_below => orderflow.u7.n48.q4, orderflow.u7.n48.q6; u7.failed_breakout => orderflow.u7.n50.q1, orderflow.u7.n50.q5, orderflow.u7.n50.q7; u7.failed_breakdown => orderflow.u7.n50.q2, orderflow.u7.n50.q4; u7.breakout_retest => orderflow.u7.n51.q1, orderflow.u7.n51.q5; u7.breakdown_retest => orderflow.u7.n51.q2, orderflow.u7.n51.q7; u7.sweep_vs_breakout => orderflow.u7.n52.q3, orderflow.u7.n52.q4; u7.combined_breakout_read => orderflow.u7.n53.q1, orderflow.u7.n53.q2, orderflow.u7.n53.q8
JUMP QUESTIONS: 16
JUMP PASSING SCORE: 13
JUMP PREREQUISITE QUESTIONS: 8
JUMP TARGET QUESTIONS: 8
JUMP MIN PREREQUISITE SCORE: 6
JUMP MIN TARGET SCORE: 6
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u6.sweep_vs_acceptance, u6.combined_liquidity_read, u1.aggressive_seller

UNIT 8
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 30
COMPETENCY BLUEPRINT: u8.healthy_pullback, u8.pullback_depth, u8.continuation_trigger, u8.bearish_continuation, u8.flow_at_vwap, u8.flow_at_average, u8.pullback_failure, u8.conflicting_signals, u8.volume_context, u8.no_clear_read
COMPETENCY MAPPINGS: u8.healthy_pullback => evidence_synthesis; u8.pullback_depth => healthy_pullbacks_pullback_depth; u8.continuation_trigger => continuation_triggers, evidence_synthesis; u8.bearish_continuation => bullish_vs_bearish_pullbacks, evidence_synthesis, tape_reading; u8.flow_at_vwap => evidence_synthesis, footprint_interaction, order_flow_at_vwap_moving_averages; u8.flow_at_average => evidence_synthesis, order_flow_at_vwap_moving_averages; u8.pullback_failure => evidence_synthesis, pullback_failure, tape_reading; u8.conflicting_signals => evidence_synthesis, multi_signal_read, tape_reading; u8.volume_context => footprint_reading, multi_signal_read; u8.no_clear_read => confirmation_continuation_challenge, multi_signal_read
COMPETENCY SOURCE UNITS: u8.healthy_pullback => 8; u8.pullback_depth => 8; u8.continuation_trigger => 8; u8.bearish_continuation => 8; u8.flow_at_vwap => 8; u8.flow_at_average => 8; u8.pullback_failure => 8; u8.conflicting_signals => 8; u8.volume_context => 8; u8.no_clear_read => 8
COMPETENCY SOURCE NODES: u8.healthy_pullback => 55; u8.pullback_depth => 55; u8.continuation_trigger => 57; u8.bearish_continuation => 56; u8.flow_at_vwap => 58; u8.flow_at_average => 58; u8.pullback_failure => 59; u8.conflicting_signals => 60; u8.volume_context => 61; u8.no_clear_read => 62
ELIGIBLE QUESTION IDS: u8.healthy_pullback => orderflow.u8.n55.q1, orderflow.u8.n55.q3; u8.pullback_depth => orderflow.u8.n55.q2, orderflow.u8.n55.q4; u8.continuation_trigger => orderflow.u8.n57.q2, orderflow.u8.n57.q3, orderflow.u8.n57.q5; u8.bearish_continuation => orderflow.u8.n56.q1, orderflow.u8.n56.q2, orderflow.u8.n56.q4; u8.flow_at_vwap => orderflow.u8.n58.q1, orderflow.u8.n58.q5, orderflow.u8.n58.q7; u8.flow_at_average => orderflow.u8.n58.q2, orderflow.u8.n58.q4; u8.pullback_failure => orderflow.u8.n59.q1, orderflow.u8.n59.q3, orderflow.u8.n59.q4, orderflow.u8.n59.q5; u8.conflicting_signals => orderflow.u8.n60.q1, orderflow.u8.n60.q2, orderflow.u8.n60.q3; u8.volume_context => orderflow.u8.n61.q1, orderflow.u8.n61.q2, orderflow.u8.n61.q3, orderflow.u8.n61.q4, orderflow.u8.n61.q5, orderflow.u8.n61.q6; u8.no_clear_read => orderflow.u8.n62.q3, orderflow.u8.n62.q6
JUMP QUESTIONS: 16
JUMP PASSING SCORE: 13
JUMP PREREQUISITE QUESTIONS: 8
JUMP TARGET QUESTIONS: 8
JUMP MIN PREREQUISITE SCORE: 6
JUMP MIN TARGET SCORE: 6
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u6.sweep_vs_acceptance, u7.failed_breakdown, u7.combined_breakout_read

UNIT 9
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 28
COMPETENCY BLUEPRINT: u9.reversal_pressure, u9.buyer_trap, u9.seller_trap, u9.buyer_exhaustion_reversal, u9.seller_exhaustion_reversal, u9.absorption_reversal, u9.double_top_flow, u9.double_bottom_flow, u9.reversal_confirmation, u9.insufficient_evidence
COMPETENCY MAPPINGS: u9.reversal_pressure => evidence_synthesis, footprint_reading, multi_signal_read, reversal_pressure; u9.buyer_trap => multi_signal_read, scenario_comparison; u9.seller_trap => multi_signal_read, scenario_comparison; u9.buyer_exhaustion_reversal => footprint_reading; u9.seller_exhaustion_reversal => tape_reading; u9.absorption_reversal => absorption_reversals, evidence_synthesis, multi_signal_read; u9.double_top_flow => scenario_comparison; u9.double_bottom_flow => scenario_comparison; u9.reversal_confirmation => footprint_reading, multi_signal_read; u9.insufficient_evidence => multi_signal_read
COMPETENCY SOURCE UNITS: u9.reversal_pressure => 9; u9.buyer_trap => 9; u9.seller_trap => 9; u9.buyer_exhaustion_reversal => 9; u9.seller_exhaustion_reversal => 9; u9.absorption_reversal => 9; u9.double_top_flow => 9; u9.double_bottom_flow => 9; u9.reversal_confirmation => 9; u9.insufficient_evidence => 9
COMPETENCY SOURCE NODES: u9.reversal_pressure => 64; u9.buyer_trap => 65; u9.seller_trap => 65; u9.buyer_exhaustion_reversal => 66; u9.seller_exhaustion_reversal => 66; u9.absorption_reversal => 67; u9.double_top_flow => 68; u9.double_bottom_flow => 68; u9.reversal_confirmation => 69; u9.insufficient_evidence => 69
ELIGIBLE QUESTION IDS: u9.reversal_pressure => orderflow.u9.n64.q1, orderflow.u9.n64.q2, orderflow.u9.n64.q4, orderflow.u9.n64.q5; u9.buyer_trap => orderflow.u9.n65.q1, orderflow.u9.n65.q3, orderflow.u9.n65.q5; u9.seller_trap => orderflow.u9.n65.q2, orderflow.u9.n65.q4, orderflow.u9.n65.q6; u9.buyer_exhaustion_reversal => orderflow.u9.n66.q2; u9.seller_exhaustion_reversal => orderflow.u9.n66.q1; u9.absorption_reversal => orderflow.u9.n67.q1, orderflow.u9.n67.q2, orderflow.u9.n67.q4, orderflow.u9.n67.q5; u9.double_top_flow => orderflow.u9.n68.q1, orderflow.u9.n68.q3, orderflow.u9.n68.q5; u9.double_bottom_flow => orderflow.u9.n68.q2, orderflow.u9.n68.q4, orderflow.u9.n68.q6; u9.reversal_confirmation => orderflow.u9.n69.q1, orderflow.u9.n69.q3, orderflow.u9.n69.q5, orderflow.u9.n69.q6; u9.insufficient_evidence => orderflow.u9.n69.q2, orderflow.u9.n69.q7
JUMP QUESTIONS: 18
JUMP PASSING SCORE: 15
JUMP PREREQUISITE QUESTIONS: 9
JUMP TARGET QUESTIONS: 9
JUMP MIN PREREQUISITE SCORE: 7
JUMP MIN TARGET SCORE: 7
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u6.sweep_vs_acceptance, u7.failed_breakdown, u8.pullback_failure, u8.no_clear_read

UNIT 10
QUESTIONS PER ATTEMPT: 10
PASSING SCORE: 8
POOL SIZE: 30
COMPETENCY BLUEPRINT: u10.entry_plan, u10.order_type, u10.slippage, u10.invalidation, u10.thin_liquidity_risk, u10.no_clear_read, u10.exit_liquidity, u10.review_process, u10.multi_source_evidence, u10.combined_execution_read
COMPETENCY MAPPINGS: u10.entry_plan => evidence_synthesis, planning_the_entry_choosing_the_order_type, scenario_comparison; u10.order_type => planning_the_entry_choosing_the_order_type; u10.slippage => book_depth, evidence_synthesis, multi_signal_read; u10.invalidation => evidence_synthesis, order_flow_invalidation; u10.thin_liquidity_risk => book_depth, market_sequence; u10.no_clear_read => evidence_synthesis, no_clear_read; u10.exit_liquidity => evidence_synthesis, exiting_into_liquidity, liquidity_location, multi_signal_read; u10.review_process => reviewing_the_full_order_flow_read; u10.multi_source_evidence => multi_signal_read; u10.combined_execution_read => multi_signal_read, scenario_comparison
COMPETENCY SOURCE UNITS: u10.entry_plan => 10; u10.order_type => 10; u10.slippage => 10; u10.invalidation => 10; u10.thin_liquidity_risk => 10; u10.no_clear_read => 10; u10.exit_liquidity => 10; u10.review_process => 10; u10.multi_source_evidence => 10; u10.combined_execution_read => 10
COMPETENCY SOURCE NODES: u10.entry_plan => 71; u10.order_type => 71; u10.slippage => 72; u10.invalidation => 73; u10.thin_liquidity_risk => 72; u10.no_clear_read => 74; u10.exit_liquidity => 75; u10.review_process => 76; u10.multi_source_evidence => 76; u10.combined_execution_read => 76
ELIGIBLE QUESTION IDS: u10.entry_plan => orderflow.u10.n71.q1, orderflow.u10.n71.q3, orderflow.u10.n71.q5; u10.order_type => orderflow.u10.n71.q2, orderflow.u10.n71.q4, orderflow.u10.n71.q6; u10.slippage => orderflow.u10.n72.q1, orderflow.u10.n72.q3, orderflow.u10.n72.q5; u10.invalidation => orderflow.u10.n73.q2, orderflow.u10.n73.q3, orderflow.u10.n73.q5; u10.thin_liquidity_risk => orderflow.u10.n72.q2, orderflow.u10.n72.q4; u10.no_clear_read => orderflow.u10.n74.q1, orderflow.u10.n74.q2, orderflow.u10.n74.q3, orderflow.u10.n74.q4, orderflow.u10.n74.q5; u10.exit_liquidity => orderflow.u10.n75.q1, orderflow.u10.n75.q2, orderflow.u10.n75.q3, orderflow.u10.n75.q5; u10.review_process => orderflow.u10.n76.q1; u10.multi_source_evidence => orderflow.u10.n76.q2, orderflow.u10.n76.q4, orderflow.u10.n76.q6, orderflow.u10.n76.q7; u10.combined_execution_read => orderflow.u10.n76.q5, orderflow.u10.n76.q8
JUMP QUESTIONS: 20
JUMP PASSING SCORE: 16
JUMP PREREQUISITE QUESTIONS: 10
JUMP TARGET QUESTIONS: 10
JUMP MIN PREREQUISITE SCORE: 8
JUMP MIN TARGET SCORE: 8
JUMP PREREQUISITES: u1.market_buy_routing, u2.thick_liquidity, u3.price_confirmation, u4.absorption_vs_exhaustion, u5.delta_vs_volume, u6.sweep_vs_acceptance, u7.failed_breakdown, u8.pullback_failure, u9.reversal_confirmation, u9.insufficient_evidence
