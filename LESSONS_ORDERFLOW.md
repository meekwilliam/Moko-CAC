# Order Flow — strategy course authoring source

Course id: `orderflow`  ·  accent `#14B8A6`  ·  standalone strategy track (always unlocked).
Mirrors Moko/GameData.json. Correct answer is listed FIRST for [MC]/[FILL] (the app shuffles).
No INTRO blocks — lessons start cold.

Interactive order-flow mechanics:
  [AGGRESSOR] event: lift|hit — a live DOM ladder is consumed; tap buyer/seller. lift⇒buyer, hit⇒seller.
  [BOOKDRAG]  order: market_buy|market_sell — drag the order to the side it fills. buy⇒ask, sell⇒bid.


UNIT 1 — Order Flow Foundations

NODE 1
TITLE: What Is Order Flow?
CELEBRATION: You get what order flow really means.

[MC] What does “order flow” describe?
The live stream of buy and sell orders hitting the market — the real demand and supply behind each move.
The order in which candlesticks form across the trading day.
The sequence of chart patterns a stock cycles through.
WHY: Order flow is the actual orders that move price. Candles and patterns are the *result* of that flow, not the flow itself.

[TF] Order flow looks at the orders behind price, not only the finished price line.
ANSWER: True
WHY: The whole point is reading the pressure that moves price before it shows up as a completed candle.

[AGGRESSOR] Buyers are aggressively taking the offers on this ladder. Who is the aggressor?
EVENT: lift
ANSWER: The buyer
WHY: The side sending market orders that eat resting liquidity is the aggressor. Here that's the buyer.

[MATCH] Match each term to what it really is.
Order flow => The live stream of buy/sell orders
Price => The result of orders executing
A candle => A record of past prices
WHY: Orders come first; price is the outcome; the candle is a record after the fact.

[FILL] Order flow reads the [___] between aggressive buyers and aggressive sellers.
balance
color
calendar
WHY: When buyers are more aggressive than sellers, price rises; when sellers dominate, it falls. It's a balance of pressure.

[ORDER] Put the cause-and-effect chain in the right order.
Buyers and sellers place orders
Orders execute against each other
Price moves to the last fill
The candle updates on the chart
WHY: Orders drive fills, fills set price, and only then does the chart redraw. Order-flow traders watch the front of that chain.

NODE 2
TITLE: Aggressive vs. Passive Orders
CELEBRATION: You can tell takers from makers.

[MC] What is an aggressive (market) order?
An order that takes whatever price is available now, removing liquidity.
An order that waits at a set price until someone trades with it.
An order that can only fill during the opening auction.
WHY: A market order crosses the spread to fill immediately — it *takes* liquidity. That aggression is what pushes price.

[MC] What is a passive (limit) order?
An order resting at a chosen price, providing liquidity until someone hits it.
An order that always fills instantly at the current price.
An order the broker places automatically for you.
WHY: A limit order sits in the book and waits. It *provides* liquidity; it doesn't move price until an aggressor trades against it.

[BOOKDRAG] Route this MARKET BUY to the side of the book it fills against.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the resting sell orders — it fills at the ask.

[BOOKDRAG] Route this MARKET SELL to the side of the book it fills against.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the resting buy orders — it fills at the bid.

[MATCH] Sort each into taker or maker.
Market buy that fills instantly => Taker
Limit sell resting above price => Maker
Hitting the bid to get out fast => Taker
WHY: Anything that fills immediately by crossing the spread is a taker; anything resting and waiting is a maker.

[TF] Aggressive orders remove liquidity; passive orders provide it.
ANSWER: True
WHY: Takers (market orders) consume the resting orders that makers (limit orders) supply.

[AGGRESSOR] Sellers are aggressively taking the bids here. Who is the aggressor?
EVENT: hit
ANSWER: The seller
WHY: The side sending the market orders is the aggressor — here, the seller hitting the bid.

NODE 3
TITLE: The Bid, Ask & Spread
CELEBRATION: You own the bid, ask and spread.

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

[BOOKDRAG] You want in NOW. Drag your market buy to the side you'll fill against.
ORDER: market_buy
ANSWER: the ask
WHY: Buying immediately means paying the ask — you lift the offer.

[BOOKDRAG] You want out NOW. Drag your market sell to the side you'll fill against.
ORDER: market_sell
ANSWER: the bid
WHY: Selling immediately means hitting the bid.

[MATCH] Match the action to the price you trade at.
Market buy (take now) => The ask
Market sell (take now) => The bid
The spread => Ask minus bid
WHY: Buyers in a hurry pay the ask; sellers in a hurry hit the bid; the spread is the distance between them.

[TF] A wider spread generally signals thinner liquidity.
ANSWER: True
WHY: When few orders rest near price, the best bid and ask sit further apart, so the spread widens.

NODE 4
TITLE: Lifting the Offer & Hitting the Bid
CELEBRATION: You can read aggression in the book.

[MC] What does “lifting the offer” mean?
Aggressively buying the resting sell orders at the ask.
Cancelling your sell order above the market.
Posting a new offer higher than the last one.
WHY: Lifting the offer means a buyer sends market orders that consume the asks — aggressive buying that pushes price up.

[AGGRESSOR] Watch the offers get eaten. Someone is lifting the offer — who is the aggressor?
EVENT: lift
ANSWER: The buyer
WHY: Lifting the offer is aggressive buying: the buyer is taking the resting sell orders.

[AGGRESSOR] Now the bids are getting eaten. Someone is hitting the bid — who is the aggressor?
EVENT: hit
ANSWER: The seller
WHY: Hitting the bid is aggressive selling: the seller is taking the resting buy orders.

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

[BOOKDRAG] A buyer wants to lift the offer. Route their market order to the right side.
ORDER: market_buy
ANSWER: the ask
WHY: Lifting the offer means taking the ask — that's where a market buy fills.

[AGGRESSOR] Buyers keep lifting offers while sellers barely show. Who is in control here?
EVENT: lift
ANSWER: The buyer
WHY: Persistent lifting with little selling is aggressive demand — the buyer is the aggressor and in control.

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

[ORDER] Order these from cause to visible effect.
Aggressive buyers outnumber aggressive sellers
Resting offers get absorbed
Price ticks up to higher asks
A green candle prints
WHY: Imbalance → offers absorbed → price rises → the chart finally shows it. Order-flow traders read step one.

[MATCH] Match the order-flow condition to what price does.
Buy-side imbalance => Trends up
Sell-side imbalance => Trends down
Balanced aggression => Ranges sideways
WHY: Direction follows whichever side is more aggressive; balance means no trend.

[AGGRESSOR] Price is grinding higher on relentless buying. Who is the aggressor driving it?
EVENT: lift
ANSWER: The buyer
WHY: A demand imbalance — aggressive buyers lifting offers — is pushing price up.

[BOOKDRAG] To push price UP, an aggressive buyer must take which side?
ORDER: market_buy
ANSWER: the ask
WHY: Taking the ask (lifting offers) is what walks price up to higher levels.

NODE 6
TITLE: Order Flow Foundations Review
CELEBRATION: Foundations mastered — you read the flow behind price.

[AGGRESSOR] The offers are getting consumed. Who is the aggressor?
EVENT: lift
ANSWER: The buyer
WHY: When offers (asks) are being taken, the buyer is the aggressor — lifting the offer.

[BOOKDRAG] Route the MARKET BUY to the side it fills against.
ORDER: market_buy
ANSWER: the ask
WHY: A market buy takes the ask.

[BOOKDRAG] Route the MARKET SELL to the side it fills against.
ORDER: market_sell
ANSWER: the bid
WHY: A market sell hits the bid.

[MATCH] Match each term to its meaning.
Bid => Best price buyers will pay
Ask => Best price sellers will accept
Spread => The gap between them
Imbalance => One side more aggressive
WHY: These four ideas are the backbone of every order-flow read.

[MC] Order flow is best described as…
The real-time buying and selling pressure that moves price.
The order in which chart patterns appear.
A schedule of company news events.
WHY: It's the live pressure behind price — the cause, not the chart-shaped effect.

[ORDER] Rebuild the chain from order to chart.
Aggressive orders hit the market
They execute against resting orders
Price moves to the next level
The candle updates
WHY: Orders → fills → price → chart. Order-flow traders live at the front of that chain.

[TF] You buy at the ask and sell at the bid when you trade aggressively.
ANSWER: True
WHY: Crossing the spread means paying the ask to buy now or hitting the bid to sell now.

[AGGRESSOR] The bids are getting consumed on the ladder. Who is the aggressor?
EVENT: hit
ANSWER: The seller
WHY: When bids are being taken, the seller is the aggressor — hitting the bid.
