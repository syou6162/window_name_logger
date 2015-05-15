# Usage

`*/1 * * * *`で回す。

```bash
curl -XDELETE http://localhost:9200/window_name
curl -XPUT localhost:9200/window_name
curl -XPUT localhost:9200/window_name/window_name/_mapping -d @window_name_mapping.json

cd /Users/yasuhisa/Desktop/work/window_name_logger
ruby window_name_logger.rb |
  while read line
  do
    id=$(echo $line | jq -c '.date' | tr -d "\n")
    echo $id
    echo "{ \"index\" : { \"_index\" : \"window_name\", \"_type\" : \"window_name\", \"_id\" : ${id}} }\n$line" | curl -XPOST localhost:9200/_bulk --data-binary @-
  done
```
