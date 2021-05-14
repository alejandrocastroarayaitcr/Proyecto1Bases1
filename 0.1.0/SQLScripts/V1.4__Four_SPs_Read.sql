-- Stored procedures que realizan operaciones de lectura y que hacen uso de los views creados
-- 1. donations_for_channel(channelName)
-- 2. top_lives_streams_for_category(categoryName)
-- 3. all_donations_since(date)
-- 4. top_categories_viewers()

-- SP #1
-- All donations for 1 specific channel
DROP PROCEDURE IF EXISTS donations_for_channel;
DELIMITER $$

CREATE PROCEDURE donations_for_channel
(
	IN channelName varchar(70)
)
BEGIN 
	
	set @channelID = 0;
	SELECT IFNULL(idChannel, @channelID) into @channelID FROM Channel WHERE displayName = channelName;
    
	if(@channelID = 0) then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid channel name!';
	end if;

    SELECT ChannelName, SUM(DonationAmount) SumDonationsReceived FROM all_donations_per_channel WHERE ChannelID = @channelID; 

END$$
DELIMITER ;

-- SP #2
-- Top live streams for one specific category in order
DROP PROCEDURE IF EXISTS top_lives_streams_for_category;
DELIMITER $$

CREATE PROCEDURE top_lives_streams_for_category
(
	IN categoryName varchar(70)
)
BEGIN 

	set @categoryID = 0;
	SELECT IFNULL(idCategories, @categoryID) into @categoryID FROM categories WHERE name = categoryName;
    
	if(@categoryID = 0) then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid category name!';
	end if;

    SELECT title, channelName ChannelName, streamCategory Category ,currentViewers FROM all_live_streams WHERE `streamCategoryID` = @categoryID ORDER BY currentViewers DESC; 

END$$
DELIMITER ;

-- SELECT * FROM all_live_streams;
-- Call top_lives_streams_for_category("Clash Royale");



-- SP #3
-- All donations made on the platform since X date
DROP PROCEDURE IF EXISTS all_donations_since;
DELIMITER $$

CREATE PROCEDURE all_donations_since
(
	IN sinceDATE DATETIME
)
BEGIN 

    SELECT ChannelName, DonationID, DonationAmount, DonationMessage, postTime DateOfDonation FROM all_donations_per_channel WHERE postTIme > sinceDATE ORDER BY postTime ASC;

END$$
DELIMITER ;

-- Select * from all_donations_per_channel;
--  CALL all_donations_since('2019-11-13 23:00:00');



-- SP #4
-- Categories with most live viewers in order
DROP PROCEDURE IF EXISTS top_categories_viewers;
DELIMITER $$

CREATE PROCEDURE top_categories_viewers
(
)
BEGIN 

    SELECT streamCategory Category, SUM(currentViewers) Viewers
    FROM all_live_streams 
    GROUP BY(Category)
    ORDER BY Viewers DESC; 

END$$
DELIMITER ;

 -- call top_categories_viewers();