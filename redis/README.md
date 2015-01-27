# redis cluster

This directory contains a number of scripts which can be used together to easily
create and instantiate a redis cluster on a cluster of CoreOS nodes

# Usage

Copy all these files onto a single one of your CoreOS nodes. The cluster which
is set up will be started through fleetd, so it will automatically be spread out
to all nodes in the cluster.

## Contents

There's only three files you will actually interact with:

* `cluster-conf.sh` - This file contains a number of configurable parameters
that can alter how the cluster is started up. Check them out, but the default
will work fine to get a basic cluster up and running how you'd expect

* `setup-cluster.sh` - Run this to actually create your cluster, based off the
parameters set in `cluster-conf.sh`

* `clear-cluster.sh` - Run this to tear down the cluster specified in
`cluster-conf.sh`
