# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=PEVANS
DIST_VERSION=0.12
inherit perl-module

DESCRIPTION="Configure-time utilities for using C headers"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"

RDEPEND="
	virtual/perl-ExtUtils-CBuilder
"
BDEPEND="
	${RDEPEND}
	>=dev-perl/Module-Build-0.400.400
	test? (
		virtual/perl-Test2-Suite
	)
"

src_test() {
	perl_rm_files t/99pod.t
	perl-module_src_test
}
