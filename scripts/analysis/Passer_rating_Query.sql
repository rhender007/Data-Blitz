


select table_schema, table_name, column_name from information_schema.columns
;where TABLE_SCHEMA = 'db nfl';



SELECT 
PASSER.PNAME AS PASSER
,TARGET.PNAME AS TARGET
, PASSER_RATING.PASS_RAT
, PASS_FULL.LOC
, PASS_FULL.YDS
, PASS_FULL.COMP
, PASS_FULL.TD
, PASS_FULL.INTRCPT
, PASS_FULL.SPK
, PASSER.HEIGHT AS PASSER_HGHT
, PASSER.HAND  AS PASSER_HAND
, PASSER.DOB AS PASSER_DOB
, PASSER.START AS PASSER_CAREER_STRT
, GAME.SEAS - PASSER.START AS PASSER_YRS_IN_LEAG
, TARGET.HEIGHT AS TGT_HGHT
, TARGET.WEIGHT AS TGT_WGHT
, TARGET.DOB AS TGT_DOB
, TARGET.HAND AS TGT_HAND
, TARGET.ARM AS TGT_ARM
, TARGET.DPOS AS TGT_POS
, TARGET.START AS TGT_CAREER_STRT /*'USE TO FIGURE OUT YEARS IN LEAGUE'*/
, TARGET.FORTY AS TGT_40
, TARGET.VERTICAL AS TGT_VERT
,QTR
,MIN /*'CAN BE USED FOR TWO MIN DRILL'*/
,DWN
,YTG
,ZONE /*'DEFINITION AVAILABLE'*/
,SG as SHOTGUN
,NH AS NO_HUDDLE
, PENALTY.ACT AS PENALTY_ACT
, PENALTY.DESC as PENALTY_DESC
,GAME.SEAS
,GAME.WK
,GAME.DAY
,GAME.V /*'FIGURE OUT HOW TO DO HOME OR AWAY'*/
,GAME.H
/*HOW DO WE CALCULATE WHETHER THE PASSER IS AT HOME OR AWAY?*/
,GAME.TEMP
,GAME.HUMD
,GAME.WSPD
,GAME.COND
,GAME.SURF
 FROM PBP
 INNER JOIN PASS_FULL
 ON PBP.PID = PASS_FULL.PID
left outer join GAME
ON PBP.GID = GAME.GID
LEFT OUTER JOIN PENALTY
ON PBP.PID = PENALTY.PID
AND PENALTY.CAT = '4'
INNER JOIN PLAYER PASSER
ON PASS_FULL.PSR = PASSER.PLAYER
LEFT OUTER JOIN PLAYER TARGET
ON PASS_FULL.TRG = TARGET.PLAYER
LEFT OUTER JOIN PASSER_RATING
ON PASS_FULL.YDS = PASSER_RATING.YDS
AND PASS_FULL.COMP = PASSER_RATING.COMPL
AND PASS_FULL.TD = PASSER_RATING.TD
AND PASS_FULL.INTRCPT = PASSER_RATING.INTRCPT
ORDER BY SEAS, WK, PASSER
;



SELECT * FROM PASS_FULL;
PASS_FULL.LOC
, PASS_FULL.YDS
, PASS_FULL.COMP
, PASS_FULL.TD
, PASS_FULL.INTRCPT
, PASS_FULL.SPK


;
Select * from PLAYER;
--POS1
--HEIGHT
--WEIGHT
--HAND
--ARM
--DPOS
--START 'USE TO FIGURE OUT YEARS IN LEAGUE'
--FORTY
--VERTICAL
;


;
SELECT * FROM GAME;
--SEAS
--WK
--DAY
--V 'FIGURE OUT HOW TO DO HOME OR AWAY'
--H
--TEMP
--HUMD
--WSPD
--COND
--SURF

; SELECT DISTINCT DATE FROM SCHEDULE;



;
SELECT `DESC`, CAT FROM PENALTY
GROUP BY `DESC`, CAT
order by 2;







SELECT COUNT(*) FROM PASS_FULL;

CREATE TABLE `PASS_FULL` (
  `PID` int(11) DEFAULT NULL,
  `psr` text,
  `trg` text,
  `loc` text,
  `yds` int(11) DEFAULT NULL,
  `comp` int(11) DEFAULT NULL,
  `succ` int(11) DEFAULT NULL,
  `spk` int(11) DEFAULT NULL,
  `dfb` text,
  `TD` INT(1) DEFAULT NULL,
  `INTRCPT` INT(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


;

;
Select * from TD
where pid in (
'56839',
'71325',
'120970',
'128308',
'189288',
'254211',
'389762')
;
select distinct type from TD
;
Select PASS.PID, PASS.PSR, PASS.TRG, PASS.LOC, PASS.YDS, PASS.COMP, PASS.SUCC, PASS.SPK, PASS.DFB
, CASE WHEN TD.PTS IS not NULL
AND INTERCEPT.IRY IS NOT NULL
THEN 0
WHEN TD.PTS IS NOT NULL
THEN 1
ELSE 0
END
AS TD
, CASE WHEN INTERCEPT.IRY IS not NULL
THEN 1
ELSE 0
END
AS INTRCPT
from PASS
LEFT OUTER JOIN TD
ON PASS.PID = TD.PID
LEFT OUTER JOIN INTERCEPT
ON PASS.PID = INTERCEPT.PID
/*left outer join PLAYER PASSER
ON PASS.PSR = PASSER.PLAYER
WHERE PASSER.PLAYER = 'TB-2300'
*/
;

SELECT DISTINCT IRY FROM INTERCEPT
ORDER BY 1 DESC
;
Select * from PASS_FULL


;

Select PASSER.PNAME, LOC, ROUND(SUM(PASSER_RATING.PASS_RAT)/COUNT(*),2), COUNT(*)
from PASS
left outer join PLAYER PASSER
ON PASS.PSR = PASSER.PLAYER
/*LEFT OUTER JOIN PLAYER REC
ON PASS.TRG = REC.PLAYER
left outer join INTERCEPT
ON PASS.PID = INTERCEPT.PID*/
LEFT OUTER JOIN PASSER_RATING
ON PASS.COMP = PASSER_RATING.COMPL
AND PASS.YDS = PASSER_RATING.YDS
AND PASSER_RATING.INTRCPT = 0
AND PASSER_RATING.TD = 0
WHERE PASSER.PLAYER = 'TB-2300'
GROUP BY PASSER.PNAME, LOC

;
select * from PLAYER
WHERE PNAME LIKE '%BRADY%'
;
SELECT * 


;
SELECT INTS, COUNT(*) FROM PBP
WHERE DETAIL LIKE '%touchdown%'
GROUP BY INTS;

SELECT * FROM PASSER_RATING