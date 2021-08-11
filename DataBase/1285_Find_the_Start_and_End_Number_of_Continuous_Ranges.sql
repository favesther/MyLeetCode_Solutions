select min(log_id) start_id, max(log_id) end_id
from (select log_id, rank() over (order by log_id) rnk
from Logs) t
group by log_id - rnk