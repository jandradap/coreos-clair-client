# coreos-clair-client [![](https://images.microbadger.com/badges/version/jorgeandrada/coreos-clair-client:latest.svg)](https://microbadger.com/images/jorgeandrada/coreos-clair-client:latest "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/jorgeandrada/coreos-clair-client:latest.svg)](https://microbadger.com/images/jorgeandrada/coreos-clair-client:latest "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/jorgeandrada/coreos-clair-client:latest.svg)](https://microbadger.com/images/jorgeandrada/coreos-clair-client:latest "Get your own commit badge on microbadger.com")

Coreos Analyze local images: alpine Docker

<a href='https://ko-fi.com/A417UXC' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi2.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>


# Original repo:
[Original repo](https://github.com/coreos/clair/tree/master/contrib/analyze-local-images)

# Usage

If you are running Clair locally (ie. compiled or local Docker),
```
Usage: analyze-local-images [options] image-id

Options:
  -color string
    	Colorize the output (always, auto, never) (default "auto")
  -endpoint string
    	Address to Clair API (default "http://127.0.0.1:6060")
  -minimum-severity string
    	Minimum severity of vulnerabilities to show (Unknown, Negligible, Low, Medium, High, Critical, Defcon1) (default "Negligible")
  -my-address string
    	Address from the point of view of Clair (default "127.0.0.1")
```

```shell
docker run -i --rm --name coreos-clair-client \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
jorgeandrada/coreos-clair-client:latest \
analyze-local-images -color always \
-endpoint "http://IPSERVER:6060"  <Docker Image ID>
```

## Example
```shell
docker pull alpine:latest
docker run -i --rm --name coreos-clair-client \
-v /var/run/docker.sock:/var/run/docker.sock:ro \
jorgeandrada/coreos-clair-client:latest \
analyze-local-images -color always \
-endpoint "http://IPSERVER:6060" alpine:latest
```

## Server example
```
git clone https://github.com/jandradap/coreos-clair-client.git
cd coreos-clair-client/server-example/
docker-compose up -d
```

Or, If you run Clair remotely (ie. boot2docker),

```
analyze-local-images -endpoint "http://<CLAIR-IP-ADDRESS>:6060" -my-address "<MY-IP-ADDRESS>" <Docker Image ID>
```

Clair needs access to the image files. If you run Clair locally, this tool will store the files in the system's temporary folder and Clair will find them there. It means if Clair is running in Docker, the host's temporary folder must be mounted in the Clair's container. If you run Clair remotely, this tool will run a small HTTP server to let Clair downloading them. It listens on the port 9279 and allows a single host: Clair's IP address, extracted from the `-endpoint` parameter. The `my-address` parameters defines the IP address of the HTTP server that Clair will use to download the images. With boot2docker, these parameters would be `-endpoint "http://192.168.99.100:6060" -my-address "192.168.99.1"`.

As it runs an HTTP server and not an HTTP**S** one, be sure to **not** expose sensitive data and container images.
