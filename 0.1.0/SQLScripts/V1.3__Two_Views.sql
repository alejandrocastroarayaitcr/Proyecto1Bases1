use XtreamDB;
-- Dos views utiles para el sistema

-- View que permite ver todos los streams en vivo en el momento
CREATE VIEW all_live_streams
AS
SELECT 
	title,
    viewers currentViewers,
    maxiumViewers maxViewers,
    averageViewers avgViewers,
    categories.name streamCategory,
    categories.idCategories streamCategoryID,
    Channel.idChannel ChannelID,
    Channel.displayName channelName,
    Channel.pictureURL channelPicure    

FROM streams 
INNER JOIN categories ON streams.idCategories = categories.idCategories
INNER JOIN Channel ON streams.idChannel = Channel.idChannel
WHERE streams.live = 1;

--  SELECT * FROM all_live_streams ORDER BY currentViewers DESC;

-- view que permite ver todas las donaciones hechas en la plataforma para cada canal
CREATE VIEW all_donations_per_channel
AS
SELECT
	Channel.idChannel ChannelID,
	Channel.displayName ChannelName,
    donations.idDonations DonationID,
    donations.amount DonationAmount,
    donations.message DonationMessage,
    trans.postTime postTime

FROM donationsPerUser donarUser
INNER JOIN donations ON donarUser.idDonations = donations.idDonations
INNER JOIN Channel ON donarUser.idChannel = Channel.idChannel
INNER JOIN paymentTransactions trans ON donations.idpaymentTransactions = trans.idpaymentTransactions;

-- SELECT * FROM all_donations_per_channel;


