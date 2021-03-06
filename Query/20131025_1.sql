﻿SELECT A.METER_SN ,
       A.STAND_DT ,
       coalesce(A.USE_AMT_FA,0) AS USE_AMT_FA
FROM
  (SELECT A.METER_SN ,
          A.STAND_DT ,
          A.TIME_CD ,
          SUM(USE_AMT_FA) AS USE_AMT_FA
   FROM T_MR_METER_BYTM_SUM A
   WHERE 1=1
     AND A.METER_SN IN ('000000000040')
     AND A.STAND_DT BETWEEN '20131025' AND '20131025'
   GROUP BY A.METER_SN,
            A.STAND_DT,
            A.TIME_CD
   ORDER BY A.METER_SN,
            A.STAND_DT) A
RIGHT JOIN
  (SELECT i,
          to_char('20131025'::date - i,'yyyymmdd') AS STAND_DT,
          TIME_CD
   FROM generate_series(0,
                          (SELECT '20131025'::date - '20131025'::date)) AS t(i)
   INNER JOIN T_TIME_CD ON CD_TYPE='M15'
   ORDER BY STAND_DT) B ON A.STAND_DT = B.STAND_DT
AND A.TIME_CD = B.TIME_CD
ORDER BY B.STAND_DT

SELECT POWER_FACTR_BLOW_CNT
FROM T_OBDNG_BY_PURP_MN15_SUM

SELECT FRQN_OVER
FROM T_MR_METER
LIMIT 1

SELECT PF_BLOW, FRQN_OVER, FREQUENCY, POWER_FACTOR_VAR
FROM T_MR_METER
LIMIT 1