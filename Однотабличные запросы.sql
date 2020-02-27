#1
SELECT st.name, st.surname
FROM students st
WHERE st.score>=4 AND st.score<=4.5

SELECT st.name, st.surname
FROM students st
WHERE NOT st.score<4 AND NOT st.score>4.5

SELECT st.name, st.surname
FROM students st
WHERE st.score BETWEEN 4 AND 4.5

SELECT st.name, st.surname
FROM students st
WHERE NOT st.score BETWEEN 0 AND 4 AND NOT st.score BETWEEN 4.5 AND 5
#2
SELECT *
FROM students st
WHERE CAST(st.n_group AS varchar) LIKE '2%'
#3
SELECT *
FROM students st
ORDER BY st.n_group, st.name
#4
SELECT *
FROM students st
WHERE st.score>=4
ORDER BY st.score
#5
SELECT h.name, h.risk
FROM hobbies h
WHERE h.name IN ('Хоккей', 'Футбол')
#6
SELECT sh.student_id, sh.hobby_id
FROM Students_hobbies sh
WHERE sh.date_start BETWEEN '2010-01-01' AND '2020-01-01' AND sh.date_finish ISNULL
#7
SELECT *
FROM students st
WHERE st.score>=4.5
ORDER BY st.score DESC
#8
SELECT st.name, st.surname, st.score
FROM students st
GROUP BY st.name, st.surname, st.score
ORDER BY st.score DESC
LIMIT 5

SELECT st.name, st.surname, st.score
FROM students st
GROUP BY st.name, st.surname, st.score
ORDER BY st.score DESC FETCH FIRST 5 ROWS ONLY
#9
SELECT CASE 
 WHEN h.risk >=8 THEN 'очень высокий'
 WHEN h.risk BETWEEN 6 AND 8 THEN 'высокий'
 WHEN h.risk BETWEEN 4 AND 6 THEN 'средний'
 WHEN h.risk BETWEEN 2 AND 4 THEN 'низкий'
 WHEN h.risk < 2 THEN 'очень низкий'
END risk, h.name
FROM hobbies h
#10
SELECT h.name, h.risk
FROM hobbies h
GROUP BY h.name, h.risk
ORDER BY h.risk DESC
LIMIT 5
