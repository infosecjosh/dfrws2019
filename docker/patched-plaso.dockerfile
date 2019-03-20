FROM log2timeline/plaso

MAINTAINER NIWC-LANT DFRWS Team

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
	python-elasticsearch \
	git

RUN git clone --single-branch --branch dfrws2019 https://github.com/infosecjosh/plaso /tmp/plaso
RUN cd /tmp/plaso && python setup.py install
