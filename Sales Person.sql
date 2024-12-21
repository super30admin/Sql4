
SELECT S.NAME FROM SALESPERSON S WHERE s.sales_id not in (select o.sales_id  
from orderS o left join company c on c.com_id =o.com_id
where c.name ='RED')