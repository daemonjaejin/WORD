CREATE TABLE t_obdng_info_bas_tmp
(
  obdng_id character varying(15) NOT NULL,
  ismart_id character varying(12),
  obdng_nm character varying(50),
  town_cd character varying(10),
  grs_val numeric(15,3),
  latit numeric(9,6),
  lngit numeric(9,6),
  ip_set character varying(120),
  rgn_cd character varying(8),
  chage_aply_elect integer,
  cont_elect integer,
  obdng_adr character varying(400),
  asgn_rate integer,
  obdng_rep_id character varying(15),
  area_val numeric(15,3),
  chage_syst_cd character(6),
  readmet_day integer DEFAULT 28,
  upd_dt_idx character varying(14),
  cret_dt timestamp without time zone,
  CONSTRAINT t_obdng_info_bas_tmp_pkey PRIMARY KEY (obdng_id)
)



CREATE TABLE t_obdng_flr_info_bas_tmp
(
  obdng_id character varying(15) NOT NULL,
  flr_id character varying(12) NOT NULL,
  flr_nm character varying(50),
  flr_div_cd character varying(10),
  flr_area_val numeric(15,3),
  flr_odrg numeric(5,0),
  upd_dt_idx character varying(14),
  cret_dt timestamp without time zone,
  CONSTRAINT t_obdng_flr_info_bas_tmp_pkey PRIMARY KEY (obdng_id, flr_id)
)


CREATE TABLE t_obdng_instn_info_bas_tmp
(
  obdng_id character varying(15) NOT NULL,
  flr_id character varying(12) NOT NULL,
  ofce_id character varying(12) NOT NULL,
  instn_id character varying(12) NOT NULL,
  area_val numeric(15,3),
  ofce_nm character varying(50),
  upd_dt_idx character varying(14),
  cret_dt timestamp without time zone,
  CONSTRAINT t_obdng_instn_info_bas_tmp_pkey PRIMARY KEY (obdng_id, flr_id, ofce_id, instn_id)
)
