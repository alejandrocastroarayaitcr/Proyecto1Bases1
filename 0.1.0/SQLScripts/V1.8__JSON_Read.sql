-- Cree un stored procedure que retorne el resultado de una consulta de al menos 3 tablas unidas en formato json
USE `XtreamDB`;

DROP PROCEDURE IF EXISTS history;

DELIMITER $$

CREATE PROCEDURE history(
    IN username varchar(45)
)
BEGIN
	select idUser into @idUser from users where users.username=username;
	SELECT JSON_ARRAYAGG(JSON_OBJECT
		('Usuario', Historial.`HUsuario`,
        'Stream', Historial.`HStream`,
        'Categorie', Historial.`HCategorie`,
        'Streamer', Historial.`HStreamer`)) 
	FROM (select
		username `HUsuario`, 
		streams.title `HStream`, 
		categories.name `HCategorie`, 
		Channel.displayName `HStreamer`, 
		log.PostTime `HDate`
	from StreamLog as `log` -- , StreamEventType as `type`
	left join streams 
		on streams.idStreams = log.idStreams
	left join categories 
		on streams.idCategories = categories.idCategories
	left join Channel
		on streams.idChannel = Channel.idChannel
	left join users
		on users.idUser = Channel.idUser
	where log.idUser=@idUser and log.idStreamEventType=1) AS Historial;

END $$
DELIMITER ;


