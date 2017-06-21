# Fake S3 SSL

[![](https://images.microbadger.com/badges/image/technekes/fake-s3-ssl.svg)](https://microbadger.com/images/technekes/fake-s3-ssl "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/technekes/fake-s3-ssl.svg)](https://microbadger.com/images/technekes/fake-s3-ssl "Get your own version badge on microbadger.com")

Runs a [`fake-s3`](https://github.com/jubos/fake-s3) in an Alpine based docker image with a self-signed certificate.

## Versions

Currently avaliable versions (by tag).

* `latest` - fakes3 version `1.2.0`

## Usage

Run a fake-s3 server independently.

```sh
docker run \
  --rm \
  -p 443:443 \
  technekes/fake-s3-ssl
```

For usage within a `docker-compose` configuration create a link to your `s3` service with an alias to the bucket you are targeting (`my-bucket` in the example below).

```yml
version: "2"
services:
  web:
    build: .
    links:
      - s3:my-bucket.s3.amazonaws.com

  s3:
    image: technekes/fake-s3-ssl
```

**Note** - At this time the `fakes3` gem [does not support self signed certificates](https://github.com/jubos/fake-s3/issues/144). In order to use this image you will need to disable "SSL Verify" within your AWS SDK library of choice. For example with the Ruby SDK V2.

```rb
Aws::S3::Client.new(ssl_verify_peer: ENV['CI'] != 'true')
```

## Credit

The heart of this image is the `entrypoint.sh` which was largely copied from [nathankot/fake-s3-docker](https://github.com/nathankot/fake-s3-docker/blob/master/entrypoint.sh)

## License

Apache License. See [LICENSE](LICENSE) for details.
