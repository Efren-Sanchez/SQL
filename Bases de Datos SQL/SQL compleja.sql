WITH tmp_1 AS
(
    SELECT Calc1 =
    (
        (SELECT TOP 1 DataValue
         FROM (
                SELECT TOP 50 PERCENT DataValue
                FROM SOMEDATA
                WHERE DataValue IS NOT NULL
                ORDER BY DataValue
              ) AS A
         ORDER BY DataValue DESC
        )
        +
        (SELECT TOP 1 DataValue
         FROM (
                SELECT TOP 50 PERCENT DataValue
                FROM SOMEDATA
                WHERE DataValue IS NOT NULL
                ORDER BY DataValue DESC
              ) AS A
         ORDER BY DataValue ASC
        )
    ) / 2
),
tmp_2 AS
(
    SELECT AVG(DataValue) AS Mean,
           MAX(DataValue) - MIN(DataValue) AS MaxMinRange
    FROM SOMEDATA
),
tmp_3 AS
(
    SELECT TOP 1 DataValue AS Calc2,
           COUNT(*) AS Calc2Count
    FROM SOMEDATA
    GROUP BY DataValue
    ORDER BY Calc2Count DESC
)
SELECT Mean, Calc1, Calc2, MaxMinRange AS [Range]
FROM tmp_1
CROSS JOIN tmp_2
CROSS JOIN tmp_3;