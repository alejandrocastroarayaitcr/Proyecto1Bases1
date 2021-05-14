-- Una consulta que retorne un listado de los montos y personas, categorízados por año y mes de aquellos dineros que 
-- no se han podido cobrar,en el query debe poder verse las categorías, nombres y montos debidamente agrupados

USE XtreamDB;

SELECT YEAR(paymentTimeStamp) Year, MONTH(paymentTimeStamp) Month, ANY_VALUE(CONCAT(firstname, ' ', lastname)) CustomerName, ANY_VALUE(amount) Amount , ANY_VALUE(paymentStatus.name)Status FROM paymentAttempts 
INNER JOIN users ON paymentAttempts.idUser = users.idUser
INNER JOIN paymentStatus ON paymentAttempts.idpaymentStatus = paymentStatus.idPaymentStatus
WHERE paymentAttempts.idpaymentStatus = 2 OR paymentAttempts.idpaymentStatus = 3
GROUP BY Year, Month
ORDER BY YEAR ASC, MONTH ASC;


