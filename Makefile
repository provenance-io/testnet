NETS = testnet-beta pio-testnet-1

all:

docker-build-visor:
	docker build -t provenanceio/cosmovisor -f docker/cosmovisor/Dockerfile .

docker-build-nodes:
	for i in $(NETS); do \
		docker build -t provenanceio/node-archive:$$i --build-arg CHAIN_ID=$$i -f docker/archive/Dockerfile .; \
		docker build -t provenanceio/node-visor:$$i --build-arg CHAIN_ID=$$i -f docker/visor/Dockerfile .; \
	done

docker-push-visor:
	docker push provenanceio/cosmovisor

docker-push-nodes:
	for i in $(NETS); do \
		docker push provenanceio/node-archive:$$i; \
		docker push provenanceio/node-visor:$$i; \
	done
