# Dataset Overview

The dataset covers synthetic e-commerce transactional data from January 2023 to June 2025,
with 1,200 orders and 14 columns: OrderID, Date, CustomerID, Product, Quantity, UnitPrice,
TotalPrice, PaymentMethod, OrderStatus, TrackingNumber, ItemsInCart, CouponCode, ReferralSource,and ShippingAddress.

The products covered are Tablet, Printer, Chair, Laptop, Desk, Monitor,
and Phone. Payment methods include Online, Cash, Credit Card, Debit Card, and Gift Card. Customers were acquired
through Instagram, Email, Facebook, Google, and Referral. Order statuses are Delivered, Shipped, Pending, Cancelled, 
and Returned.

# Data Cleaning

Problem 1 — Null values in CouponCode
The original Excel file had missing values in the CouponCode column.
Orders without a coupon were stored as NaN instead of a meaningful label.
Fixed by filling nulls with 'No Coupon' so the column stays usable in groupby operations without distorting counts.

Problem 2 — Date column stored as string
The Date column was loaded as an object dtype, which blocks any time-series or date-based filtering.
Converted to proper datetime format to enable monthly aggregations and trend analysis.

Problem 3 — No duplicates or missing values elsewhere
Confirmed zero duplicate rows and zero nulls across all other 13 columns — no further cleaning required.


# Exploratory Data Analysis

 Revenue by Product
Revenue is spread almost evenly across all seven products. Chair leads at $195,620,
followed closely by Printer at $195,613 and Laptop at $192,127.
Tablet comes in at $186,569, Monitor at $175,651, and Desk at $167,460. 
Phone generates the least at $151,722. The gap between first and last 
is only ~$44K on a $1.26M total — around 3.5% — which means the product catalogue is balanced and not driven by 
one hero SKU.

 Order Status Distribution
This is the most critical finding in the dataset. Only 231 orders (19.25%) were actually delivered.
Cancelled orders are the most frequent at 250 (20.83%), followed by Returned at 247 (20.58%),
Pending at 237 (19.75%), and Shipped at 235 (19.58%). Cancellations and returns together account 
for over 41% of all orders — almost 500 out of 1,200. Roughly 2 in 5 orders never result in a completed sale.

Revenue by Referral Source
Instagram leads in total revenue at $275,285 with an average order value of $1,062.
Email comes second at $261,809 and an AOV of $1,047. Google and Facebook are close behind at $250,441
and $250,411 respectively, but Facebook stands out with the highest average order value across
all channels at $1,098 — meaning Facebook customers tend to spend more per transaction despite lower volume.
Referral brings in the least at $226,816.

High-Value Orders
180 orders out of 1,200 have a total price above $2,000 — that is 15% of all orders but they
carry a disproportionate share of total revenue

Coupon Usage
About 74% of customers used a discount code. FREESHIP was the most used at 313 orders,
followed by No Coupon at 309, WINTER15 at 292, and SAVE10 at 286.
The fact that FREESHIP tops the list suggests shipping cost is a real barrier to purchase completion.

# SQL Analysis

Five queries were written to answer specific business questions. The first filters delivered credit card 
orders sorted newest to oldest, useful for reconciliation and fulfillment audits.
The second isolates transactions above $2,000 ordered by value to identify high-spending customers.
The third groups by product to show total units sold, gross revenue, and average unit price per category. 
The fourth compares referral sources by total conversions, revenue, and average order value to identify
the most efficient acquisition channels. The fifth uses a window function to calculate each order 
status as a percentage of total orders without needing a subquery.

# Business Recommendations

1. Fix the cancellation and return rate — urgently.
 41% of orders never complete. That is the single biggest revenue leak in this dataset.
 The business needs to investigate why orders are cancelled — whether it is pricing, shipping time,
 or UX issues — and why returns are so high. Scaling marketing spend without fixing this just amplifies the problem.

3. Prioritize Facebook for high-value customer acquisition.
Facebook has the highest average order value ($1,098) of any channel. If the goal is to attract big-ticket buyers,
 Facebook is likely the most efficient channel — not Instagram, despite its higher total volume.

3. Review the FREESHIP coupon strategy.
It is the most-used coupon, which means customers respond strongly to free shipping. Consider making
it a loyalty perk rather than a public code to protect margins while keeping the conversion effect.

4. Investigate the Phone category.
Phones generate the lowest revenue ($151K) despite being a frequently purchased product type.
Either unit prices are low or demand is weaker. A price vs. volume comparison against other categories would
clarify the next step.

5. Target high-value customers for retention.
180 customers placed orders over $2,000. Segmenting repeat high-value buyers from one-time big spenders
could unlock a more focused retention or CRM strategy.


# Tools Used

Python — Pandas, NumPy, Matplotlib, Seaborn
SQL — T-SQL (GROUP BY, window functions)
Power BI — Dashboard with KPI cards, donut chart, bar charts, line trend
Excel — Original data source,power query
