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
