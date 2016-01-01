rule/debian/setup:
	   sudo apt-get install \
	gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential \
   chrpath libsdl1.2-dev xterm libattr1-dev binutils-gold quilt cpio libwayland-dev ccache \
	curl

rule/git/init:
	  git config --global user.email "${email}"
	  git config --global user.name "${name}"
