# Networking Basics for Support

## IP address

An IP address identifies a network interface on an IP network. IPv4 addresses look like `192.0.2.10`; IPv6 addresses use hexadecimal groups. Example addresses in this document are documentation or lab examples, not production endpoints.

## Private and public IP

Private IPv4 ranges are used inside private networks and are not directly routed across the public internet. Public IP addresses are globally routable, subject to routing and firewall policy.

## DNS

DNS translates a hostname such as `example.com` into address records. Use:

```bash
getent hosts example.com
```

A DNS failure points toward name resolution, resolver configuration, or upstream DNS reachability—not necessarily an application outage.

## Gateway and routing

A default gateway is the next hop used for destinations without a more specific route. Inspect routes with:

```bash
ip route
```

## TCP, UDP, ports, and firewalls

TCP provides a connection-oriented byte stream; UDP sends datagrams without a built-in connection setup. Applications listen on ports. Firewalls and network policies may allow one port/protocol while blocking another.

Inspect local listening sockets with:

```bash
ss -tulpen
```

## Ping and traceroute

- `ping` uses ICMP echo messages to test whether a target responds to that probe.
- `traceroute` attempts to reveal hops along a route; some routers do not respond to its probes.
- Neither tool alone proves that a web application is healthy.

## Practical troubleshooting order

1. Confirm the exact hostname, IP, port, and error.
2. Check local interface configuration with `ip addr`.
3. Check routes with `ip route`.
4. Resolve the hostname with `getent hosts`.
5. Test reachability where appropriate.
6. Test the actual application port or URL using an approved tool.
7. Record timestamps and results before escalation.
