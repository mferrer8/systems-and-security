# OSI and TCP/IP Models with Encapsulation

Understanding the OSI and TCP/IP models is essential for SOC analysts. These models describe how data travels through a network, helping analysts detect anomalies, investigate attacks, and interpret logs.

A key concept is **encapsulation**: as data moves down the layers to transmit over the network, each layer adds its own header (and sometimes trailer), wrapping the data from the layer above. The reverse, **decapsulation**, occurs at the receiving side.

---

## OSI Model & Encapsulation

| Layer | Data Unit | Encapsulation/Decapsulation | Description | SOC Relevance |
|-------|-----------|----------------------------|-------------|---------------|
| Physical | Bits | Converts frames into electrical, optical, or radio signals | Physical transmission over cables or wireless | Connectivity issues, sniffing traffic |
| Data Link | Frame | Encapsulates packets from Network layer into frames; adds MAC addresses, error detection | Switching, MAC addressing | Detect ARP spoofing, MAC flooding |
| Network | Packet | Encapsulates segments from Transport layer; adds IP addresses | Logical addressing, routing | Track source/destination IPs, routing anomalies |
| Transport | Segment | Encapsulates application data; adds TCP/UDP headers with ports | Connection tracking, flow control | Detect SYN floods, abnormal connections |
| Session | Data | Manages sessions and dialogues between applications | Session creation/termination | Detect session hijacking, unauthorized sessions |
| Presentation | Data | Translates, encrypts, compresses data | Data representation, encryption, TLS/SSL | Inspect encrypted traffic, detect anomalies |
| Application | Data | Application-specific data | Network services: HTTP, DNS, SMTP | Detect web, email, and application-level attacks |

**Encapsulation flow (sending side):**  
Application Data → **Segment** → **Packet** → **Frame** → **Bits**

**Decapsulation flow (receiving side):**  
Bits → **Frame** → **Packet** → **Segment** → Application Data

---

## TCP/IP Model & Encapsulation

| Layer | Corresponding OSI Layer(s) | Data Unit | Notes | SOC Relevance |
|-------|---------------------------|-----------|-------|---------------|
| Network Interface | Physical + Data Link | Frame / Bits | Encapsulates IP packets for physical transmission | Monitor LAN/WAN traffic, detect MAC spoofing |
| Internet | Network | Packet | Adds IP addresses for routing | Track source/destination IPs, routing anomalies |
| Transport | Transport | Segment | Adds TCP/UDP headers with port numbers | Detect SYN floods, port scanning |
| Application | Session + Presentation + Application | Data | Protocol-specific payloads (HTTP, DNS, SMTP) | Analyze application-level attacks, phishing, malware |

---

## TCP vs UDP

| Feature | TCP | UDP |
|---------|-----|-----|
| Connection | Connection-oriented | Connectionless |
| Reliability | Reliable (ACKs, retransmission) | Unreliable (no ACKs) |
| Use Cases | Web traffic, email, file transfer | DNS queries, streaming, VoIP |
| SOC Relevance | Detect SYN floods, abnormal sessions | Monitor DNS tunneling, UDP amplification attacks |

**TCP Handshake Encapsulation Context:**  
- **SYN packet:** Transport layer adds TCP header → Network layer adds IP header → Data Link layer adds MAC header → Physical layer sends bits  
- **SYN-ACK:** Same encapsulation at sending side; decapsulated layer by layer at receiver

---

## Key Takeaways for SOC Analysts

- Map each OSI/TCP-IP layer to its **data unit**: Bits → Frame → Packet → Segment → Application Data  
- Understand **how encapsulation adds headers/trailers** and **how decapsulation removes them**  
- Know **which SOC tools monitor which layer**: Wireshark = all layers, SIEM = mostly Network + Application  
- Recognize where network issues or attacks occur at each layer
