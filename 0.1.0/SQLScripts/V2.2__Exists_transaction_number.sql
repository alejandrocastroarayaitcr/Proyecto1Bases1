USE XtreamDB;

DROP PROCEDURE IF EXISTS SP_GET_PAYMENT_BY_TRAN_NUM;

DELIMITER $$
CREATE PROCEDURE SP_GET_PAYMENT_BY_TRAN_NUM(
	IN tran VARCHAR(256)
)
BEGIN

	SELECT 
		postTime,
        amount,
        referenceNumber,
        errorNumber,
        merchantTransactionNumber, 
        description,
        paymentTimeStamp,
        currencySymbol
	FROM paymentAttempts
    WHERE merchantTransactionNumber = tran;

END$$ 
DELIMITER ;