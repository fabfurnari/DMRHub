FROM golang:1.24-bookworm AS build
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends nodejs build-essential npm
COPY . .
RUN make build

FROM scratch
COPY --from=build /app/bin/DMRHub /DMRHub

# # this pulls directly from the upstream image, which already has ca-certificates:
# COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# COPY DMRHub /
ENTRYPOINT ["/DMRHub"]
