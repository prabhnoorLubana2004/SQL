SQL>
SQL> set linesize 100
SQL>
SQL> column "Desc" format A30
SQL> column "Start Date" format A12
SQL> column "Duration" format A10
SQL> column "Num" format 999
SQL> column "Dest Desc" format A25
SQL> column "Price" format A10
SQL>
SQL> WITH Vacations AS (
  2      SELECT
  3          tc.tour_code,
  4          vt.tour_description AS "Desc",
  5          TO_CHAR(tc.start_date, 'DD-Mon-YYYY') AS "Start Date",
  6          (tc.end_date - tc.start_date) + 1 AS "Duration",
  7          ROW_NUMBER() OVER (PARTITION BY tc.tour_code ORDER BY tc.start_date) AS "Num",
  8          d.dest_description AS "Dest Desc",
  9          TO_CHAR(d.price, '$9999.99') AS "Price"
 10      FROM
 11          rcv_tour_customer tc
 12      JOIN
 13          rcv_customer c ON tc.customer_number = c.customer_number
 14      JOIN
 15          rcv_vacation_tour vt ON tc.tour_code = vt.tour_code
 16      JOIN
 17          rcv_tour_destination td ON tc.tour_code = td.tour_code
 18      JOIN
 19          rcv_destination d ON td.dest_code = d.dest_code
 20      WHERE
 21          c.first_name = 'Amy' AND c.last_name = 'Folwer'
 22  )
 23  SELECT
 24      "Desc",
 25      "Start Date",
 26      "Duration",
 27      "Num",
 28      "Dest Desc",
 29      "Price"
 30  FROM
 31      Vacations
 32  ORDER BY
 33      "Start Date", "Num";






SQL>
SQL> set linesize 100
SQL>
SQL> column "Country" format A15
SQL> column "City" format A15
SQL> column "Tour Description" format A40
SQL> column "Tour Cost" format A10
SQL>
SQL> select
  2      CASE
  3          WHEN UPPER(d.country) = 'CANADA' THEN 'CA'
  4          WHEN UPPER(d.country) = 'UNITED STATES' THEN 'USA'
  5          ELSE UPPER(d.country)
  6      END as "Country",
  7      UPPER(d.city) as "City",
  8      d.dest_description as "Tour Description",
  9      CASE
 10          WHEN d.price < 50 THEN '$'
 11          WHEN d.price >= 50 AND d.price < 100 THEN '$$'
 12          WHEN d.price >= 100 AND d.price < 200 THEN '$$$'
 13          WHEN d.price >= 200 AND d.price < 500 THEN '$$$$'
 14          ELSE '$$$$$'
 15      END as "Tour Cost"
 16  from
 17      rcv_destination d
 18  where
 19      UPPER(d.country) NOT IN ('CANADA', 'UNITED STATES')
 20  order by
 21      "Country", "City", "Tour Cost";




SQL> 
SQL> clear columns;
columns cleared
SQL> 
SQL>
SQL> column "Destination Description" format A30
SQL> column "City" format A20
SQL> column "Country" format A15
SQL> column "State" format A10
SQL> column "Price" format $999.99
SQL>
SQL> SELECT
  2     
  3      dest_description AS "Destination Description",
  4      city AS "City",
  5      CASE
  6          WHEN UPPER(country) = 'UNITED STATES' THEN 'USA'
  7          ELSE UPPER(country)
  8      END AS "Country",
  9      NVL(state, 'NA') AS "State",
 10      TO_CHAR(price, '$999.99') AS "Price"
 11  FROM
 12      rcv_destination
 13  WHERE
 14      INSTR(dest_description, 'Cook') > 0
 15      OR INSTR(dest_description, 'Wine') > 0
 16      OR INSTR(dest_description, 'Dinner') > 0
 17  ORDER BY
 18      "Destination Description", "Country", "State";

