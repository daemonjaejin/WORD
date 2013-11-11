SELECT *
FROM t_obdng_info_bas
order by obdng_nm

select length(obdng_adr), obdng_adr, trim(obdng_adr), length(trim(obdng_adr))
from t_obdng_info_bas

-- delete from t_obdng_info_bas;
-- delete from t_obdng_flr_info_bas;
-- delete from t_obdng_instn_info_bas;
-- commit;


select a.obdng_id, a.flr_id, flr_area_val, sum (area_val),  flr_area_val- sum (area_val)
from t_obdng_flr_info_bas  a ,t_obdng_instn_info_bas b
where a.obdng_id =  b.obdng_id
  and a.flr_id = b.flr_id
 group by a.obdng_id, a.flr_id, flr_area_val
 order by a.obdng_id, a.flr_id


 select a.obdng_id, a.area_val, sum (b.area_val), a.area_val- sum (b.area_val)
from 
 t_obdng_info_bas  a
,t_obdng_instn_info_bas b
where a.obdng_id =  b.obdng_id
 group by a.obdng_id, a.area_val
 order by a.obdng_id 


 select area_val
 from t_obdng_instn_info_bas
 where obdng_id = 'A01-B0000004094'
   and flr_id = '4'
   group by area_val

   select *
 from t_obdng_instn_info_bas
 where obdng_id = 'A01-B0000004094'
   and flr_id = '5'
   group by area_val


   
 select *
 from t_obdng_flr_info_bas
 where obdng_id = 'A01-B0000000896'
 and flr_id = 'B02';

    
 select *
 from t_obdng_flr_info_bas
 where obdng_id = 'A01-B0000000896'
 and flr_id = 'B03';



    select *
 from t_obdng_flr_info_bas
 where obdng_id = 'A01-B0000000896'