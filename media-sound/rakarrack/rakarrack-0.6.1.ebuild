# Copyright owners: Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# ebuild updated for funtoo

EAPI="5"

inherit autotools-utils

DESCRIPTION="A richly featured multi-effects processor emulating a uitar effects pedalboard"
HOMEPAGE="http://rakarrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/fltk
	x11-libs/libXpm
	>=media-libs/alsa-lib-0.9
	media-libs/libsamplerate
	media-libs/libsndfile
	>=media-sound/alsa-utils-0.9
	>=media-sound/jack-audio-connection-kit-0.100.0"
DEPEND="${RDEPEND}"

AUTOTOOLS_AUTORECONF="1"

src_prepare() {
	mv configure.in configure.ac
	eaclocal
	eautomake --add-missing
}
