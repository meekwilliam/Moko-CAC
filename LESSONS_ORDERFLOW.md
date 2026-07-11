# Order Flow — strategy course authoring source

Course id: `orderflow`  ·  accent `#14B8A6`  ·  standalone strategy track (always unlocked).
Mirrors what ships in Moko/GameData.json. Correct answer is listed FIRST for [MC]/[FILL]
(the app shuffles them). No INTRO blocks — lessons start cold, like the rest of the app.


UNIT 1 — Order Flow Foundations

NODE 1
TITLE: What Is Order Flow?
CELEBRATION: You get what order flow really means.

[MC] What does “order flow” describe?
The live stream of buy and sell orders hitting the market — the real demand and supply behind each move.
The order in which candlesticks form across the trading day.
The sequence of chart patterns a stock cycles through.
WHY: Order flow is the actual orders that move price. Chart patterns and candle shapes are the *result* of that flow, not the flow itself.

[MC] Price on a chart is the result of what?
Buy and sell orders executing against each other.
The exchange publishing a fair value each morning.
A company's latest earnings estimate.
WHY: Every tick of price is just the last order that filled. Order flow reads what's driving those fills.

[TF] Order flow analysis looks at the orders behind price, not only the finished price line.
ANSWER: True
WHY: That's the whole point: understand the pressure that moves price before it shows up as a completed candle.

[FILL] Order flow reads the [___] between aggressive buyers and aggressive sellers.
balance
color
calendar
WHY: When buyers are more aggressive than sellers, price rises; when sellers dominate, it falls. It's a balance of pressure.

[MATCH] Match each term to what it really is.
Order flow => The live stream of buy/sell orders
Price => The result of orders executing
A candle => A summary of past prices
WHY: Orders come first; price is the outcome; the candle is a record after the fact.

[ORDER] Put the cause-and-effect chain in the right order.
Buyers and sellers place orders
Orders execute against each other
Price moves to the last fill
The candle updates on the chart
WHY: Orders drive fills, fills set price, and only then does the chart redraw. Order-flow traders watch the front of that chain.

NODE 2
TITLE: Aggressive vs Passive Orders
CELEBRATION: You can tell takers from makers.

[MC] What is an aggressive (market) order?
An order that takes whatever price is available right now, removing liquidity.
An order that waits at a set price until someone trades with it.
An order that can only fill during the opening auction.
WHY: A market order crosses the spread to fill immediately — it *takes* liquidity. That aggression is what pushes price.

[MC] What is a passive (limit) order?
An order resting at a chosen price, providing liquidity until someone hits it.
An order that always fills instantly at the current price.
An order the broker places automatically on your behalf.
WHY: A limit order sits in the book and waits. It *provides* liquidity; it doesn't move price until an aggressor trades against it.

[TF] Aggressive orders remove liquidity; passive orders provide it.
ANSWER: True
WHY: Takers (market orders) consume the resting orders that makers (limit orders) supply.

[FILL] It's the [___] orders — the ones crossing the spread to fill now — that actually push price.
aggressive
passive
cancelled
WHY: Resting limit orders just sit there. Price only moves when aggressive orders lift offers or hit bids.

[MATCH] Sort each into taker or maker.
Market buy that fills instantly => Taker
Limit sell resting above price => Maker
Hitting the bid to get out fast => Taker
WHY: Anything that fills immediately by crossing the spread is a taker; anything resting and waiting is a maker.

[MC] Two traders both want in. One posts a limit bid and waits; the other sends a market buy. Which one moves price?
The market buy — it crosses the spread and lifts the offer.
The limit bid — posting it raises the price.
Neither; only the exchange moves price.
WHY: Placing a resting bid doesn't move price. Sending a market order that consumes the offer does.

NODE 3
TITLE: The Bid, the Ask & the Spread
CELEBRATION: You own the bid/ask/spread.

[MC] What is the bid?
The highest price buyers are currently willing to pay.
The lowest price sellers will accept.
The last price a trade printed at.
WHY: The bid is the best resting buy order. Sell into it and you trade at the bid.

[MC] What is the ask (or offer)?
The lowest price sellers are currently willing to accept.
The highest price buyers will pay.
The average of the day's high and low.
WHY: The ask is the best resting sell order. Buy from it and you trade at the ask.

[FILL] The gap between the bid and the ask is the [___].
spread
range
gap
WHY: The spread is the distance between the best buy and best sell orders — the cost of crossing from one side to the other.

[TF] A wider spread generally signals thinner liquidity.
ANSWER: True
WHY: When few orders rest near price, the best bid and ask sit further apart, so the spread widens.

[MC] A stock is 10.00 bid, 10.02 ask. You send a market buy. Where do you most likely fill?
Around 10.02 — you pay the ask to buy now.
Around 10.00 — you get the bid.
Around 10.01 — always the midpoint.
WHY: A market buy crosses the spread and lifts the offer, so you pay the ask side, ~10.02.

[MATCH] Match the action to the price you trade at.
Market buy (take now) => The ask
Market sell (take now) => The bid
The spread => Ask minus bid
WHY: Buyers in a hurry pay the ask; sellers in a hurry hit the bid; the spread is the distance between them.

NODE 4
TITLE: Lifting the Offer, Hitting the Bid
CELEBRATION: You can read aggression in the book.

[MC] What does “lifting the offer” mean?
Aggressively buying the resting sell orders at the ask.
Cancelling your sell order above the market.
Posting a new offer higher than the last one.
WHY: Lifting the offer means a buyer sends market orders that consume the asks — aggressive buying that pushes price up.

[MC] What does “hitting the bid” mean?
Aggressively selling into the resting buy orders at the bid.
Raising your bid to buy more.
Placing a limit buy at the current bid.
WHY: Hitting the bid means a seller sends market orders that consume the bids — aggressive selling that pushes price down.

[TF] Repeatedly lifting the offer tends to push price up.
ANSWER: True
WHY: Each lift eats through resting sell orders; as they clear, the next-best ask is higher, so price climbs.

[FILL] When sellers keep [___] the bid, resting buy orders get eaten and price tends to fall.
hitting
posting
raising
WHY: Hitting the bid is aggressive selling. As bids clear, the next-best bid is lower, dragging price down.

[MATCH] Match the aggression to its effect.
Buyers lifting the offer => Price pushed up
Sellers hitting the bid => Price pushed down
Only resting limit orders, no takers => Price stays put
WHY: Price moves in the direction of the aggressor. With no takers, the book just sits.

[MC] You watch buyers repeatedly lift the offer while few sellers step up. What's the read?
Buyers are in control — aggressive demand is absorbing supply and lifting price.
Sellers are in control, since offers are being posted.
The move is meaningless without an earnings report.
WHY: Persistent lifting with little selling pressure is aggressive demand — a bullish order-flow read.

NODE 5
TITLE: What Actually Moves Price
CELEBRATION: You understand imbalance.

[MC] Ultimately, what moves price?
An imbalance between aggressive buyers and aggressive sellers.
The number of shares a company has outstanding.
How many candlesticks have printed that day.
WHY: Price moves when one side's aggression outweighs the other's. Balanced aggression means price barely moves.

[TF] If aggressive buying and aggressive selling are roughly balanced, price tends to stay range-bound.
ANSWER: True
WHY: Matched aggression cancels out — orders fill back and forth near the same level, so price chops sideways.

[FILL] A one-sided [___] of aggressive orders is what drives a strong directional move.
imbalance
average
schedule
WHY: Trends come from imbalance: far more aggression on one side than the other.

[MC] Price is grinding higher on steady buying while sellers barely appear. In order-flow terms, this is…
A demand imbalance — aggressive buyers dominating.
A supply imbalance — sellers dominating.
Perfect balance between both sides.
WHY: More aggressive buying than selling is a demand imbalance, which lifts price.

[ORDER] Order these from cause to visible effect.
Aggressive buyers outnumber aggressive sellers
Resting offers get absorbed
Price ticks up to higher asks
A green candle prints
WHY: Imbalance → offers absorbed → price rises → the chart finally shows it. Order-flow traders are reading step one.

[MATCH] Match the order-flow condition to what price does.
Buy-side imbalance => Trends up
Sell-side imbalance => Trends down
Balanced aggression => Ranges sideways
WHY: Direction follows whichever side is more aggressive; balance means no trend.

NODE 6
TITLE: Order Flow Foundations Review
CELEBRATION: Foundations mastered — you read the flow behind price.

[MC] Order flow is best described as…
The real-time buying and selling pressure that moves price.
The order in which chart patterns appear.
A schedule of company news events.
WHY: It's the live pressure behind price — the cause, not the chart-shaped effect.

[MC] Which order removes liquidity and can move price?
An aggressive market order.
A passive limit order resting in the book.
A cancelled order.
WHY: Takers (market orders) cross the spread and move price; resting makers just wait.

[TF] You buy at the ask and sell at the bid when you trade aggressively.
ANSWER: True
WHY: Crossing the spread means paying the ask to buy now or hitting the bid to sell now.

[FILL] “Lifting the offer” is aggressive [___] that tends to push price up.
buying
selling
posting
WHY: Lifting the offer eats resting sell orders — aggressive demand.

[MATCH] Match each term to its meaning.
Bid => Best price buyers will pay
Ask => Best price sellers will accept
Spread => The gap between them
Imbalance => One side more aggressive
WHY: These four ideas are the backbone of every order-flow read.

[MC] A stock grinds up on relentless offer-lifting while sellers barely show. Best read?
Demand imbalance — aggressive buyers in control.
Supply imbalance — sellers in control.
No information without a chart pattern.
WHY: Persistent aggressive buying with little selling is a demand imbalance — the core bullish order-flow signal.

[ORDER] Rebuild the chain from order to chart.
Aggressive orders hit the market
They execute against resting orders
Price moves to the next level
The candle updates
WHY: Orders → fills → price → chart. Order-flow traders live at the front of that chain.
