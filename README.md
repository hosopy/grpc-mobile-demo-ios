# Demo iOS application using gRPC

## Setup

```sh
$ git clone https://github.com/hosopy/grpc-mobile-demo-ios
$ cd grpc-mobile-demo-ios
$ bundle install
$ bundle exec pod install
```

This demo application connects to `localhost:50051` without TLS.
You can run the demo server([hosopy/grpc-mobile-demo-server](https://github.com/hosopy/grpc-mobile-demo-server)) using docker.

```sh
$ docker run -i -t -p 50051:50051 hosopy/grpc-mobile-demo-server
```

