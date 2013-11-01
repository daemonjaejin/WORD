SELECT B.STAND_DT ,
       B.TIME_CD ,
       COALESCE(A.USE_AMT_FA,0) AS USE_AMT_FA ,
       SUBSTR(B.START_TM, 1, 2) || ':' || SUBSTR(B.START_TM, 3, 4) AS START_TM ,
       SUBSTR(B.END_TM, 1, 2) || ':' || SUBSTR(B.END_TM, 3, 4) AS END_TM
FROM
  (SELECT B.TIME_CD,
          B.VIEW_ODR,
          A.MTR_DATE AS STAND_DT,
          B.START_TM,
          B.END_TM ,
          SUM(A.LGHTN_CCTP_CNS_QNT) AS USE_AMT_FA
   FROM T_OBDNG_FLR_BYTM_SUM A ,
        T_TIME_CD B ,
        T_OBDNG_INFO_BAS C ,
        T_OBDNG_FLR_INFO_BAS D
   WHERE A.MTR_DATE BETWEEN '20131022' AND '20131022'
     AND A.OBDNG_ID = C.OBDNG_ID
     AND C.RGN_CD = '01020000'
     AND A.TIME_CD = B.TIME_CD
     AND C.OBDNG_ID = D.OBDNG_ID
   GROUP BY A.MTR_DATE,
            B.TIME_CD,
            B.VIEW_ODR,
            B.START_TM,
            B.END_TM
   ORDER BY A.MTR_DATE,
            B.VIEW_ODR) A
RIGHT OUTER JOIN
  (SELECT i,
          to_char('20131022'::date - i,'yyyymmdd') AS STAND_DT,
          START_TM,
          END_TM,
          TIME_CD
   FROM generate_series(0,
                          (SELECT '20131022'::date - '20131022'::date)) AS t(i)
   INNER JOIN T_TIME_CD ON CD_TYPE='H01'
   ORDER BY STAND_DT,
            START_TM) B ON B.STAND_DT = A.STAND_DT
AND B.START_TM = A.START_TM
ORDER BY B.STAND_DT,
         B.START_TM


         SELECT *
         FROM T_TIME_CD
         WHERE CD_TYPE = 'M15'

         SELECT *
         FROM 