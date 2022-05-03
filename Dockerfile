FROM rstudio/r-session-complete:bionic-2021.09.1-372.pro1

RUN sed 's@security.ubuntu.com@ubuntu.ethz.ch@' -i /etc/apt/sources.list && sed 's@archive.ubuntu.com@ubuntu.ethz.ch@' -i /etc/apt/sources.list

RUN wget -q https://xpra.org/gpg.asc -O- | sudo apt-key add - && \
	cd /etc/apt/sources.list.d && \
	wget https://xpra.org/repos/bionic/xpra.list && \
	apt-get update && \
	apt-get install -y xpra xpra-html5 

RUN apt-get install wget gdebi-core
RUN wget --no-verbose -O google-chrome-stable_current_amd64.deb "http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_90.0.4430.72-1_amd64.deb" && \
	gdebi -n google-chrome-stable_current_amd64.deb && \
	rm -f google-chrome-stable_current_amd64.deb

RUN useradd -m -s /bin/bash mm

COPY google.sh /usr/local/bin
COPY mm.tgz /tmp

RUN chmod +x /usr/local/bin/google.sh
RUN cd /tmp && tar xfz mm.tgz && rm -f mm.tgz  
RUN chown -R mm /tmp/mm

CMD su - mm -c "export XDG_DATA_HOME=/tmp/\$USER/.local/share && \
mkdir -p \$XDG_DATA_HOME && \
export XDG_CONFIG_HOME=/tmp/\$USER/.config &&\
mkdir -p \$XDG_CONFIG_HOME && \
export XDG_STATE_HOME=/tmp/\$USER/.local/state && \
mkdir -p \$XDG_STATE_HOME && \
export XDG_RUNTIME_DIR=/tmp/\$USER && \
rm -rf /tmp/\$USER && mkdir -p /tmp/\$USER && xpra start --start=/usr/local/bin/google.sh --bind-tcp=0.0.0.0:10000 && while true ; do sleep 10; done" 
