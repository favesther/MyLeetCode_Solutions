select if(from_id<to_id, from_id, to_id) person1,
if(from_id>to_id, from_id, to_id) person2,
count(*) call_count, sum(duration) total_duration
from Calls
group by 1,2