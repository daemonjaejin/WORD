﻿SELECT A.MTR_DATE AS STAND_DT
					, A.TIME_CD
					, ROUND((CAST(SUM(A.RCV_NUM) AS NUMERIC)/CAST(SUM(A.BASE_COLEC_NUM) AS NUMERIC))*100, 1) AS MR_RATE
					, SUM(A.LGHTN_CCTP_CNS_QNT) AS DEMAND
					FROM T_OBDNG_FLR_BYTM_SUM A
					, T_OBDNG_FLR_INFO_BAS B
				WHERE A.OBDNG_ID = B.OBDNG_ID
					AND A.OBDNG_ID = 'A01-B0000000896'
					AND A.FLR_ID = '1'
				AND A.MTR_DATE BETWEEN '20131105' AND '20131105'
				GROUP BY A.MTR_DATE, A.TIME_CD

				SELECT *
				FROM T_OBDNG_ISMART_DBY_SUM
				LIMIT 1

				select *
				from T_VEE_MASTER
				limit 1