# Distributed database

Creating the distributed database Local based on a tow database first in Rabat and the second in Casa using fragmentation and other technics.
We maintain the Acidity and Synchronization of data using  the  triggers on different site also with the help of Transaction locking and others functionalities provided by oracle.
## Overview schema of our distributed DB

<figure>
  <img src="/results_img/schm.PNG" alt="titople" title="Optional title" />
  <figcaption>Listener Configuration</figcaption>
</figure>


## Contents

- The script creationBasecomptes.sql contains the initial  database that will be fragmented and distributed between the server es1 and es2.
- The folder scripts hold all queries and objects used during the process's reconstruction of DDB final on local Site.
- The folder results_image store some of screenshot during execution's queries.


## Configuring and Administering Oracle Net Listener

<figure>
  <img src="/results_img/tsnme.PNG" alt="titople" title="Optional title" />
  <figcaption>Listener Configuration</figcaption>
</figure>
<figure>
  <img src="/results_img/listner.PNG" alt="titople" title="Optional title" />
  <figcaption>Listener Configuration</figcaption>
</figure>

## Tech tools

**Platform OS:** Widows8.1 hosts

**host hypervisor:** VMware Workstation 12

**RDBMS:** Oracle 11g xe

**IDE:** Oracle SQL Developer


