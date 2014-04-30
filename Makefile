UPSTREAM_VERSION=1.1.11
PACKAGE_NAME=gearmand
DEB_VERSION=1
DESCRIPTION=Gearman provides a generic application framework to farm out work to other machines or processes that are better suited to do the work.
MAINTAINER=Jean-Sébastien Hedde <jeanseb@au-fil-du.net>

FILE=$(PACKAGE_NAME)_$(UPSTREAM_VERSION)-0ubuntu$(DEB_VERSION)_all.deb
REPOSITORY_DIR=/home/lafourchette/www/apt/lafourchette
REPOSITORY_HOST=lafourchette@dev7

clean:
	rm -rf *deb $(PACKAGE_NAME)-$(UPSTREAM_VERSION)/builddir

build: $(PACKAGE_NAME)-$(UPSTREAM_VERSION).tar.gz
	tar xzf $(PACKAGE_NAME)-$(UPSTREAM_VERSION).tar.gz
	cd $(PACKAGE_NAME)-$(UPSTREAM_VERSION) && \
    rm -rf builddir && \
    mkdir builddir && \
    ./configure --prefix=$$PWD/builddir/usr --exec-prefix=$$PWD/builddir/usr && \
    make && \
    make install
	fpm -a all -s dir -t deb \
    --description "$(DESCRIPTION)" \
    --maintainer "$(MAINTAINER)" \
    -n $(PACKAGE_NAME) -v $(UPSTREAM_VERSION)-0ubuntu$(DEB_VERSION) \
    -C $(PACKAGE_NAME)-$(UPSTREAM_VERSION)/builddir .

$(PACKAGE_NAME)-$(UPSTREAM_VERSION).tar.gz:
	wget https://launchpad.net/$(PACKAGE_NAME)/1.2/$(UPSTREAM_VERSION)/+download/$(PACKAGE_NAME)-$(UPSTREAM_VERSION).tar.gz

publish:
	scp $(FILE) $(REPOSITORY_HOST):$(REPOSITORY_DIR)/incoming
	ssh $(REPOSITORY_HOST) reprepro -Vb $(REPOSITORY_DIR) includedeb lucid $(REPOSITORY_DIR)/incoming/$(FILE)
