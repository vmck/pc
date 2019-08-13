FROM vmck/vagrant-vmck

WORKDIR /test-pc
ADD . .

CMD ./run-test.sh
