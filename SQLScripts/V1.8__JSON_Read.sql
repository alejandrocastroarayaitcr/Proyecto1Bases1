-- Cree un stored procedure que retorne el resultado de una consulta de al menos 3 tablas unidas en formato json
USE `XtreamDB` ;


DROP PROCEDURE IF EXISTS history;

DELIMITER $$

CREATE PROCEDURE history(
    IN username varchar(45)
)
	
BEGIN

	select idUser into @idUser from users where users.username=username;
    select username as `Usuario`, streams.title as `Stream`, categories.name as `Categorie`, Channel.displayName as `Streamer`, log.PostTime as `Date` from StreamLog as log -- , StreamEventType as `type`
    left join streams 
    on streams.idStreams = log.idStreams
    left join categories 
    on streams.idCategories = categories.idCategories
    left join Channel
    on streams.idChannel = Channel.idChannel
    where log.idUser=@idUser and log.idStreamEventType=1
    for JSON AUTO;

END $$
DELIMITER ;



