from ultralytics.data.converter import convert_ndjson_to_yolo
import asyncio

asyncio.run(convert_ndjson_to_yolo("embryofixv3.ndjson"))