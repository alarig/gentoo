# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS=cmake
inherit cmake-multilib

DESCRIPTION="High-performance messaging interface for distributed applications"
HOMEPAGE="https://nanomsg.org/"
SRC_URI="https://github.com/nanomsg/nanomsg/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/5.0.0"
KEYWORDS="amd64 ~arm ~arm64 ~hppa ~ppc ~x86"
IUSE="doc"

DEPEND="doc? ( dev-ruby/asciidoctor )"

multilib_src_prepare() {
	eapply_user
	# Old CPUs like HPPA fails test because of timeout
	sed -i -e 's/inproc_shutdown 5/inproc_shutdown 10/' \
		-e 's/ws_async_shutdown 5/ws_async_shutdown 10/' \
		-e 's/ipc_shutdown 30/ipc_shutdown 40/' -i CMakeLists.txt || die
}

multilib_src_configure() {
	local mycmakeargs=(
		-DNN_STATIC_LIB=OFF
	)
	if multilib_is_native_abi; then
		mycmakeargs+=(
			-DNN_ENABLE_DOC=$(usex doc ON OFF)
		)
	else
		mycmakeargs+=(
			-DNN_ENABLE_DOC=OFF
			-DNN_ENABLE_TOOLS=OFF
			-DNN_ENABLE-NANOCAT=OFF
		)
	fi
	cmake_src_configure
}
