FROM golang:1.6.4-onbuild

RUN apt-get update
RUN wget -c http://www.vips.ecs.soton.ac.uk/supported/current/vips-8.4.5.tar.gz
RUN tar xzvf vips-8.4.5.tar.gz
RUN dpkg --configure -a && \
	apt-get install pkg-config build-essential glib-2.0 libexif-dev libxml2-dev libxslt1-dev libfftw3-dev gettext libgtk2.0-dev python-dev liblcms2-dev liboil-dev libmagickwand-dev libopenexr-dev libcfitsio3-dev gobject-introspection flex bison \
	-y

RUN cd vips-8.4.5/ && \
	./configure --enable-debug=no --without-python --without-fftw \
		--without-libgf --without-little-cms --without-orc --without-pango --prefix=/usr && \
	make && make install
RUN echo "/usr/local/lib/" >> /etc/ld.so.conf.d/local.conf
RUN apt-get install libvips -y
