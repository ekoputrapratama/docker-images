FROM archlinux/base:latest

ENV EDITOR nano

RUN pacman-key --init && \
  pacman -Sy --noconfirm archlinux-keyring && \
  pacman -Syu --noconfirm base-devel git boost aurpublish sudo po4a python nano && \  
  pacman-db-upgrade && \
  update-ca-trust && \
  pacman -Scc --noconfirm

RUN useradd -m arch \
	&& echo "arch ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER arch	
WORKDIR /home/arch

# installing pacaur and it's dependencies
RUN git clone https://aur.archlinux.org/auracle-git.git
RUN cd auracle-git && makepkg -si --noconfirm

RUN git clone https://aur.archlinux.org/pacaur.git
RUN cd pacaur && makepkg -si --noconfirm

# clean pacaur and it's dependencies sources
RUN rm -r pacaur && rm -r auracle-git

# installing dependencies for building debian package
RUN gpg --recv-keys 0x8C004C2F93481F6B
RUN pacaur -Sy --noconfirm --noedit --needed \
    equivs debootstrap debhelper debianutils devscripts dpkg

ADD enable-cache disable-cache /usr/bin/

VOLUME ["/tmp"]
VOLUME ["/projects"]



