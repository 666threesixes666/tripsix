# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_SRC="http://www.linuxfromscratch.org/blfs/downloads/${PV}"
BOOTSCRIPT_PV="20150222"

DESCRIPTION="BLFS documents building a Linux system entirely from source"
HOMEPAGE="http://www.linuxfromscratch.org/blfs"
SRC_URI="${MY_SRC}/blfs-book-${PV}-html.tar.bz2
		htmlsingle? ( ${MY_SRC}/BLFS-BOOK-${PV}-nochunks.html )"

LICENSE="CC-BY-NC-SA-2.5 MIT"
SLOT="0"
KEYWORDS="*"
IUSE="htmlsingle"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack blfs-book-${PV}-html.tar.bz2
	use htmlsingle && cp "${DISTDIR}"/BLFS-BOOK-${PV}-nochunks.html "${S}"
}

src_install() {
	dodoc -r *
	docompress -x /usr/share/doc/${PF}
}
