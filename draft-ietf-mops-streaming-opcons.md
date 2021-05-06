---
title: Operational Considerations for Streaming Media
abbrev: Media Streaming Ops
docname: draft-ietf-mops-streaming-opcons-latest
date:
category: info

ipr: trust200902
area: OPS
workgroup: MOPS
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
 -
    ins: A. Begen
    name: Ali Begen
    org: Networked Media
    country: Turkey
    email: ali.begen@networked.media
 -
    ins: S. Dawkins
    name: Spencer Dawkins
    org: Tencent America LLC
    country: United States of America
    email: spencerdawkins.ietf@gmail.com

informative:
  CVNI:
    target: https://www.cisco.com/c/en/us/solutions/collateral/service-provider/visual-networking-index-vni/white-paper-c11-741490.html
    title: "Cisco Visual Networking Index: Forecast and Trends, 2017-2022 White Paper"
    author:
      - 
        org: "Cisco Systems, Inc."
    date: 2019-02-27
  PCC:
    target: https://ieeexplore.ieee.org/document/8571288
    title: "Emerging MPEG Standards for Point Cloud Compression"
    author:
      -
        name: Sebastian Schwarz et al.
    date: Mar. 2019
  NOSSDAV12:
    target: https://dl.acm.org/doi/10.1145/2229087.2229092
    title: "What Happens When HTTP Adaptive Streaming Players Compete for Bandwidth?"
    author:
      -
        name: Saamer Akhshabi et al.
    date: June 2012  
  DASH:
    title: "Information technology -- Dynamic adaptive streaming over HTTP (DASH) -- Part 1: Media presentation description and segment formats"
    seriesinfo:
      "ISO/IEC": 23009-1:2019
    date: 2019
  MSOD:
    title: "Media Services On Demand: Encoder Best Practices"
    author:
      - 
        org: "Akamai Technologies, Inc."
    target: https://learn.akamai.com/en-us/webhelp/media-services-on-demand/media-services-on-demand-encoder-best-practices/GUID-7448548A-A96F-4D03-9E2D-4A4BBB6EC071.html
    date: 2019
  Mishra:
    title: "An update on Streaming Video Alliance"
    author:
      - ins: S. Mishra
      - ins: J. Thibeault
    target: https://datatracker.ietf.org/meeting/interim-2020-mops-01/materials/slides-interim-2020-mops-01-sessa-april-15-2020-mops-interim-an-update-on-streaming-video-alliance
    date: 2020
  Labovitz:
    title: "Network traffic insights in the time of COVID-19: April 9 update"
    author:
      - ins: C. Labovitz
      - org: Nokia Deepfield
    target: https://www.nokia.com/blog/network-traffic-insights-time-covid-19-april-9-update/
    date: Apr 9, 2020
  LabovitzDDoS:
    title: "Why the game industry is still vulnerable to DDoS attacks"
    author:
      - ins: D. Takahashi
      - org: Venture Beat
    target:  https://venturebeat.com/2018/05/13/why-the-game-industry-is-still-vulnerable-to-distributed-denial-of-service-attacks/
    date: May 13, 2018

  IABcovid:
    title: Report from the IAB COVID-19 Network Impacts Workshop 2020
    author:
      - 
        name: Jari Arkko
        ins: J. Arkko
      - 
        name:  Stephen Farrel
        ins:  S. Farrel
      - 
        name: Mirja Kühlewind
        ins: M. Kühlewind
      - 
        name:  Colin Perkins
        ins:  C. Perkins
    target: https://datatracker.ietf.org/doc/draft-iab-covid19-workshop/
    date: November 2020

  Jacobson-Karels:
    title: Congestion Avoidance and Control
    target: https://ee.lbl.gov/papers/congavoid.pdf
    date: November 1988
    author:
      - 
        name: Van Jacobson
        ins: V. Jacobson
      - 
        name: Mike Karels
        ins: M. Karels

  COPA:
    title: "Copa: Practical Delay-Based Congestion Control for the Internet"
    target: https://web.mit.edu/copa/
    date: 2018
    author:
      - 
        name: Venkat Arun
        ins: V. Arun
      - 
        name:  Hari Balakrishnan
        ins:  H. Balakrishnan

  Port443:
    title: "Service Name and Transport Protocol Port Number Registry"
    target: https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.txt
    date: 2021-04-29

  CDiD:
    title: "(A call for) Congestion Defense in Depth"
    target: https://datatracker.ietf.org/meeting/105/materials/slides-105-tsvarea-congestion-defense-in-depth-00
    date: July 2019
    author:
      - 
        name: Christian Huitema
        ins: C. Huitema
      - 
        name:  Brian Trammell
        ins:  B. Trammell

  tsvarea-105:
    title: "TSVAREA Minutes - IETF 105"
    target: https://datatracker.ietf.org/meeting/105/materials/minutes-105-tsvarea-00
    date: 2019

  I-D.cardwell-iccrg-bbr-congestion-control:
  I-D.ietf-quic-transport:
  I-D.ietf-quic-recovery:
  I-D.ietf-quic-http:

  RFC0793:
  RFC2001:
  RFC2309:
  RFC3168:
  RFC3550:
  RFC5594:
  RFC5762:
  RFC6190:
  RFC8033:
  RFC8216:
  RFC6817:
  RFC8622:
  RFC7234:
  RFC8083:
  RFC8084:
  RFC6582:
  RFC8312:

--- abstract

This document provides an overview of operational networking issues
that pertain to quality of experience in delivery of video and other
high-bitrate media over the internet.

--- middle

# Introduction {#intro}

As the internet has grown, an increasingly large share of the traffic
delivered to end users has become video.  Estimates
put the total share of internet video traffic at 75% in 2019, expected
to grow to 82% by 2022.  What's more, this estimate projects the
gross volume of video traffic will more than double during this time,
based on a compound annual growth rate continuing at 34% (from Appendix
D of {{CVNI}}).

In many contexts, video traffic can be handled transparently as
generic application-level traffic.  However, as the volume of
video traffic continues to grow, it's becoming increasingly
important to consider the effects of network design decisions
on application-level performance, with considerations for
the impact on video delivery.

This document aims to provide a taxonomy of networking issues as
they relate to quality of experience in internet video delivery.
The focus is on capturing characteristics of video delivery that
have surprised network designers or transport experts without
specific video expertise, since these highlight key differences
between common assumptions in existing networking documents and
observations of video delivery issues in practice.

Making specific recommendations for mitigating these issues
is out of scope, though some existing mitigations are mentioned
in passing.  The intent is to provide a point of reference for
future solution proposals to use in describing how new
technologies address or avoid these existing observed problems.

## Notes for Contributors and Reviewers

Note to RFC Editor: Please remove this section and its subsections
before publication.

This section is to provide references to make it easier to review the
development and discussion on the draft so far.

### Venues for Contribution and Discussion {#venue}

This document is in the Github repository at:

https://github.com/ietf-wg-mops/draft-ietf-mops-streaming-opcons

Readers are welcome to open issues and send pull requests for this document. 

Substantial discussion of this document should take place on the MOPS working group mailing list (mops@ietf.org).

 * Join: https://www.ietf.org/mailman/listinfo/mops
 * Search: https://mailarchive.ietf.org/arch/browse/mops/

### Template for Contributions
 
Contributions are solicited regarding issues and considerations
that have an impact on media streaming operations.
 
Please note that contributions may be merged and substantially
edited, and as a reminder, please carefully consider the Note Well
before contributing: https://datatracker.ietf.org/submit/note-well/
 
Contributions can be emailed to mops@ietf.org, submitted as issues
to the issue tracker of the repository in {{venue}}, or emailed to the
document authors at draft-ietf-mops-streaming-opcons@ietf.org.
 
Contributors describing an issue not yet addressed in the draft are
requested to provide the following information, where applicable:
 
 * a suggested title or name for the issue
 * a long-term pointer to the best reference describing the issue
 * a short description of the nature of the issue and its impact on media quality of service, including:
   * where in the network this issue has root causes
   * who can detect this issue when it occurs
 * an overview of the issue's known prevalence in practice.  pointers to write-ups of high-profile incidents are a plus.
 * a list of known mitigation techniques, with (for each known mitigation):
   * a name for the mitigation technique
   * a long-term pointer to the best reference describing it
   * a short description of the technique:
     * what it does
     * where in the network it operates
     * an overview of the tradeoffs involved--how and why it's helpful, what it costs.
   * supplemental information about the technique's deployment prevalence and status

### History of Public Discussion

Presentations:

 * IETF 105 BOF:\\
   https://www.youtube.com/watch?v=4G3YBVmn9Eo&t=47m21s

 * IETF 106 meeting:\\
   https://www.youtube.com/watch?v=4_k340xT2jM&t=7m23s

 * MOPS Interim Meeting 2020-04-15:\\
   https://www.youtube.com/watch?v=QExiajdC0IY&t=10m25s

 * IETF 108 meeting:\\
   https://www.youtube.com/watch?v=ZaRsk0y3O9k&t=2m48s

 * MOPS 2020-10-30 Interim meeting:\\
   https://www.youtube.com/watch?v=vDZKspv4LXw&t=17m15s

#Evolution of Transport Protocols and Transport Protocol Behaviors

Because networking resources are shared between users, a good place to start our discussion is how contention between users, and mechanisms to resolve that contention in ways that are "fair" between users, impact streaming media users. These topics are closely tied to the usage of transport protocols and transport protocol behaviors. 

For most of the history of the Internet, the dominant transport protocols in use have been UDP and TCP, and they have each had relatively consistent behaviors, although those behaviors have changed over time. 

## UDP and UDP Protocol Behaviors {#udp-behavior}

For most of the history of the Internet, we have trusted UDP-based applications to limit their impact on other users. One of the strategies used was to use UDP for simple query-response application protocols, such as DNS, which is often used to send a single-packet request to look up the IP address for a DNS name, and return a single-packet response containing the IP address. Although it is possible to saturate a path between a DNS client and DNS server with DNS requests, in practice, that was rare enough that DNS included few mechanisms to resolve contention between DNS users and other users (whether they are also using DNS, or using other application protocols. 

In recent times, the usage of UDP-based applications that were not simple query-response protocols has grown substantially, and since UDP does not provide any feedback mechanism to senders to help limit impacts on other users, application-level protocols such as RTP {{RFC3550}} have been responsible for the decisions that TCP-based applications have delegated to TCP - what to send, how much to send, and when to send it. So, the way these UDP-based applications interact with other users has changed.

It's also worth pointing out that because UDP has no transport-layer feedback mechanisms, UDP-based applications that expect to send and receive substantial amounts of information must provide their own feedback mechanisms. RTP replies on RTCP Sender and Receiver Reports {{RFC3550}} as its own feedback mechanism, and even includes Circuit Breakers for Unicast RTP Sessions {{RFC8083}} for situations when normal RTP congestion control has not been able to react sufficiently to RTP flows sending at rates that result in sustained packet loss. 

The notion of "Circuit Breakers" has also been applied to other UDP applications, such as tunneling packets that are potentially not congestion-controlled over UDP, in {{RFC8084}}.

## TCP and TCP Protocol Behaviors {#tcp-behavior}

For most of the history of the Internet, we have trusted the TCP protocol to limit the impact of applications that sent a significant number of packets, in either or both directions, on other users. Although early versions of TCP were not particularly good at limiting this impact {{RFC0793}}, the addition of Slow Start and Congestion Avoidance, as described in {{RFC2001}}, were critical in allowing TCP-based applications to "use as much bandwidth as possible, but to avoid using more bandwidth than was possible". Although dozens of RFCs have been written refining TCP decisions about what to send, how much to send, and how when to send it, since 1988 {{Jacobson-Karels}} the signals available for TCP senders remained unchanged - end-to-end acknowledgments for packets that were successfully sent and received, and packet timeouts for packets that were not. 

The success of the largely TCP-based Internet is evidence that the mechanisms used to achieve equilibrium quickly, at a point where TCP senders do not interfere with other TCP senders for sustained periods of time, have been largely successful, even if the specific mechanisms used to reach equilibrium have change over time. Because TCP provides a common tool to avoid contention, new TCP-based applications (for example, HTTP) have had the same transport behavior as older TCP-based applications (for example, FTP). 

In recent times, the TCP goal of probing for available bandwidth, and "backing off" when a network path is saturated, has been supplanted by the goal of avoiding growing queues along network paths, which prevent TCP senders from reacting quickly when a network path is saturated. Congestion control mechanisms such as COPA {{COPA}} and BBR {{I-D.cardwell-iccrg-bbr-congestion-control}} make these decisions based on measured path delays, assuming that if the measured path delay is increasing, the sender is injecting packets onto the network path faster than the receiver can accept them, so the sender should adjust its sending rate accordingly. 

Although TCP protocol behavior has changed over time, the common practice of implementing TCP as part of an operating system kernel has acted to limit how quickly TCP behavior can change, even with the widespread use of automated operating system update installation on many end-user systems, so that streaming media providers could have a reasonable expectation that they could understand TCP transport protocol behaviors, and that those behaviors would remain relatively stable in the short term. 

## The QUIC Protocol and QUIC Protocol Behavior

The QUIC protocol {{I-D.ietf-quic-transport}}, developed from a proprietary protocol into an IETF standards-track protocol {{I-D.ietf-quic-transport}}, turns many of the statements made in {{udp-behavior}} and {{tcp-behavior}} on their heads. 

The standardized QUIC protocol is used to carry HTTP traffic, but instead of being TCP-based, HTTP/3 {{I-D.ietf-quic-http}} is encapsulated in QUIC, which is then encapsulated in UDP, so streaming operators (and network operators) will see traffic that looks like HTTP, but is carried over UDP (specifically, using UDP port 443 {{Port443}}). Network operators may already be blocking UDP traffic on this port, since HTTP over TLS/SSL has used TCP, not UDP. Even if UDP traffic using this port is not blocked, traffic using this port may be severely rate-limited, since HTTP/3 over QUIC has the potential to send much more traffic over UDP than the network operator expects. 

As noted elsewhere in this document, the QUIC protocol encrypts almost all of its transport parameters, and all of its payload, so any intermediaries that network operators may be using to perform analytics or even participate in current HTTP conversations will not work for HTTP/3 without making changes to their networks.

As noted in {{tcp-behavior}}, there is increasing interest in transport protocol behaviors that responds to delay measurements, instead of responding to packet loss. These behaviors may deliver improved user experience, but in some cases have not responded to sustained packet loss, which exhausts available buffers along the end-to-end path that may affect other users sharing that path. The standardized QUIC protocol includes a congestion-control mechanism {{I-D.ietf-quic-recovery}} that is loss-based, and is intended to have roughly the behavior of TCP NewReno {{RFC6582}}, but the signals QUIC provides for congestion control are intended to be generic, and a sender can unilaterally chose a different algorithm to use, which might be loss-based, like CUBIC {{RFC8312}}, a delay-based congestion controller like COPA or BBR, or something completely different. 

We do have experience with deploying new congestion controllers without melting the Internet (CUBIC is one example), but the point mentioned in {{tcp-behavior}} about TCP being implemented in operating system kernels is also different with QUIC. Although QUIC can be implemented in operating system kernels, one of the design goals when this work was chartered was "QUIC is expected to support rapid, distributed development and testing of features", and to meet this expectation, many implementers have chosen to implement QUIC in user space, outside the operating system kernel, and to even distribute QUIC with applications.

The decision to deploy a new version of QUIC is relatively uncontrolled, compared to other widely used transport protocols, and "a new version of QUIC" can include "a new congestion controller", so QUIC protocol behavior can change quickly, without much notice. At IETF 105, Christian Huitema and Brian Trammell presented a talk on "Congestion Defense in Depth" {{CDiD}}, that explored potential concerns about new QUIC congestion controllers being broadly deployed without the testing and instrumentation that current major content providers routinely include. The sense of the room at IETF 105 was that the current major content providers understood what is at stake when they deploy new congestion controllers, but this presentation, and the related discussion in TSVAREA minutes from IETF 105 ({{tsvarea-105}}, are still worth a look from new and rapidly growing content providers. 

#Bandwidth Provisioning

##Scaling Requirements for Media Delivery {#scaling}

###Video Bitrates

Video bitrate selection depends on many variables.  Different
providers give different guidelines, but an equation that
approximately matches the bandwidth requirement estimates
from several video providers is given in {{MSOD}}:

~~~
Kbps = (HEIGHT * WIDTH * FRAME_RATE) / (MOTION_FACTOR * 1024)
~~~

Height and width are in pixels, frame rate is in frames per second, and
the motion factor is a value that ranges from 20 for a low-motion talking
heads video to 7 for sports, and content with a lot of screen changes.

The motion factor captures the variability in bitrate due to the amount
and frequency of high-detail motion, which generally influences the
compressability of the content.

The exact bitrate required for a particular video also depends on a
number of specifics about the codec used and how the codec-specific
tuning parameters are matched to the content, but this equation provides
a rough estimate that approximates the usual bitrate characteristics using
the most common codecs and settings for production traffic.

Here are a few common resolutions used for video content, with their
typical and peak per-user bandwidth requirements for 60 frames per
second (FPS):

| Name | Width x Height | Typical | Peak
| -----+----------------+-------------------------------
| DVD |  720 x 480 | 1.3 Mbps | 3 Mbps
| 720p (1K) | 1280 x 720 | 3.6 Mbps | 5 Mbps
| 1080p (2K) | 1920 x 1080 | 8.1 Mbps | 18 Mbps
| 2160p (4k) | 3840 x 2160 | 32 Mbps | 70 Mbps

###Virtual Reality Bitrates

Even the basic virtual reality (360-degree) videos (that allow users to look around freely, referred to as three degrees of freedom - 3DoF) require substantially larger bitrates when they are captured and encoded as such videos require multiple fields of view of the scene. The typical multiplication factor is 8 to 10. Yet, due to smart delivery methods such as viewport-based or tiled-based streaming, we do not need to send the whole scene to the user. Instead, the user needs only the portion corresponding to its viewpoint at any given time. 

In more immersive applications, where basic user movement (3DoF+) or full user movement (6DoF) is allowed, the required bitrate grows even further. In this case, the immersive content is typically referred to as volumetric media. One way to represent the volumetric media is to use point clouds, where streaming a single object may easily require a bitrate of 30 Mbps or higher. Refer to {{PCC}} for more details.  


##Path Requirements

The bitrate requirements in {{scaling}} are per end-user actively
consuming a media feed, so in the worst case, the bitrate demands
can be multiplied by the number of simultaneous users to find the
bandwidth requirements for a router on the delivery path with that
number of users downstream.  For example, at a node with 10,000
downstream users simultaneously consuming video streams,
approximately 80 Gbps would be necessary in order for all of them
to get typical content at 1080p resolution at 60 fps, or up to
180 Gbps to get sustained high-motion content such as sports,
while maintaining the same resolution.

However, when there is some overlap in the feeds being consumed by
end users, it is sometimes possible to reduce the bandwidth
provisioning requirements for the network by performing some kind
of replication within the network.  This can be achieved via object
caching with delivery of replicated objects over individual
connections, and/or by packet-level replication using multicast.

To the extent that replication of popular content can be performed,
bandwidth requirements at peering or ingest points can be reduced to
as low as a per-feed requirement instead of a per-user requirement.

##Caching Systems

When demand for content is relatively predictable, and especially when that content is relatively static, caching content close to requesters, and pre-loading caches to respond quickly to initial requests, is often useful (for example, HTTP/1.1 caching is described in {{RFC7234}}). This is subject to the usual considerations for caching - for example, how much data must be cached to make a significant difference to the requester, and how the benefits of caching and pre-loading caches balances against the costs of tracking "stale" content in caches and refreshing that content.

It is worth noting that not all high-demand content is also "live" content. One popular example is when popular streaming content can be staged close to a significant number of requesters, as can happen when a new episode of a popular show is released. This content may be largely stable, so low-cost to maintain in multiple places throughout the Internet. This can reduce demands for high end-to-end bandwidth without having to use mechanisms like multicast.

Caching and pre-loading can also reduce exposure to peering point congestion, since less traffic crosses the peering point exchanges if the caches are placed in peer networks, and could be pre-loaded during off-peak hours, using "Lower-Effort Per-Hop Behavior (LE PHB) for Differentiated Services" {{RFC8622}}, "Low Extra Delay Background Transport (LEDBAT)" {{RFC6817}}, or similar mechanisms. 

All of this depends, of course, on the ability of a content provider to predict usage and provision bandwidth, caching, and other mechanisms to meet the needs of users. In some cases ({{sec-predict}}), this is relatively routine, but in other cases, it is more difficult ({{sec-unpredict}}, {{sec-extreme}}).

##Predictable Usage Profiles {#sec-predict}

Historical data shows that users consume more video and videos at higher bitrates than they did in the past on their connected devices. Improvements in the codecs that help with reducing the encoding bitrates with better compression algorithms could not have offset the increase in the demand for the higher quality video (higher resolution, higher frame rate, better color gamut, better dynamic range, etc.). In particular, mobile data usage has shown a large jump over the years due to increased consumption of entertainement as well as conversational video.

TBD: insert charts showing historical relative data usage patterns with
error bars by time of day in consumer networks?

Cross-ref vs. video quality by time of day in practice for some case
study?  Not sure if there's a good way to capture a generalized insight
here, but it seems worth making the point that demand projections can
be used to help with e.g. power consumption with routing architectures
that provide for modular scalability.

##Unpredictable Usage Profiles {#sec-unpredict}

Although TCP/IP has been used with a number of widely used applications that have symmetric bandwidth requirements (similar bandwidth requirements in each direction between endpoints), many widely-used Internet applications operate in client-server roles, with asymmetric bandwidth requirements. A common example might be an HTTP GET operation, where a client sends a relatively small HTTP GET request for a resource to an HTTP server, and often receives a significantly larger response carrying the requested resource. When HTTP is commonly used to stream movie-length video, the ratio between response size and request size can become quite large. 

For this reason, operators may pay more attention to downstream bandwidth utilization when planning and managing capacity. In addition, operators have been able to deploy access networks for end users using underlying technologies that are inherently asymetric, favoring downstream bandwidth (e.g. ADSL, cellular technologies, most IEEE 802.11 variants), assuming that users will need less upstream bandwidth than downstream bandwidth. This strategy usually works, except when it does not, because application bandwidth usage patterns have changed. 

One example of this type of change was when peer-to-peer file sharing applications gained popularity in the early 2000s. To take one well-documented case ({{RFC5594}}), the Bittorrent application created "swarms" of hosts, uploading and downloading files to each other, rather than communicating with a server. Bittorrent favored peers who uploaded as much as they downloaded, so that new Bittorrent users had an incentive to significantly increase their upstream bandwidth utilization. 

The combination of the large volume of "torrents" and the peer-to-peer characteristic of swarm transfers meant that end user hosts were suddenly uploading higher volumes of traffic to more destinations than was the case before Bittorrent. This caused at least one large ISP to attempt to "throttle" these transfers, to mitigate the load that these hosts placed on their network. These efforts were met by increased use of encryption in Bittorrent, similar to an arms race, and set off discussions about "Net Neutrality" and calls for regulatory action.

Especially as end users increase use of video-based social networking applications, it will be helpful for access network providers to watch for increasing numbers of end users uploading significant amounts of content. 

##Extremely Unpredictable Usage Profiles {#sec-extreme}

The causes of unpredictable usage described in {{sec-unpredict}} were more or less the result of human choices, but we were reminded during a post-IETF 107 meeting that humans are not always in control, and forces of nature can cause enormous fluctuations in traffic patterns.

In his talk, Sanjay Mishra {{Mishra}} reported that after the CoViD-19 pandemic broke out in early 2020,
 
- Comcast's streaming and web video consumption rose by 38%, with their reported peak traffic up 32% overall between March 1 to March 30,
- AT&T reported a 28% jump in core network traffic (single day in April, as compared to pre stay-at-home daily average traffic), with video accounting for nearly half of all mobile network traffic, while
social networking and web browsing remained the highest percentage (almost a quarter each) of overall mobility traffic, and 
- Verizon reported similar trends with video traffic up 36% over an average day (pre COVID-19)}.

We note that other operators saw similar spikes during this time period. Craig Labowitz {{Labovitz}} reported 

- Weekday peak traffic increases over 45%-50% from pre-lockdown levels, 
- A 30% increase in upstream traffic over their pre-pandemic levels, and
- A steady increase in the overall volume of DDoS traffic, with amounts exceeding the pre-pandemic levels by 40%. (He attributed this increase to the significant rise in gaming-related DDoS attacks ({{LabovitzDDoS}}), as gaming usage also increased.)

Subsequently, the Inernet Architecture Board (IAB) held a COVID-19 Network Impacts Workshop {{IABcovid}} in November 2020. Given a larger number of reports and more time to reflect, the following observations from the draft workshop report are worth considering.

- Participants describing different types of networks reported different kinds of impacts, but all types of networks saw impacts.
- Mobile networks saw traffic reductions and residential networks saw significant increases.
- Reported traffic increases from ISPs and IXPs over just a few weeks were as big as the traffic growth over the course of a typical year, representing a 15-20% surge in growth to land at a new normal that was much higher than anticipated. 
- At DE-CIX Frankfurt, the world's largest Internet Exchange Point in terms of data throughput, the year 2020 has seen the largest increase in peak traffic within a single year since the IXP was founded in 1995.  
- The usage pattern changed significantly as work-from-home and videoconferencing usage peaked during normal work hours, which would have typically been off-peak hours with adults at work and children at school. One might expect that the peak would have had more impact on networks if it had happened during typical evening peak hours for video streaming applications. 
- The increase in daytime bandwidth consumption reflected both significant increases in "essential" applications such as videoconferencing and VPNs, and entertainment applications as people watched videos or played games. 
- At the IXP-level, it was observed that port utilization increased. This phenomenon is mostly explained by a higher traffic demand from residential users.

#Adaptive Bitrate

##Overview

Adaptive BitRate (ABR) is a sort of application-level
response strategy in which the receiving media player attempts to
detect the available bandwidth of the network path by experiment
or by observing the successful application-layer download speed,
then chooses a video bitrate (among the limited number of available options) that fits within that bandwidth,
typically adjusting as changes in available bandwidth occur in
the network or changes in capabilities occur in the player (such as available memory, CPU, display size, etc.).

The choice of bitrate occurs within the context of optimizing for
some metric monitored by the video player, such as highest achievable
video quality, or lowest rate of expected rebuffering events.

##Segmented Delivery

ABR playback is commonly implemented by video players using HLS
{{RFC8216}} or DASH {{DASH}} to perform a reliable segmented delivery
of video data over HTTP. Different player implementations and
receiving devices use different strategies, often proprietary
algorithms (called rate adaptation or bitrate selection algorithms), to perform available
bandwidth estimation/prediction and the bitrate selection. Most players only use passive observations, i.e., they do not generate probe traffic to measure the available bandwidth. 

This kind of bandwidth-measurement systems can experience trouble in
several ways that can be affected by networking design choices.

###Idle Time between Segments

When the bitrate selection is successfully chosen below the
available capacity of the network path, the response to a
segment request will typically complete in less absolute time than the
duration of the requested segment. The resulting idle time within the connection carrying the
segments has a few surprising consequences:

 * Mobile flow-bandwidth spectrum and timing mapping.

 * TCP slow-start when restarting after idle requires multiple
   RTTs to re-establish a throughput at the network's available
   capacity. On high-RTT paths or with small enough segments,
   this can produce a falsely low application-visible measurement
   of the available network capacity.

A detailed investigation of this phenomenon is available in {{NOSSDAV12}}.

###Head-of-Line Blocking

In the event of a lost packet on a TCP connection with SACK
support (a common case for segmented delivery in practice), loss
of a packet can provide a confusing bandwidth signal to the
receiving application.  Because of the sliding window in TCP,
many packets may be accepted by the receiver without being available
to the application until the missing packet arrives.  Upon arrival
of the one missing packet after retransmit, the receiver will
suddenly get access to a lot of data at the same time.

To a receiver measuring bytes received per unit time at the
application layer, and interpreting it as an estimate of the
available network bandwidth, this appears as a high jitter in
the goodput measurement.

Active Queue Management (AQM) systems such as PIE {{RFC8033}} or
variants of RED {{RFC2309}} that induce early random loss under
congestion can mitigate this by using ECN {{RFC3168}} where
available.  ECN provides a congestion signal and induce a similar
backoff in flows that use Explicit Congestion Notification-capable
transport, but by avoiding loss avoids inducing head-of-line blocking
effects in TCP connections.

##Unreliable Transport

In contrast to segmented delivery, several applications use UDP or
unreliable SCTP to deliver RTP or raw TS-formatted video.

Under congestion and loss, this approach generally experiences more
video artifacts with fewer delay or head-of-line blocking effects.
Often one of the key goals is to reduce latency, to better support
applications like videoconferencing, or for other live-action
video with interactive components, such as some sporting events.

Congestion avoidance strategies for this kind of deployment vary
widely in practice, ranging from some streams that are entirely
unresponsive to using feedback signaling to change encoder settings
(as in {{RFC5762}}), or to use fewer enhancement layers (as in
{{RFC6190}}), to proprietary methods for detecting quality of
experience issues and cutting off video.

#IANA Considerations

This document requires no actions from IANA.

#Security Considerations

This document introduces no new security issues.

#Acknowledgements

Thanks to Mark Nottingham, Glenn Deen, Dave Oran, Aaron Falk, Kyle Rose, Leslie Daigle, Lucas Pardue, Matt Stock, Alexandre Gouaillard, and Mike English for their very helpful reviews and comments.

--- back

