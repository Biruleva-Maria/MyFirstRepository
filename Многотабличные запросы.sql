#1
SELECT st.name, st.surname, h.name as hobby
From students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
INNER JOIN hobbies h ON h.id=sh.hobby_id 
GROUP BY st.name, st.surname, h.name
#2
SELECT st.name, st.surname, st.n_group, st.phone, st.city, st.score, st.birth_date, h.name as hobby, MAX(age(now(),sh.date_start)), sh.date_finish
From students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
INNER JOIN hobbies h ON h.id=sh.hobby_id 
GROUP BY st.name, st.surname, st.n_group, st.phone, st.city, st.score, st.birth_date, h.name,sh.date_finish
ORDER BY MAX(age(now(),sh.date_start)) DESC
LIMIT 1
#3
SELECT st.name, st.surname, st.birth_date, st.id, SUM(h.risk)
FROM students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id  
INNER JOIN hobbies h ON h.id=sh.hobby_id
WHERE st.score>(SELECT AVG(st.score) FROM students st) AND sh.date_finish is not null    
GROUP BY st.name, st.surname, st.birth_date, st.id
#4
SELECT st.name, st.surname, st.birth_date, h.name as hobby, h.risk, extract(month from age(sh.date_finish, sh.date_start))+ extract (year from age (sh.date_finish, sh.date_start)*12)
From students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
INNER JOIN hobbies h ON h.id=sh.hobby_id 
WHERE sh.date_finish IS NOT NULL
#5
SELECT st.name, st.surname, st.birth_date, st.id, extract(years from age(st.birth_date))
FROM students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
INNER JOIN hobbies h ON h.id=sh.hobby_id  
WHERE sh.date_finish is null
GROUP BY st.name, st.surname, st.birth_date, st.id
HAVING extract(years from age(st.birth_date))=20
#6
SELECT DISTINCT(st.n_group),AVG(st.score)
FROM students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
WHERE sh.date_finish is null
GROUP BY st.n_group
#7
SELECT h.name, h.risk, st.id, st.name, st.surname, sh.date_start,extract(month from age(sh.date_start))+ extract (year from age (sh.date_start)*12)
FROM students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
INNER JOIN hobbies h ON h.id=sh.hobby_id  
WHERE sh.date_finish is null
GROUP BY h.name, h.risk, st.id, st.name, st.surname, sh.date_start, age(sh.date_start)
ORDER BY MAX(age(now(),sh.date_start)) DESC
LIMIT 1
#8
SELECT DISTINCT(h.name), MAX(s.score)
FROM hobbies h
INNER JOIN students_hobbies sh ON h.id=sh.hobby_id
INNER JOIN students s ON s.id=sh.student_id 
WHERE s.score=(SELECT MAX(s.score)
			  FROM students s)
GROUP BY h.name, s.score
#9
SELECT h.name
FROM hobbies h
INNER JOIN students_hobbies sh ON h.id=sh.student_id 
INNER JOIN students s ON s.id=sh.hobby_id 
WHERE s.score BETWEEN 2.49 AND 3.5 AND sh.date_finish IS NULL AND CAST (s.n_group AS varchar) like '2___' 
GROUP BY h.name, s.score
#10
SELECT *
FROM (Select substr(st.n_group::varchar, 1,1) as course, count(*)
From students st
Group by substr(st.n_group::varchar, 1,1)) as st_all
INNER JOIN (
Select substr(st.n_group::varchar, 1,1) as course, count(*)
From students st
INNER JOIN students_hobbies sh
on st.id=sh.student_id
WHERE sh.date_finish is null
Group by substr(st.n_group::varchar, 1,1)
Having count (*)>1) as st_wh
ON st_all.course = st_wh.course
#11
SELECT *
FROM (Select substr(st.n_group::varchar, 1,4) as NGROUP, count(*) as c_group
From students st
Group by substr(st.n_group::varchar, 1,4)) as st_all
INNER JOIN (
Select substr(st.n_group::varchar, 1,4) as NGROUP, count(*) as c_good
From students st
WHERE st.score>=4
Group by substr(st.n_group::varchar, 1,4)
Having count (*)>1) as st_gd
ON st_all.NGROUP = st_gd.NGROUP
WHERE st_all.NGROUP::integer/st_gd.NGROUP::integer>=0.6
#12
Select substr(st.n_group::varchar, 1,1) as course, substr(sh.date_finish::varchar, 1,10) as finish, count(*) as c_good
From students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
INNER JOIN hobbies h ON h.id=sh.hobby_id  
Group by substr(sh.date_finish::varchar, 1,10),substr(st.n_group::varchar, 1,1)
Having count (*)>1
#13
Select st.id, st.name, st.surname, st.birth_date, substr(st.n_group::varchar, 1,1) as course
From students st
FULL JOIN students_hobbies sh ON st.id=sh.student_id
WHERE st.score >=4.5
group by st.id, st.name, st.surname, st.birth_date, substr(st.n_group::varchar, 1,1)
having count(sh.date_start)= count(sh.date_finish)
#14
CREATE OR REPLACE VIEW student_hobby AS
SELECT st.* 
FROM students st
INNer JOIN students_hobbies sh ON st.id=sh.student_id
group by st.id, sh.date_finish
having extract(year from age(now(), sh.date_finish))=5;
#15
Select h.name, count(st.name)
from hobbies h
INNER JOIN students_hobbies sh ON h.id=sh.hobby_id 
INNER JOIN students st ON st.id=sh.student_id 
WHERE sh.date_finish is null
group by h.name
#16
Select h.id
from hobbies h
INNER JOIN students_hobbies sh ON h.id=sh.hobby_id 
INNER JOIN students st ON st.id=sh.student_id 
WHERE sh.date_finish is null
group by h.id, h.name
order by count(st.name) desc
limit 1
#17
Select *
From students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id  
INNER JOIN hobbies h ON h.id=sh.hobby_id 
Where h.name=(Select h.name
				from hobbies h
				INNER JOIN students_hobbies sh ON h.id=sh.hobby_id 
				INNER JOIN students st ON st.id=sh.student_id 
				WHERE sh.date_finish is null
				group by h.id, h.name
				order by count(st.name) desc
				limit 1)
#18
Select h.id
from hobbies h
INNER JOIN students_hobbies sh ON h.id=sh.hobby_id 
INNER JOIN students st ON st.id=sh.student_id 
group by h.id, h.risk
order by h.risk desc
limit 3
#19
Select *
From students st
Inner join students_hobbies sh ON st.id=sh.student_id
Where sh.date_finish is null
Order by sh.date_start
Limit 10
#20
Select DISTINCT(n_group)
FROM(Select *
		From students st
		Inner join students_hobbies sh ON st.id=sh.student_id
		Where sh.date_finish is null
		Order by sh.date_start
		Limit 10) as st_all
#21
CREATE OR REPLACE VIEW student_hobby AS
SELECT st.* 
FROM students st
INNer JOIN students_hobbies sh ON st.id=sh.student_id
group by st.id, sh.date_finish
having extract(year from age(now(), sh.date_finish))=5;
#22
CREATE OR REPLACE VIEW student_hobby AS
with c_hobby as(
			select substr(st.n_group::varchar,1,1) as course, sh.hobby_id, count(*) as c
			from students st
			inner join students_hobbies sh on st.id=sh.student_id
			group by substr(st.n_group::varchar,1,1), sh.hobby_id), 
			max_for_course as(
							select c_h.course, max(c) as max_c
							from c_hobby c_h
							group by c_h.course)
							
select *
from max_for_course m_f_c
inner join c_hobby c_h on c_h.course = m_f_c.course and m_f_c.max_c= c_h.c
#23
CREATE OR REPLACE VIEW student_hobby AS
with c_hobby as(
			select substr(st.n_group::varchar,1,1) as course, sh.hobby_id, count(*) as c
			from students st
			inner join students_hobbies sh on st.id=sh.student_id
			where substr(st.n_group::varchar,1,1) = '2'
			group by substr(st.n_group::varchar,1,1), sh.hobby_id), 
			max_for_course as(
							select c_h.course, max(c) as max_c
							from c_hobby c_h
							group by c_h.course)

select *
from max_for_course m_f_c
inner join c_hobby c_h on c_h.course = m_f_c.course and m_f_c.max_c= c_h.c
#24
CREATE OR REPLACE VIEW student_hobby AS
with all_students as(
			select substr(st.n_group::varchar,1,1) as course, count(distinct(st.name)) as all_course
			from students st
			group by substr(st.n_group::varchar,1,1)), 
			good_students as(
							select substr(st.n_group::varchar,1,1) as course, count(distinct(st.name)) as g_s
							from students st
							where st.score>4.5
							group by substr(st.n_group::varchar,1,1))

select *
from all_students a_s
full join good_students gs on a_s.course = gs.course
#25
Select h.*
from hobbies h
INNER JOIN students_hobbies sh ON h.id=sh.hobby_id 
INNER JOIN students st ON st.id=sh.student_id 
WHERE sh.date_finish is null
group by h.id, h.name
order by count(st.name) desc
limit 1
#26
CREATE OR REPLACE VIEW V2 AS
SELECT st.id, st.surname, st.name, st.n_group 
FROM students st
#27
Select substr(st.name::varchar, 1,1) as alfavit, Max(st.score), avg(st.score), min(st.score)
from students st
where st.score>3.6
group by alfavit
order by alfavit
#28
select substr(st.n_group::varchar, 1,1) as course, st.surname, max(st.score), min(st.score), avg(st.score)
from students st
group by course, st.surname
#29
select substr(st.birth_date::varchar, 1,4) as year, count(h.name)
from students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
INNER JOIN hobbies h ON h.id=sh.hobby_id 
group by year
#30
Select substr(st.name::varchar, 1,1) as alfavit, Max(h.risk), min(h.risk)
from students st
INNER JOIN students_hobbies sh ON st.id=sh.student_id 
INNER JOIN hobbies h ON h.id=sh.hobby_id 
group by alfavit
order by alfavit
#31
SELECT extract(month from st.birth_date), avg(st.score)
FROM students st
INNER JOIN students_hobbies sh ON st.id = sh.student_id
INNER JOIN hobbies h ON h.id = sh.hobby_id
WHERE h.name = 'Футбол'
GROUP BY extract(month from st.birth_date)
#32
select distinct(st.name)|| ' ' || st.surname || ' ' || st.n_group as students
from students st
full JOIN students_hobbies sh ON st.id = sh.student_id
where sh.date_start is not null
#33
SELECT st.surname,
		case when position('ов' IN st.surname) = 0 then 'не найдено'
				else position('ов' IN st.surname)::varchar end
from students st
#34
sELECT rpad(st.surname,10,'#') 
from students st
#35
SELECT trim('#' FROM n_surname) 
FROM (sELECT rpad(st.surname,10,'#') as n_surname
		from students st)as all_surname
#36
select '2000-05-01'::date -'2000-04-01'::date



