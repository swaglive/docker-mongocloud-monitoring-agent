![docker-publish-to-dh](https://github.com/swaglive/docker-mongocloud-monitoring-agent/workflows/docker-publish-to-dh/badge.svg)

```
docker build -t swaglive/mongocloud-monitoring-agent .
```

```bash
export MMS_API_KEY=
export MMS_GROUP_ID=

docker run -it --rm -e MMS_API_KEY -e MMS_GROUP_ID swaglive/mongocloud-monitoring-agent
```
