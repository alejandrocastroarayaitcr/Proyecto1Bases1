DELIMITER //

CREATE PROCEDURE ColumnaDinamica()
BEGIN

	SELECT users.username, users.verified ,ratings.rating,
    CASE WHEN rating > 4 THEN 'Top rated streamer'
    WHEN rating <= 4 and rating >= 3 THEN 'Average rated streamer'
    ELSE 'Low rated streamer'
    END AS popularity
    FROM users
    JOIN ratings ON users.idUser=ratings.idUser;
    
END //

DELIMITER ;