SELECT B.meter_sn, 
       B.stand_dt, 
       COALESCE(A.use_amt_fa, 0) AS USE_AMT_FA 
FROM   (SELECT A.meter_sn, 
               A.stand_dt, 
               A.time_cd, 
               Sum(use_amt_fa) AS USE_AMT_FA 
        FROM   t_mr_meter_bytm_sum A 
        WHERE  1 = 1 
               AND A.time_cd = 'H01' 
               AND A.meter_sn IN ( '000000000039' ) 
               AND A.stand_dt BETWEEN '20131028' AND '20131028' 
        GROUP  BY A.meter_sn, 
                  A.stand_dt, 
                  A.time_cd 
        ORDER  BY A.meter_sn, 
                  A.stand_dt) A 
       RIGHT OUTER JOIN (SELECT meter_sn, 
                                To_char( '20131028':: date - i, 'yyyymmdd') AS STAND_DT, 
                                A.time_cd 
                         FROM   Generate_series(0, (SELECT '20131028':: date - '20131028':: date)) 
                                AS t(i 
                                ), 
                                (SELECT A.meter_sn, 
                                        B.time_cd 
                                 FROM   t_mr_meter_bytm_sum A, 
                                        t_time_cd B 
                                 WHERE  meter_sn IN ( '000000000039' ) 
                                        AND A.time_cd = B.time_cd 
                                        AND B.cd_type = 'H01' 
                                 GROUP  BY A.meter_sn, 
                                           B.time_cd) A 
                         ORDER  BY meter_sn, 
                                   stand_dt) B 
                     ON B.meter_sn = A.meter_sn 
                        AND B.stand_dt = A.stand_dt 
                        AND A.time_cd = B.time_cd 
ORDER  BY B.meter_sn, 
          B.stand_dt 