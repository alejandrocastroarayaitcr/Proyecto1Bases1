USE XtreamDB;

-- Procedimiento para insertar en la tabla temporal
-- Esto inserta un tag en un stream

DROP PROCEDURE IF EXISTS pInsertTagsPerStream;

DELIMITER $$ 

CREATE PROCEDURE pInsertTagsPerStream(
	IN randomKey VARCHAR(256),
	IN tagName VARCHAR(45),
    IN streamTitle VARCHAR(200),
    IN email VARCHAR(76)
)
BEGIN 
	DECLARE StreamId INT DEFAULT 0;
    DECLARE TagId INT DEFAULT 0;

	-- Esta tabla se crea por sesion de conexion y se borra
    -- cuando se desconecta, asi que se crea por si acaso.
	CREATE TEMPORARY TABLE IF NOT EXISTS temporaryTagsPerStream(
		temporaryId VARCHAR(256) NOT NULL,
		idTags INT NOT NULL,
		idStreams INT NOT NULL
	);
		
	-- Obtenemos la id del stream
	SELECT str.idStreams idStreams INTO StreamId 
    FROM streams str
	INNER JOIN Channel chan ON str.idChannel = chan.idChannel
	INNER JOIN users us ON us.idUser = chan.idUser
    WHERE 
		str.title = streamTitle AND
        us.email = email
	LIMIT 1;

    -- Obtenemos la id del tag
    SELECT idTags INTO TagId FROM tags
	WHERE name = tagName LIMIT 1;
    
    -- Insertamos en la tabla temporal
    INSERT INTO temporaryTagsPerStream (temporaryId, idTags, idStreams)
    VALUES (randomKey, TagId, StreamId);
END$$

DELIMITER ;

-- Procedimiento para cargar los datos de la tabla temporal 
-- en la de TagsPerStream (permite cargar los tags de un stream

DROP PROCEDURE IF EXISTS pLoadTagsPerStreamIntoTable;

DELIMITER $$ 

CREATE PROCEDURE pLoadTagsPerStreamIntoTable(
	IN randomKey VARCHAR(256)
)
BEGIN
	-- Cargamos los datos de la tabla temporal transaccionalmente
	INSERT INTO TagsPerStream (idTags, idStreams)
	SELECT idTags, idStreams FROM temporaryTagsPerStream
	WHERE temporaryId = randomKey;
END$$

DELIMITER ;