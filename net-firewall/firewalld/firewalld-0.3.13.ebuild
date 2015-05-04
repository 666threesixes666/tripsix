# Copyright owners: Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit autotools eutils user gnome2-utils python-r1 multilib bash-completion-r1
DESCRIPTION="A firewall daemon with D-BUS interface providing a dynamic firewall"
HOMEPAGE="http://fedorahosted.org/firewalld"
SRC_URI="https://fedorahosted.org/released/firewalld/${P}.tar.bz2"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="-gui"
RDEPEND="${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	>=dev-python/python-slip-0.2.7[dbus,${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	net-firewall/ebtables
	net-firewall/iptables[ipv6]
	|| ( >=sys-apps/openrc-0.11.5 )
	gui? ( x11-libs/gtk+:3 )"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	>=dev-util/intltool-0.35
	sys-devel/gettext"
pkg_setup() {
	enewgroup plugdev
}
src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch
	epatch "${FILESDIR}/${P}-py3k-compat.patch"
	epatch_user
	eautoreconf
}
src_configure() {
	python_setup
	econf \
		--disable-systemd \
		--with-bashcompletiondir="$(get_bashcompdir)"
}
src_install() {
	emake -C config DESTDIR="${D}" install
	emake -C po DESTDIR="${D}" install
	emake -C shell-completion DESTDIR="${D}" install

	install_python() {
		emake -C src DESTDIR="${D}" pythondir="$(python_get_sitedir)" install
		python_optimize
	}
	python_foreach_impl install_python
	python_replicate_script "${D}"/usr/bin/firewall-{offline-cmd,cmd,applet,config}
	python_replicate_script "${D}/usr/sbin/firewalld"
	rm -f "${D}/etc/rc.d/init.d/firewalld"
	rm -f "${D}/etc/sysconfig/firewalld"
	rm -rf "${D}/etc/rc.d/"
	rm -rf "${D}/etc/sysconfig/"
	if ! use gui; then
		rm -f "${D}/usr/bin/firewall-applet"
		rm -f "${D}/usr/bin/firewall-config"
		rm -rf "${D}/usr/share/icons"
		rm -rf "${D}/usr/share/applications"
	fi
	newinitd "${FILESDIR}"/firewalld.init firewalld
	# Allow users in plugdev group to modify system connections
	insinto /usr/share/polkit-1/rules.d/
	doins "${FILESDIR}/org.freedesktop.firewalld.rules"
}
pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}
pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
