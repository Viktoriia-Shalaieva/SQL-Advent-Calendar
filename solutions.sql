/*
Day 1 of SQL Advent Calendar
Today's Question:

A ski resort company want to know which customers rented ski equipment for more than one type of activity (e.g., skiing and snowboarding). 
List the customer names and the number of distinct activities they rented equipment for.

Table name: rentals

rental_id	customer_name	activity	rental_date
1	Emily	Skiing	2024-01-01
2	Michael	Snowboarding	2024-01-02
3	Emily	Snowboarding	2024-01-03
4	Sarah	Skiing	2024-01-01
5	Michael	Skiing	2024-01-02
6	Michael	Snowtubing	2024-01-02
*/

SELECT 
    customer_name
    , COUNT(DISTINCT activity) AS number_of_distinct_activities
FROM 
    rentals
GROUP BY 
    customer_name
HAVING 
    COUNT(DISTINCT activity) > 1
;

/*
Day 2 of SQL Advent Calendar
Today's Question:

Santa wants to know which gifts weigh more than 1 kg. Can you list them?

Table name: gifts

gift_name	recipient	weight_kg
Toy Train	John	2.5
Chocolate Box	Alice	0.8
Teddy Bear	Sophia	1.2
Board Game	Liam	0.9
*/
SELECT
    gift_name
FROM 
    gifts
WHERE weight_kg > 1
;

/*
Day 3 of SQL Advent Calendar
Today's Question:

You’re trying to identify the most calorie-packed candies to avoid during your holiday binge. Write a query to rank candies based on their calorie count within each category. Include the candy_name, candy_category, calories, and rank (rank_in_category) within the category.

Table name: candy_nutrition

candy_id	candy_name	calories	candy_category
1	Candy Cane	200	Sweets
2	Chocolate Bar	250	Chocolate
3	Gingerbread Cookie	150	Baked Goods
4	Lollipop	100	Sweets
5	Dark Chocolate Truffle	180	Chocolate
6	Marshmallow	900	Sweets
7	Sugar Cookie	140	Baked Goods
*/

SELECT 
    candy_name
    , candy_category
    , calories
    , RANK() OVER (PARTITION BY candy_category ORDER BY calories DESC) AS rank_in_category
FROM
    candy_nutrition
;

/*
Day 4 of SQL Advent Calendar
Today's Question:

You’re planning your next ski vacation and want to find the best regions with heavy snowfall. Given the tables resorts and snowfall, find the average snowfall for each region and sort the regions in descending order of average snowfall. Return the columns region and average_snowfall.

Table name: ski_resorts

resort_id	resort_name	region
1	Snowy Peaks	Rocky Mountains
2	Winter Wonderland	Wasatch Range
3	Frozen Slopes	Alaska Range
4	Powder Paradise	Rocky Mountains
Table name: snowfall

resort_id	snowfall_inches
1	60
2	45
3	75
4	55
*/

SELECT
    sr.region
    ,  AVG(snowfall_inches) AS average_snowfall
FROM 
    ski_resorts sr
JOIN 
    snowfall s
ON
    sr.resort_id = s.resort_id
GROUP BY
    sr.region
ORDER BY 
    average_snowfall DESC
;

/*
Day 5 of SQL Advent Calendar
Today's Question:

This year, we're celebrating Christmas in the Southern Hemisphere! Which beaches are expected to have temperatures above 30°C on Christmas Day?

Table name: beach_temperature_predictions

beach_name	country	expected_temperature_c	date
Bondi Beach	Australia	32	2024-12-24
Copacabana Beach	Brazil	28	2024-12-24
Clifton Beach	South Africa	31	2024-12-25
Brighton Beach	New Zealand	25	2024-12-25
*/

SELECT
    beach_name
FROM 
    beach_temperature_predictions
WHERE 
    expected_temperature_c > 30 AND
    date = '2024-12-25'
;

/*
Day 6 of SQL Advent Calendar
Today's Question:

Scientists are tracking polar bears across the Arctic to monitor their migration patterns and caloric intake. Write a query to find the top 3 polar bears that have traveled the longest total distance in December 2024. Include their bear_id, bear_name, and total_distance_traveled in the results.

Table name: polar_bears

bear_id	bear_name	age
1	Snowball	10
2	Frosty	7
3	Iceberg	15
4	Chilly	5
Table name: tracking

tracking_id	bear_id	distance_km	date
1	1	25	2024-12-01
2	2	40	2024-12-02
3	1	30	2024-12-03
4	3	50	2024-12-04
5	2	35	2024-12-05
6	4	20	2024-12-06
7	3	55	2024-12-07
8	1	45	2024-12-08
*/

SELECT
    pb.bear_id
    , pb.bear_name
    , SUM(t.distance_km) AS total_distance_traveled
FROM 
    polar_bears pb
JOIN
    tracking t
ON 
    pb.bear_id = t.bear_id
WHERE 
    t.date BETWEEN '2024-12-01' AND '2024-12-31'
GROUP BY 
    pb.bear_id
    , pb.bear_name
ORDER BY 
    total_distance_traveled DESC
LIMIT 3
;

/*
Day 7 of SQL Advent Calendar
Today's Question:

The owner of a winter market wants to know which vendors have generated the highest revenue overall. For each vendor, calculate the total revenue for all their items and return a list of the top 2 vendors by total revenue. Include the vendor_name and total_revenue in your results.

Table name: vendors

vendor_id	vendor_name	market_location
1	Cozy Crafts	Downtown Square
2	Sweet Treats	Central Park
3	Winter Warmers	Downtown Square
Table name: sales

sale_id	vendor_id	item_name	quantity_sold	price_per_unit
1	1	Knitted Scarf	15	25
2	2	Hot Chocolate	50	3.5
3	3	Wool Hat	20	18
4	1	Handmade Ornament	10	15
5	2	Gingerbread Cookie	30	5
*/
SELECT 
    v.vendor_name
    , SUM(s.quantity_sold * s.price_per_unit) AS total_revenue
FROM 
    vendors v 
JOIN 
    sales s 
ON v.vendor_id = s.vendor_id
GROUP BY
    v.vendor_name
ORDER BY
    total_revenue DESC
LIMIT 2
;
