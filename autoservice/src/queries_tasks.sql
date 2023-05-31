-- первое задание
SELECT
    last_name, sum(price) AS total
FROM clients
INNER JOIN auto a on clients.id = a.client_id
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
WHERE city = 'Минск'
GROUP BY last_name
HAVING sum(price) < 1000
ORDER BY last_name;
-- второе задание
SELECT
    city, sum(price) AS total
FROM clients
INNER JOIN auto a on clients.id = a.client_id
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
WHERE date BETWEEN '2023-05-12 10:10:10'  AND '2023-05-13 15:15:15'
GROUP BY city
ORDER BY total DESC;
--третье задание
--для сtбя: сначала нашел сумму заказов по владельцу с сортировкой по убыванию
SELECT
    last_name, sum(price) AS total
FROM clients
INNER JOIN auto a on clients.id = a.client_id
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
GROUP BY last_name
ORDER BY total DESC;
-- далее нашел средний заказ для каждого авто
SELECT
    car_model,avg(price)::numeric(1000, 2) AS average_order_car
FROM auto AS a
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
GROUP BY car_model;
-- сумма заказов по каждому автомобилю
SELECT
    city,car_model, sum(price) AS sum_order
FROM clients
INNER JOIN auto a on clients.id = a.client_id
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
GROUP BY city, car_model;
-- средний заказ по городу (через авто) + 20%
SELECT
    city,avg(price)::numeric(1000, 2) * 1.2 AS average_order
FROM clients
INNER JOIN auto a on clients.id = a.client_id
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
GROUP BY city;
-- выводит сумму заказов по авто и средний чек по городу
SELECT
    a.car_model,
    sum(tos.price) AS total_sum,
    average_clients.average_price
FROM auto a
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
INNER JOIN clients c on c.id = a.client_id
INNER JOIN (SELECT
                c2.city as average_city,
                avg(tos2.price) as average_price
            FROM clients c2
            INNER JOIN auto a2 on c2.id = a2.client_id
            INNER JOIN orders o2 on a2.id = o2.auto_id
            INNER JOIN types_of_services tos2 on o2.types_of_service_id = tos2.id
            GROUP BY c2.city) as average_clients on average_clients.average_city = c.city
GROUP BY a.car_model, average_clients.average_price
-- что то нащупал с having
SELECT
    city,
    car_model,
    sum(price) AS sum_order
FROM clients
INNER JOIN auto a on clients.id = a.client_id
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
GROUP BY city, car_model
HAVING  sum(price) > 400;

-- третье задание полностью
-- нахождение суммы заказов выше среднего по городу на 10% и более(с distinct)
SELECT
    a.car_model,
    sum(tos.price) AS total_sum,
    average_for_city.sum_auto_price
    --(average_for_city.sum_auto_price/average_for_city.count_auto_orders * 1.1)::numeric(100, 2) as average_city
FROM auto a
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
INNER JOIN clients c on c.id = a.client_id
INNER JOIN (SELECT
                c2.city as average_price_city,
                count(DISTINCT a2.car_model) as count_auto_orders,
                sum(tos2.price)  as sum_auto_price
                --avg(tos2.price) as average_price
            FROM clients c2
            INNER JOIN auto a2 on c2.id = a2.client_id
            INNER JOIN orders o2 on a2.id = o2.auto_id
            INNER JOIN types_of_services tos2 on o2.types_of_service_id = tos2.id
            GROUP BY c2.city) as average_for_city on average_for_city.average_price_city = c.city
WHERE c.city = 'Минск'
GROUP BY a.car_model, average_for_city.sum_auto_price, average_for_city.count_auto_orders
HAVING  average_for_city.sum_auto_price/average_for_city.count_auto_orders * 1.1 < sum(tos.price)

-- четвертое задание
SELECT
    c.last_name,
    avg(price)::numeric(1000, 2)  AS average_client_order,
    average_for_city.average_price_city
FROM clients c
INNER JOIN auto a on c.id = a.client_id
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
INNER JOIN (SELECT
                c2.city as average_city,
                avg(tos2.price):: numeric(100, 2) * 1.05 as average_price_city
            FROM clients c2
            INNER JOIN auto a2 on c2.id = a2.client_id
            INNER JOIN orders o2 on a2.id = o2.auto_id
            INNER JOIN types_of_services tos2 on o2.types_of_service_id = tos2.id
            GROUP BY c2.city) as average_for_city on average_for_city.average_city = c.city
WHERE  city = 'Минск'
GROUP BY c.last_name, average_for_city.average_price_city
HAVING average_price_city < avg(price)::numeric(1000, 2)

-- еще по третьему заданию но не понимаю чисел результата
SELECT
    a.car_model,
    avg(tos.price)::numeric(1000, 2)  AS average_client_order
FROM clients c
INNER JOIN auto a on c.id = a.client_id
INNER JOIN orders o on a.id = o.auto_id
INNER JOIN types_of_services tos on tos.id = o.types_of_service_id
WHERE city = 'Минск' AND  tos.price > (SELECT
                avg(tos2.price):: numeric(100, 2) * 1.05
            FROM clients c2
            INNER JOIN auto a2 on c2.id = a2.client_id
            INNER JOIN orders o2 on a2.id = o2.auto_id
            INNER JOIN types_of_services tos2 on o2.types_of_service_id = tos2.id)
GROUP BY  a.car_model

-- это из views находим сумму заказов для каждого города и сортируем по убыванию
def task_2(request):
    cities = Clients.objects.values('city').annotate(total=Sum('auto__order__type_service_id__price')).order_by('-total')
    return render(request, 'autoservice/task_2.html', {'cities': cities})


