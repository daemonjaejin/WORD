SELECT B.stand_dt, 
       B.time_cd, 
       COALESCE(A.use_amt_fa, 0)   AS USE_AMT_FA, 
       Substr(B.start_tm, 1, 2) 
       || ':' 
       || Substr(B.start_tm, 3, 4) AS START_TM, 
       Substr(B.end_tm, 1, 2) 
       || ':' 
       || Substr(B.end_tm, 3, 4)   AS END_TM 
FROM   (SELECT B.time_cd, 
               B.view_odr, 
               A.mtr_date                AS STAND_DT, 
               B.start_tm, 
               B.end_tm, 
               Sum(A.lghtn_cctp_cns_qnt) AS USE_AMT_FA 
        FROM   t_obdng_by_purp_bytm_sum A, 
               t_time_cd B, 
               t_obdng_info_bas C 
        WHERE  A.mtr_date BETWEEN '20131028' AND '20131028' 
               AND A.obdng_id = C.obdng_id 
               AND C.rgn_cd = '01020000' 
               AND A.time_cd = B.time_cd 
               AND C.obdng_id = 'A01-B0000000896'
        GROUP  BY A.mtr_date, 
                  B.time_cd, 
                  B.view_odr, 
                  B.start_tm, 
                  B.end_tm 
        ORDER  BY A.mtr_date, 
                  B.view_odr) A 
       RIGHT OUTER JOIN (SELECT i, 
                                To_char( '20131028':: date - i, 'yyyymmdd') AS STAND_DT, 
                                start_tm, 
                                end_tm, 
                                time_cd 
                         FROM   Generate_series(0, (SELECT '20131028':: date - '20131028':: date)) 
                                AS t(i 
                                ) 
                                INNER JOIN t_time_cd 
                                        ON cd_type = 'H01' 
                         ORDER  BY stand_dt, 
                                   start_tm) B 
                     ON B.stand_dt = A.stand_dt 
                        AND B.start_tm = A.start_tm 
ORDER  BY B.stand_dt, 
          B.start_tm 