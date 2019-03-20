FROM log2timeline/plaso

MAINTAINER SPAWAR Systems Center ATLANTIC

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
	patch \
	python-elasticsearch

