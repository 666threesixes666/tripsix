# Distributed under the terms of the GNU General Public License v2

EAPI=4
inherit cmake-utils

DESCRIPTION="A tiny RSS and Atom feed reader"
HOMEPAGE="http://bitbucket.org/skunkos/rssguard"
SRC_URI="https://bitbucket.org/skunkos/${PN}/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="dbus"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtwebkit:4
	dev-qt/qtxmlpatterns:4
	x11-themes/hicolor-icon-theme
	dbus? ( dev-qt/qtdbus:4 )"
RDEPEND="${DEPEND}"

#S="${WORKDIR}/rss-guard"
#DOCS=( resources/text/AUTHORS resources/text/CHANGELOG )

#src_prepare() {
#	epatch_user
#}
