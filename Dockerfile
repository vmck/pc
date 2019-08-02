FROM vmck/vagrant-vmck

ADD . /src
WORKDIR /src

CMD ./run-test.sh
