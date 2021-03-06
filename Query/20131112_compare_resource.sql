﻿		SELECT  B.STAND_DT
				, B.TIME_CD
		 		, COALESCE(A.USE_AMT_FA,0) AS USE_AMT_FA
		 		, A.METER_SN
		FROM (
			 SELECT METER_SN
					, STAND_DT
					, TIME_CD
					, SUM(USE_AMT_FA) AS USE_AMT_FA
			FROM T_MR_METER_BYTM_SUM
			WHERE METER_SN IN ('000000000055')
			  AND STAND_DT BETWEEN '20131110' AND '20131110'
			GROUP BY METER_SN, STAND_DT, TIME_CD
		) A RIGHT OUTER JOIN (
			SELECT to_char('20131110'::date - i,'yyyymmdd') as STAND_DT, TIME_CD
			FROM generate_series(0,(select '20131110'::date - '20131110'::date)) as t(i)
			INNER JOIN T_TIME_CD
			ON CD_TYPE= 'H01'
		 ) B
		ON A.STAND_DT = B.STAND_DT
		AND A.TIME_CD = B.TIME_CD
		ORDER BY STAND_DT , TIME_CD



				SELECT  B.STAND_DT
				, B.TIME_CD
		 		, COALESCE(A.USE_AMT_FA,0) AS USE_AMT_FA
		 		, A.METER_SN
		FROM (
			 SELECT METER_SN
					, STAND_DT
					, TIME_CD
					, SUM(USE_AMT_FA) AS USE_AMT_FA
			FROM T_MR_METER_BYTM_SUM A
			WHERE METER_SN IN ('000000000055')
			  AND STAND_DT BETWEEN '20131109' AND '20131110'
			GROUP BY METER_SN, STAND_DT, TIME_CD
			ORDER BY METER_SN, STAND_DT, TIME_CD
		) A RIGHT OUTER JOIN (
			SELECT to_char('20131110'::date - i,'yyyymmdd') as STAND_DT, TIME_CD
			FROM generate_series(0,(select '20131110'::date - '20131109'::date)) as t(i)
			INNER JOIN T_TIME_CD
			ON CD_TYPE= 'H01'
		 ) B
		ON A.STAND_DT = B.STAND_DT
		AND A.TIME_CD = B.TIME_CD
		ORDER BY STAND_DT , TIME_CD