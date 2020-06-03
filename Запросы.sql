/*1 
Для города, начинающий с заданной буквы выведите ближайшие открытия магазинов  */
SELECT *
FROM shop s
WHERE (now()-s.date_start) = (SELECT MIN(sshop.time)
								FROM (SELECT s.name, s.city, s. date_start, (now()-s.date_start) as time
								FROM shop s
								WHERE s.city LIKE 'B%' AND s.date_finish IS NULL) as sshop)

/*2
Для заданного магазина вывести  сотрудников, которые здесь работают.  */
SELECT *
FROM shop s
INNER JOIN shop_employee se ON s.id=se.shop_id
INNER JOIN employee e ON e.id=employee_id
WHERE s.name LIKE 'West%'

/*3
Выведите клиентов, которые в любых магазинах компании потратили более 10000 рублей на покупки.  */
SELECT *
FROM client c
INNER JOIN buy b ON c.id=b.client_id
WHERE b.amount_spent::integer>10000

/*4
Выведите 10% клиентов, которые потратили наибольшую сумму. */
SELECT *
FROM client c
INNER JOIN buy b ON c.id=b.client_id
ORDER BY b.amount_spent DESC
LIMIT 3

/*5
Посчитайте среднюю сумму, потраченную этими клиентами*/
with client_buy as (SELECT *
					FROM client c
					INNER JOIN buy b ON c.id=b.client_id
					ORDER BY b.amount_spent DESC
					LIMIT 3)
SELECT SUM(c_b.amount_spent::integer)/3
FROM client_buy c_b

/*6
Выведите проданное количество единиц товара*/
SELECT p.name, COUNT(p.name)
FROM product p
INNER JOIN buy b ON p.id=b.product_id
GROUP BY p.name

/*7
Вывести нужно те товары и их количество, которого не хватит на неделю */
with product_buy as (SELECT p.name, p.id, COUNT(p.name)
					FROM product p
					INNER JOIN buy b ON p.id=b.product_id
					GROUP BY p.name, p.id)
SELECT *, w.count
FROM product_buy p_b
INNER JOIN warehouse w ON w.product_id=p_b.id
WHERE w.count<=(2*p_b.count)

/*8
Для заданного сотрудника выведите его график работы.*/
SELECT *
FROM employee e
INNER JOIN shop_employee se ON se.employee_id=e.id

/*9
Для всех товаров в магазине выведите цену*/
SELECT p.name, ssp.price
FROM product p
INNER JOIN buy b ON b.product_id=p.id
INNER JOIN supplier_shop_product ssp ON b.shop_id=ssp.shop_id

/*12
Для заданного поставщика выведите в заданном магазине сотрудника, который принимал их товар наибольшее количество раз.*/
with sshop as(SELECT s.name, e.name, COUNT(supplier_id)
				FROM shop s
				INNER JOIN supplier_shop_product ssp ON ssp.shop_id=s.id
				INNER JOIN employee e ON ssp.employee_id=e.id
				WHERE ssp.supplier_id =5
				GROUP BY s.name, e.name),
				sip as(SELECT COUNT(supplier_id)
					FROM shop s
					INNER JOIN supplier_shop_product ssp ON ssp.shop_id=s.id
					INNER JOIN employee e ON ssp.employee_id=e.id
					WHERE ssp.supplier_id =5
					GROUP BY s.name, e.name)
SELECT *
FROM sshop s
WHERE s.count = (SELECT MAX(si.count)
				 FROM sip si)

/*15*/
ALTER TABLE employee ADD salary integer;
UPDATE employee 
SET salary=30000