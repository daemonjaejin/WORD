SELECT ISMART_ID, SUM(COLEC_CNT)
FROM T_OBDNG_ISMART_BYTM_SUM
WHERE MTR_DATE = '20131112'
GROUP BY ISMART_ID, MTR_DATE, TIME_CD


select date_trunc('month', current_date)::date + (i - 1)
from
  generate_series(
    1,
    extract(day from date_trunc('month', current_date + interval '1 months')::date - 1)::integer
  ) as t(i);
 
select date_trunc('month', current_date)::date + (i - 1)
from
  generate_series(
    1,
    extract(day from date_trunc('month', current_date) + interval '1 months' - interval '1 days')::integer
  ) as t(i);


select date_trunc('month', current_date)::date + (i - 1)
from
  generate_series(
    1,
    extract(day from date_trunc('month', current_date + interval '1 months')::date - 1)::integer
  ) as t(i);


  SELECT 5*extract(day from date_trunc('month', '20131001'::date + interval '1 months')::date - 1)::integer

to_char((#{stand_dt_e}::date  - ( i::text || ' months')::interval),'yyyymm') as STAND_DT


					SELECT to_char(('20131113'::date  - ( i::text || ' months')::interval),'yyyymm') as STAND_DT
					FROM generate_series( 0, 
								  (((to_char('20131113'::date, 'YYYY'))::int - (to_char('20131013'::date, 'YYYY'))::int)*12 
								  + ((to_char('20131113'::date, 'MM'))::int - (to_char('20131013'::date, ' MM'))::int))
								) as t(i)
					ORDER BY STAND_DT










				SELECT A.MTR_DATE AS STAND_DT
			 		, A.TIME_CD
			 		, SUM(A.ISMART_CNS_QNT*1000) AS ISMART_CNS_QNT
			 		, ROUND((CAST(SUM(A.COLEC_CNT) AS NUMERIC)/(4*COUNT(A.ISMART_ID)))*100, 1) AS COLEC_RATE
				 	FROM T_OBDNG_ISMART_BYTM_SUM A, T_OBDNG_INFO_BAS B
				 	WHERE A.ISMART_ID = B.ISMART_ID
					AND B.RGN_CD = '01020000'
			 	  AND A.MTR_DATE BETWEEN '20131112' AND '20131112'
			 	GROUP BY A.MTR_DATE, A.TIME_CD

select *
from t_obdng_ismart_Mby_sum
WHERE ISMART_ID = '1116006597'

select *
from t_obdng_ismart_Dby_sum
WHERE ISMART_ID = '0322136568'

select to_char(CURRENT, 'MM')::int 

select TIMESTAMP

where mtr_ym = '201311'

select view_odr
from t_time_cd
where cd_type = 'M15'
and '1437' between start_tm and end_tm

select '2010-07-01'::date - '2010-07-01'::date;

select to_char(current_timestamp, 'YYYYMMDD')

select
  date_trunc('month', to_char(current_timestamp, 'YYYYMMDD')::date)::date
;

select to_char(current_timestamp, 'YYYYMMDD')::date+1 - date_trunc('month', to_char(current_timestamp, 'YYYYMMDD')::date)::date




SELECT D.METER_SN, D.GW_ID, D.LOAD_TYPE_NM, (SELECT NAME_KO FROM T_COMM_CD WHERE COMM_CD = 'LOAD_TYPE_CD' AND COMM_SUB_CD = D.LOAD_TYPE_CD) AS LOAD_TYPE_KO, B.OBDNG_NM AS BUILDING_NM, COALESCE(D.FLOOR_CD, '-') AS FLOOR_CD, A.REGION_NM, B.OBDNG_ID
		, CASE WHEN (E.REG_DATE  < TO_CHAR(CURRENT_TIMESTAMP -interval '30 minute', 'YYYY-MM-DD HH24:MI:SS')::timestamp OR E.STATUS = '1') THEN '비정상' ELSE '정상' END AS INSTALL_STATUS
		, TO_CHAR(E.REG_DATE, 'YYYY-MM-DD HH24:MI:SS')::timestamp AS UPD_DT_IDX
		, ROW_NUMBER () OVER (ORDER BY D.METER_SN ASC) AS ROWNUM
		, (SELECT NAME_KO FROM T_COMM_CD WHERE COMM_CD = 'METER_TYPE' AND COMM_SUB_CD = D.METER_TYPE) AS METER_TYPE
		FROM T_REGION_CD A, T_OBDNG_INFO_BAS B, T_GATEWAY C, T_METER D, T_MR_METER_STATUS E
		WHERE A.REGION_SUB_CD = B.RGN_CD
		AND B.OBDNG_ID = C.SITE_ID
		AND C.GW_ID = D.GW_ID
		AND D.METER_SN = E.METER_SN

select *
from T_METER
limit 1

SELECT * FROM T_COMM_CD

SELECT NAME_KO FROM T_COMM_CD WHERE COMM_CD = 'LOAD_TYPE_CD' AND COMM_SUB_CD = D.LOAD_TYPE_CD
		
			 	