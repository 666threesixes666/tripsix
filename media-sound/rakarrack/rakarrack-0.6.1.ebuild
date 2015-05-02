# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="Basic rack of 10 effects for guitar with presets, banks and MIDI control"
HOMEPAGE="http://rakarrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/rakarrack/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="x11-libs/fltk
	x11-libs/libXpm
	>=media-libs/alsa-lib-0.9
	>=media-sound/alsa-utils-0.9
	>=media-sound/jack-audio-connection-kit-0.100.0"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install
	insinto /usr/share/doc/"${PN}"
	doins TODO
}
