SELECT B.stand_dt,
       COALESCE(A.power_factr_blow_cnt, 0) AS POWER_FACTR_BLOW_CNT,
       COALESCE(A.frqn_excs_cnt, 0) AS FRQN_EXCS_CNT,
       COALESCE(A.power_factr_avg, 0) AS POWER_FACTR_AVG,
       COALESCE(A.frqn_avg, 0) AS FRQN_AVG,
       B.start_tm,
       B.end_tm,
       B.time_cd
FROM
  (SELECT B.mtr_date AS STAND_DT,
          B.time_cd,
          Sum(B.power_factr_blow_cnt) AS POWER_FACTR_BLOW_CNT,
          Sum(B.frqn_excs_cnt) AS FRQN_EXCS_CNT,
          Trunc(Cast(Sum(B.power_factr_avg) AS NUMERIC), 2) AS POWER_FACTR_AVG,
          Sum(B.frqn_avg) AS FRQN_AVG
   FROM t_obdng_info_bas A,
        t_obdng_by_purp_mn15_sum B,
        t_region_cd C
   WHERE A.obdng_id = B.obdng_id
     AND A.rgn_cd = C.region_sub_cd
     AND C.region_cd = '01000000'
     AND B.mtr_date BETWEEN '20131111' AND '20131111'
   GROUP BY B.mtr_date,
            B.time_cd) A
RIGHT JOIN
  (SELECT i,
          To_char('20131111':: date - i, 'yyyymmdd') AS STAND_DT,
          start_tm,
          end_tm,
          time_cd
   FROM Generate_series(0,
                          (SELECT '20131111':: date - '20131111':: date)) AS t(i)
   INNER JOIN t_time_cd ON cd_type = 'M15'
   ORDER BY stand_dt,
            start_tm) B ON A.stand_dt = B.stand_dt
AND A.time_cd = B.time_cd
ORDER BY B.stand_dt








SELECT B.mtr_date AS STAND_DT,
          B.time_cd,
          Sum(B.power_factr_blow_cnt) AS POWER_FACTR_BLOW_CNT,
          Sum(B.frqn_excs_cnt) AS FRQN_EXCS_CNT,
          Trunc(Cast(AVG(B.power_factr_avg) AS NUMERIC), 2) AS POWER_FACTR_AVG,
          AVG(B.frqn_avg) AS FRQN_AVG
   FROM t_obdng_info_bas A,
        t_obdng_by_purp_mn15_sum B,
        t_region_cd C
   WHERE A.obdng_id = B.obdng_id
     AND A.rgn_cd = C.region_sub_cd
     AND C.region_cd = '01000000'
     AND B.mtr_date BETWEEN '20131111' AND '20131111'
   GROUP BY B.mtr_date,
            B.time_cd


select region_sub_cd
from t_region_cd      
where region_cd = '01000000'      

select *
from t_obdng_info_bas