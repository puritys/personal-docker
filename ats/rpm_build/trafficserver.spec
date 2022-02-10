#
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
%define _bindir /usr/local/bin
%define _libdir /usr/local/libexec
# I had to disable this on RHEL7, because libunwind is not properly built for -fPIE it seems
%if %{?fedora}0 > 0  || %{?rhel}0 >= 80
%define _hardened_build 1
%endif

Summary:	Apache Traffic Server, a reverse, forward and transparent HTTP proxy cache
Name:		trafficserver
Version:	7.1.12
Release:	1%{?dist}
License:	Apache Software License 2.0 (AL2)
Group:		System Environment/Daemons
URL:		https://trafficserver.apache.org/

Source:	        %{name}-%{version}.tar.bz2

Requires:	expat hwloc openssl pcre tcl zlib xz libcurl ncurses pkgconfig
Requires:	libcap


%if %{?fedora}0 > 0  || %{?rhel}0 >= 70
Requires:	systemd
Requires(postun): systemd
%else
Requires:	initscripts
%endif

%description
Apache Traffic Server is an OpenSource HTTP / HTTPS / HTTP/2 / QUIC reverse,
forward and transparent proxy and cache.


%prep

%setup -q

%build

%install
make DESTDIR=%{buildroot} install
mkdir -p /root/rpmbuild/BUILDROOT/var/log/trafficserver
mkdir -p /root/rpmbuild/BUILDROOT/var/cache/trafficserver

%if %{?fedora}0 > 0 || %{?rhel}0 >= 70
mkdir -p %{buildroot}/lib/systemd/system
cp rc/trafficserver.service %{buildroot}/lib/systemd/system
%else
mkdir -p %{buildroot}/etc/init.d
mv %{buildroot}%{_bindir}/trafficserver %{buildroot}/etc/init.d
%endif

# Remove libtool archives and static libs
find %{buildroot} -type f -name "*.la" -delete
find %{buildroot} -type f -name "*.a" -delete
find %{buildroot} -type f -name "*.pod" -delete
find %{buildroot} -type f -name "*.in" -delete
find %{buildroot} -type f -name ".packlist" -delete


mkdir -p %{buildroot}/run/trafficserver

#mkdir -p %{buildroot}%{_datadir}/pkgconfig
#mv %{buildroot}%{_libdir}/trafficserver/pkgconfig/trafficserver.pc %{buildroot}%{_datadir}/pkgconfig

%post
/sbin/ldconfig
%if %{?fedora}0 > 0 || %{?rhel}0 >= 70
%systemd_post trafficserver.service
%endif

# These UID/GIDs are retained from the upstream Fedora .spec, not sure if there's a registry for these?
%pre
getent group ats >/dev/null || groupadd -r ats -g 176 &>/dev/null
getent passwd ats >/dev/null || useradd -r -u 176 -g ats -d / -s /sbin/nologin -c "Apache Traffic Server" ats &>/dev/null

%preun
%if %{?fedora}0 > 0 || %{?rhel}0 >= 70
%systemd_preun trafficserver.service
%endif

%postun
/sbin/ldconfig

%if %{?fedora}0 > 0 || %{?rhel}0 >= 70
%systemd_postun_with_restart trafficserver.service
%endif

%files
%defattr(-, root, root, -)
%{!?_licensedir:%global license %%doc}
%license LICENSE
%doc README CHANGELOG* NOTICE STATUS
#%attr(0755, ats, ats) %dir /etc/trafficserver
#%config(noreplace) /etc/trafficserver/*
%{_bindir}/traffic*
%{_bindir}/tspush
%{_bindir}/tsxs
%dir %{_libdir}/trafficserver
%dir /usr/local/var/log/trafficserver
/usr/local/etc/trafficserver/*
/usr/local/libexec/trafficserver/*.so
/usr/local/include/*
/usr/local/lib/*
#%dir %{_libdir}/trafficserver/plugins
#%{_libdir}/trafficserver/plugins/*.so

%if %{?fedora}0 > 0 || %{?rhel}0 >= 70
/lib/systemd/system/trafficserver.service
%else
%config(noreplace) /etc/init.d/trafficserver
%endif

%attr(0755, ats, ats) %dir /var/log/trafficserver
%attr(0755, ats, ats) %dir /run/trafficserver
%attr(0755, ats, ats) %dir /var/cache/trafficserver
#%attr(0755, ats, ats) %dir /var/trafficserver

