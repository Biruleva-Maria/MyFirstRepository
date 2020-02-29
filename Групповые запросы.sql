#1 
SELECT st.n_group, COUNT(st.n_group) 
FROM students st 
GROUP BY st.n_group 
#2 
SELECT st.n_group, MAX(st.score) 
FROM students st 
GROUP BY st.n_group 
#3 
SELECT st.name, COUNT(st.name) 
FROM students st 
GROUP BY st.name 
#4 

#5 
SELECT AVG(st.score) 
FROM students st
#6
SELECT st.n_group, MAX(st.score)
FROM students st
GROUP BY st.n_group
LIMIT 1
#7
SELECT st.n_group, AVG(st.score) AS avg
FROM students st
GROUP BY st.n_group
HAVING AVG(st.score) <= 3.5
ORDER BY avg DESC
#8
SELECT st.n_group, AVG(st.score) AS avg, MAX(st.score) AS max, MIN(st.score) AS min, COUNT(st.score) AS count
FROM students st
GROUP BY st.n_group
#9
SELECT *
FROM students st
WHERE st.score= (SELECT MAX(st.score)
				 FROM students st)
