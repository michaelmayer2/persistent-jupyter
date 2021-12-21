FROM rstudio/r-session-complete:bionic-2021.09.1-372.pro1

RUN sed 's@security.ubuntu.com@ubuntu.ethz.ch@' -i /etc/apt/sources.list && sed 's@archive.ubuntu.com@ubuntu.ethz.ch@' -i /etc/apt/sources.list

RUN wget -q https://xpra.org/gpg.asc -O- | sudo apt-key add - && \
	cd /etc/apt/sources.list.d && \
	wget https://xpra.org/repos/bionic/xpra.list && \
	apt-get update && \
	apt-get install -y xpra xpra-html5 

RUN apt-get install gdebi-core && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
	gdebi -n google-chrome-stable_current_amd64.deb && \
	rm -f google-chrome-stable_current_amd64.deb

RUN useradd -m -s /bin/bash mm

COPY google.sh /usr/local/bin

RUN chmod +x /usr/local/bin/google.sh

CMD su - mm -c "xpra start --start=/usr/local/bin/google.sh --bind-tcp=0.0.0.0:10000 && while true ; do sleep 10; done" 
