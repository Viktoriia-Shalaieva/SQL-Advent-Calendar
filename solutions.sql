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
