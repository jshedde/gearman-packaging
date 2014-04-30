gearmand-packaging
=================

Packaging gearmand

# Usage :

```
make build
```

then

```
sudo dpkg -i gearmand_1.1.11-0ubuntu1_all.deb
```

# Requirements :

[fpm](https://github.com/jordansissel/fpm) must be installed

```
sudo gem install fpm
sudo apt-get -y install libboost-dev libboost-program-options-dev gperf libevent-dev uuid-dev libcloog-ppl0
```


