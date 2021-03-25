# Create the cosmovisor source image
FROM golang:1.15-buster as build
ENV GO111MODULE=on
RUN go get github.com/cosmos/cosmos-sdk/cosmovisor/cmd/cosmovisor

# Dump the 2G go get from above for publishing. Final image here is ~30M
FROM gcr.io/distroless/base-debian10 as visor
COPY --from=build /go/bin/cosmovisor /usr/bin/cosmovisor
