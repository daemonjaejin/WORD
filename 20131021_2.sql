﻿SELECT *
FROM T_MR_METER
WHERE STAND_DT = '20131019';

		SELECT  B.METER_SN
		      , B.STAND_DT
		      , coalesce(A.USE_AMT_FA,0) AS USE_AMT_FA
		FROM (
			 SELECT A.METER_SN
			 	  , A.STAND_DT
			 	  , A.TIME_CD
			      , SUM(USE_AMT_FA) AS USE_AMT_FA
			   FROM T_MR_METER A
			  WHERE 1=1
			    AND A.METER_SN IN ('000000000045')
			    AND A.STAND_DT BETWEEN '20131018' AND '20131018'
			  GROUP BY A.METER_SN, A.STAND_DT, A.TIME_CD
			  ORDER BY A.METER_SN, A.STAND_DT
		) A 
		RIGHT OUTER JOIN
		(
			SELECT METER_SN,to_char('20131018'::date - i,'yyyymmdd') as STAND_DT, A.TIME_CD
			FROM generate_series(0,(select '20131018'::date - '20131018'::date)) as t(i)
			,(
				SELECT A.METER_SN, B.TIME_CD
				FROM T_MR_METER A, T_TIME_CD B
				WHERE METER_SN IN ('000000000045') 
				  AND A.TIME_CD = B.TIME_CD
				  AND B.CD_TYPE = 'H01'
				GROUP BY A.METER_SN, B.TIME_CD
			) A 
			ORDER BY METER_SN, STAND_DT
		 ) B
		ON B.METER_SN = A.METER_SN
		AND B.STAND_DT = A.STAND_DT
		AND A.TIME_CD = B.TIME_CD
		ORDER BY B.METER_SN, B.STAND_DT


		SELECT *
		FROM T_MR_METER
		LIMIT 1