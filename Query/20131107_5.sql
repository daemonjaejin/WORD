SELECT *
FROM
  (SELECT D.METER_SN,
          D.GW_ID,
          D.LOAD_TYPE_NM,
          B.OBDNG_NM AS BUILDING_NM,
          COALESCE(D.FLOOR_CD, '-') AS FLOOR_CD,
          A.REGION_NM,
          B.OBDNG_ID ,
          CASE
              WHEN (E.REG_DATE < TO_CHAR(CURRENT_TIMESTAMP -interval '30 minute', 'YYYY-MM-DD HH24:MI:SS')::TIMESTAMP
                    OR E.STATUS = '1') THEN '비정상'
              ELSE '정상'
          END AS INSTALL_STATUS ,
          TO_CHAR(E.REG_DATE, 'YYYY-MM-DD HH24:MI:SS')::TIMESTAMP AS UPD_DT_IDX ,
          ROW_NUMBER () OVER (
                              ORDER BY D.METER_SN ASC) AS ROWNUM ,

     (SELECT NAME_KO
      FROM T_COMM_CD
      WHERE COMM_CD = 'METER_TYPE'
        AND COMM_SUB_CD = D.METER_TYPE) AS METER_TYPE
   FROM T_REGION_CD A,
        T_OBDNG_INFO_BAS B,
        T_GATEWAY C,
        T_METER D,
        T_MR_METER_STATUS E
   WHERE A.REGION_SUB_CD = B.RGN_CD
     AND B.OBDNG_ID = C.SITE_ID
     AND C.GW_ID = D.GW_ID
     AND D.METER_SN = E.METER_SN
     AND A.REGION_SUB_CD = ?
     AND A.METER_SN IN
       (SELECT METER_SN
        FROM T_MR_METER
        WHERE SURGE <> '0'
          AND SURGE IS NOT NULL
          OR VOLT_DROP <> '0'
          AND VOLT_DROP IS NOT NULL
          OR ECURR_OVER <> '0'
          AND ECURR_OVER IS NOT NULL
          OR FRQN_OVER <> '0'
          AND FRQN_OVER IS NOT NULL
          AND STAND_DT = ?)
   ORDER BY D.METER_SN) A
WHERE A.ROWNUM BETWEEN 1 AND 10

select *
from T_VEE_DETAIL
limit 1