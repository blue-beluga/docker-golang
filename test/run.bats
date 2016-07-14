#!/usr/bin/env bats

setup() {
  docker history "$REGISTRY/$REPOSITORY:$TAG" >/dev/null 2>&1
  export IMG="$REGISTRY/$REPOSITORY:$TAG"
}

@test "the image has a disk size under 10MB" {
    run docker images $IMG
    echo 'status:' $status
    echo 'output:' $output
    size="$(echo ${lines[1]} | awk -F '   *' '{ print int($5) }')"
    echo 'size:' $size
    [ "$status" -eq 0 ]
    [ $size -lt 10 ]
}

@test "the go version is correct" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "go version | grep $GOLANG_VERSION"
  [ $status -eq 0 ]
}

@test "the image can download go code" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "go get github.com/hoisie/mustache"
  [ $status -eq 0 ]
}

@test "the image can build go code" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "go get github.com/deis/example-go && go build github.com/deis/example-go"
  [ $status -eq 0 ]
}

@test "the image can test go code" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "go get github.com/hoisie/mustache && go test github.com/hoisie/mustache"
  [ $status -eq 0 ]
}

@test "the timezone is set to UTC" {
  run docker run --rm $IMG date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "that /var/cache/apk is empty" {
  run docker run --rm $IMG sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
}

@test "that the root password is disabled" {
  run docker run --user nobody $IMG su
  [ $status -eq 1 ]
}
