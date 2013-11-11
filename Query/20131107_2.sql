﻿SELECT D.METER_SN, D.GW_ID, D.LOAD_TYPE_NM, B.OBDNG_NM AS BUILDING_NM, COALESCE(D.FLOOR_CD, '-') AS FLOOR_CD, D.METER_TYPE, A.REGION_NM, B.OBDNG_ID
		, CASE WHEN (E.REG_DATE  < TO_CHAR(CURRENT_TIMESTAMP -interval '30 minute', 'YYYY-MM-DD HH24:MI:SS')::timestamp OR E.STATUS = '1') THEN '비정상' ELSE '정상' END AS INSTALL_STATUS
		, TO_CHAR(E.REG_DATE, 'YYYY-MM-DD HH24:MI:SS')::timestamp AS UPD_DT_IDX
		, ROW_NUMBER () OVER (ORDER BY D.METER_SN ASC) AS ROWNUM
		FROM T_REGION_CD A, T_OBDNG_INFO_BAS B, T_GATEWAY C, T_METER D, T_MR_METER_STATUS E
		WHERE A.REGION_SUB_CD = B.RGN_CD
		AND B.OBDNG_ID = C.SITE_ID
		AND C.GW_ID = D.GW_ID
		AND D.METER_SN = E.METER_SN


		SELECT *
		FROM T_GATEWAY
		LIMIT 1