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

Desc                           Start Date     Duration  Num Dest Desc                 Price
------------------------------ ------------ ---------- ---- ------------------------- ----------
Calgary Highlights             08-Aug-2022  4 Days        1 Calgary City Sightseeing    $214.36
                                                            Tour
                                                          2 Sulfur Mountain Gondola a   $121.00
                                                            nd Banff Hot Springs
                                                          3 Heritage Park - the 1883     $79.99
                                                            experience                                                        
Calgary Stampede               08-Jul-2022  9 Days        1 Calgary Stampede - Day pa   $131.00
                                                            ss Rodeo
                                                          2 Calgary Stampede - Chuckw   $251.00
                                                            agon Races and Grandstand
                                                             Show
                                                          3 Calgary City Sightseeing    $214.36
                                                            Tour
European Vacation              10-Jul-2022  14 Days       1 Skip the Line Ticket: Eif   $102.99
                                                            fel Tower Summit Priority
                                                             Access with Host
                                                          2 Normandy D-Day Beaches &    $439.43
                                                            American Cemetery Trip fr
                                                            om Paris
                                                          3 French Riviera in One Day    $89.26
                                                          4 360 degree Barcelona SkyW   $597.76
                                                            alk: Old Town Walking, He
                                                            licopter flight & Sailing
                                                            Small Group
                                                          5 Familia Sagrada Guided To    $70.03
                                                            ur
France in 4 Days               23-Aug-2022  3 Days        1 Normandy D-Day Beaches &    $439.43
                                                            American Cemetery Trip fr
                                                            om Paris
                                                          2 Skip the Line Ticket: Eif   $102.99
                                                            fel Tower Summit Priority
                                                             Access with Host
                                                          3 Nice Small-Group Walking     $96.13
                                                            Food Tour with Local Spec
                                                            ialties & Wine Tasting
                                                          4 Nice Local Vineyards Smal   $109.86
                                                            l Group Half Day E-Bike T
                                                            our with Wine Tasting
Sights of Barcelona            28-Aug-2022  7 Days        1 Barcelona in One Day: Sag   $196.96
                                                            rada Familia, Park Guell
                                                            & Old Town with Hotel Pic
                                                            k-up
                                                          2 360 degree Barcelona SkyW   $597.76
                                                            alk: Old Town Walking, He
                                                            licopter flight & Sailing
                                                             Small Group
                                                          3 Sunset Jazz Cruise in Bar    $49.95
                                                            celona
                                                          4 Interactive Spanish Cooki    $72.76
                                                            ng Experience in Barcelon
                                                            a

19 rows selected.
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

Country         City            Tour Description                         Tour Cost
--------------- --------------- ---------------------------------------- ----------
FRANCE          NICE            Nice Small-Group Walking Food Tour with  $$
                                Local Specialties & Wine Tasting
FRANCE          NICE            French Riviera in One Day                $$
FRANCE          NICE            French Riviera Famous Cities Scoot Coupe $$
                                 Self Drive Tour from Nice
FRANCE          NICE            Nice Local Vineyards Small Group Half Da $$$
                                y E-Bike Tour with Wine Tasting
FRANCE          PARIS           Bateaux Parisiens Seine River Cruise     $$
FRANCE          PARIS           Disneyland Paris 1-Day Ticket            $$
FRANCE          PARIS           Bateaux Parisiens Seine River Gourmet Di $$$
                                nner & Sightseeing Cruise
FRANCE          PARIS           Skip the Line Ticket: Eiffel Tower Summi $$$
                                t Priority Access with Host
FRANCE          PARIS           Gourmet Dinner & Sightseeing Cruise      $$$
FRANCE          PARIS           Normandy D-Day Beaches & American Cemete $$$$
                                ry Trip from Paris
SPAIN           BARCELONA       Sunset Jazz Cruise in Barcelona          $
SPAIN           BARCELONA       Familia Sagrada Guided Tour              $$
SPAIN           BARCELONA       Interactive Spanish Cooking Experience i $$
                                n Barcelona
SPAIN           BARCELONA       Barcelona in One Day: Sagrada Familia, P $$$
                                ark Guell & Old Town with Hotel Pick-up
SPAIN           BARCELONA       Girona and Dali Museum Small Group Tour  $$$
                                with Hotel Pick-up from Barcelona
SPAIN           BARCELONA       360 degree Barcelona SkyWalk: Old Town W $$$$$
                                alking, Helicopter flight & Sailing Smal
                                l Group

16 rows selected.
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

 Destination Description        City                 Country         State      Price
 ------------------------------ -------------------- --------------- ---------- --------
 Bateaux Parisiens Seine River  Paris                FRANCE          NA          $162.73
 Gourmet Dinner & Sightseeing C
 ruise
 Gourmet Dinner & Sightseeing C Paris                FRANCE          NA          $114.99
 ruise
 Nice Local Vineyards Small Gro Nice                 FRANCE          NA          $109.86
 up Half Day E-Bike Tour with W
 ine Tasting
 Nice Small-Group Walking Food  Nice                 FRANCE          NA           $96.13
 Tour with Local Specialties &
 Wine Tasting
 Interactive Spanish Cooking Ex Barcelona            SPAIN           NA           $72.76
 perience in Barcelona
 Private French-Inspired Cookin Palm Springs         USA             CA          $139.24
 g Class with a Fun Local in Pa
 lm Springs, CA


6 rows selected.

SQL>
SQL> clear columns;
columns cleared
SQL> Spool off