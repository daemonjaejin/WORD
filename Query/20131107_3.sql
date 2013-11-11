SELECT A.STAND_DT
			, A.TIME_CD
			, SUBSTR(A.START_TM, 1, 2) || ':' || SUBSTR(A.START_TM, 3, 4) AS START_TM
			, SUBSTR(A.END_TM, 1, 2) || ':' || SUBSTR(A.END_TM, 3, 4) AS END_TM
			, A.MR_RATE
			, A.DEMAND
			, B.CBL
			, C.ISMART_CNS_QNT AS ISMART
		FROM (
			SELECT B.STAND_DT
				, B.TIME_CD
				, B.START_TM
				, B.END_TM
				, COALESCE(A.MR_RATE, 0) AS MR_RATE
				, COALESCE(A.DEMAND, 0) AS DEMAND
			FROM (
				SELECT A.MTR_DATE AS STAND_DT
					, A.TIME_CD
					, ROUND((CAST(SUM(A.RCV_NUM) AS NUMERIC)/CAST(SUM(A.BASE_COLEC_NUM) AS NUMERIC))*100, 1) AS MR_RATE
					, SUM(A.LGHTN_CCTP_CNS_QNT) AS DEMAND
					FROM T_OBDNG_BY_PURP_BYTM_SUM A
					, T_OBDNG_INFO_BAS B
					FROM T_OBDNG_FLR_BYTM_SUM A
					, T_OBDNG_FLR_INFO_BAS B
					, T_REGION_CD C
				WHERE A.OBDNG_ID = B.OBDNG_ID
					AND A.OBDNG_ID = #{obdng_id}
					AND A.FLR_ID = #{regCd}
				AND A.MTR_DATE BETWEEN #{stand_dt_s} AND #{stand_dt_e}
				GROUP BY A.MTR_DATE, A.TIME_CD
				) A RIGHT JOIN (
					SELECT  i, to_char(#{stand_dt_e}::date - i,'yyyymmdd') as STAND_DT, START_TM, END_TM, TIME_CD
					FROM generate_series(0,(select #{stand_dt_e}::date - #{stand_dt_s}::date)) as t(i) 
					INNER JOIN T_TIME_CD 
					ON CD_TYPE=#{cd_type}
					ORDER BY STAND_DT, START_TM
				) B
			ON A.STAND_DT = B.STAND_DT
			AND A.TIME_CD = B.TIME_CD
			ORDER BY A.STAND_DT
		 ) A, (
			SELECT B.STAND_DT
				, B.TIME_CD
				, B.START_TM
				, B.END_TM
				, COALESCE(A.CBL, 0) AS CBL
			FROM (
				SELECT A.STAND_DT
					, C.REF2 AS TIME_CD 
					, SUM(A.CBL) AS CBL
				<if test="regLvl !='4'.toString()">
					FROM T_GROUP_CBL A, T_OBDNG_INFO_BAS B, T_TIME_CD C
				</if>					
				<if test="regLvl =='4'.toString()">
					FROM T_GROUP_CBL_DTL A, T_OBDNG_FLR_INFO_BAS B, T_TIME_CD C
				</if>					
				<if test="regLvl =='1'.toString()">
					, T_REGION_CD D
				</if>
				WHERE A.GROUP_CD = B.OBDNG_ID
				<if test="regLvl =='1'.toString()">
					AND B.RGN_CD = D.REGION_SUB_CD
				</if>
				  AND A.TIME_CD = C.TIME_CD
				  AND C.CD_TYPE = 'M15'
				  AND A.STAND_DT BETWEEN #{stand_dt_s} AND #{stand_dt_e}
				<if test="regLvl =='1'.toString()">
					AND D.REGION_CD = #{regCd}
				</if>
				<if test="regLvl =='2'.toString()">
					AND B.RGN_CD = #{regCd}
				</if>
				<if test="regLvl =='3'.toString()">
					AND B.OBDNG_ID = #{regCd}
				</if>
				<if test="regLvl =='4'.toString()">
					AND A.GROUP_CD = #{obdng_id}
					AND A.FLR_ID = #{regCd}
				</if>
				GROUP BY A.STAND_DT, C.REF2
			) A RIGHT JOIN (
					SELECT  i, to_char(#{stand_dt_e}::date - i,'yyyymmdd') as STAND_DT, START_TM, END_TM, TIME_CD
					FROM generate_series(0,(select #{stand_dt_e}::date - #{stand_dt_s}::date)) as t(i) 
					INNER JOIN T_TIME_CD 
					ON CD_TYPE=#{cd_type}
					ORDER BY STAND_DT, START_TM
			) B
			ON A.TIME_CD = B.TIME_CD
			AND A.STAND_DT = B.STAND_DT
		 ) B, (
		 	SELECT B.STAND_DT
				, B.TIME_CD
				, B.START_TM
				, B.END_TM
				, COALESCE(ISMART_CNS_QNT, 0) AS ISMART_CNS_QNT
			FROM (
			 	SELECT A.MTR_DATE AS STAND_DT
			 		, A.TIME_CD
			 		, SUM(A.ISMART_CNS_QNT*1000) AS ISMART_CNS_QNT
			 	<if test="regLvl !='4'.toString()">
				 	FROM T_OBDNG_ISMART_BYTM_SUM A, T_OBDNG_INFO_BAS B
			 	</if>
			 	<if test="regLvl =='4'.toString()">
			 		FROM T_OBDNG_ISMART_BYTM_SUM A, T_OBDNG_FLR_INFO_BAS B, T_OBDNG_INFO_BAS C
			 	</if>
			 	<if test="regLvl =='1'.toString()">
					, T_REGION_CD D
				</if>
				<if test="regLvl !='4'.toString()">
				 	WHERE A.ISMART_ID = B.ISMART_ID
				</if>
				<if test="regLvl =='4'.toString()">
					WHERE A.ISMART_ID = C.ISMART_ID
					AND B.OBDNG_ID = C.OBDNG_ID
				</if>
			 	<if test="regLvl =='1'.toString()">
					AND B.RGN_CD = D.REGION_SUB_CD
					AND D.REGION_CD = #{regCd}
				</if>
				<if test="regLvl =='2'.toString()">
					AND B.RGN_CD = #{regCd}
				</if>
				<if test="regLvl =='3'.toString()">
					AND B.OBDNG_ID = #{regCd}
				</if>
				<!-- <if test="regLvl =='4'.toString()">
					AND B.OBDNG_ID = #{obdng_id}
					AND B.FLR_ID = #{regCd}
				</if> -->
			 	  AND A.MTR_DATE BETWEEN #{stand_dt_s} AND #{stand_dt_e}
			 	GROUP BY A.MTR_DATE, A.TIME_CD
		 	) A RIGHT JOIN (
					SELECT  i, to_char(#{stand_dt_e}::date - i,'yyyymmdd') as STAND_DT, START_TM, END_TM, TIME_CD
					FROM generate_series(0,(select #{stand_dt_e}::date - #{stand_dt_s}::date)) as t(i) 
					INNER JOIN T_TIME_CD 
					ON CD_TYPE=#{cd_type}
					ORDER BY STAND_DT, START_TM
			) B
			ON A.STAND_DT = B.STAND_DT
			AND A.TIME_CD = B.TIME_CD
			ORDER BY A.STAND_DT
		 ) C
		 WHERE A.STAND_DT = B.STAND_DT
		   AND A.TIME_CD = B.TIME_CD
		   AND A.STAND_DT = C.STAND_DT
		   AND A.TIME_CD = C.TIME_CD
		 ORDER BY STAND_DT, START_TM