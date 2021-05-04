-- Esta consulta mide el rating de los usuarios registrados y dependiendo de su rating los clasifica en diferentes categorias de rating
-- Si tienen un rating mas alto que 4 entonces son top rated streamers, si tienen un rating mayor o igual a 3 y menor o igual a 4 entonces son average rated y
-- si tienen un rating menor a 3 son low rated streamers. Su categoria segun su rating se llama rating_category y es una columna dinamica
-- Como es una distribucion de todos los streamers, si se suma la cantidad de streamers de cada categoria da el total de streamers

SELECT COUNT(users.idUser) as streamer_number,
CASE WHEN rating > 4 THEN 'Top rated streamer'
WHEN rating <= 4 and rating >= 3 THEN 'Average rated streamer'
ELSE 'Low rated streamer'
END AS rating_category
FROM users
JOIN ratings ON users.idUser=ratings.idUser
GROUP BY rating_category;
