---
title: Internet Media Scale Challenges
abbrev: MediaScale
docname: draft-jholland-mops-media-scale-latest
date: 2019-05-22
category: inf

ipr: trust200902
area: Ops
workgroup: Mops
keyword: Internet-Draft

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
 -
    ins: J. Holland
    name: Jake Holland
    org: Akamai Technologies, Inc.
    street: 150 Broadway
    city: Cambridge, MA 02144
    country: United States of America
    email: jakeholland.net@gmail.com

normative:
  RFC2119
  RFC8174

informative:
  VNI:
    target: https://www.cisco.com/c/en/us/solutions/collateral/service-provider/visual-networking-index-vni/white-paper-c11-741490.html
    title: Cisco Visual Networking Index: Forecast and Trends, 2017–2022 White Paper
    author:
      -
        org: Cisco
    seriesinfo:
      DocumenteID: 1551296909190103
    date: 2019-02-27

--- abstract

This document describes the current and projected challenges of
scale in meeting the demand for delivery of media, particularly
video.

--- middle

#Introduction {#intro}

As the internet has grown, video has become an increasingly large
share of the traffic delivered to end users.  Current estimates
put the proportion at 75%, expected to grow to 82% by 2022 {{VNI}}.

Most video delivery interacts with the transport layer in a few
ways that don't match especially well with the transport model for
a bandwidth-seeking connection.

--- back

#Some Title for an appendix section (auto-prefixes with Appendix A)

Text of the appendix A section here.

