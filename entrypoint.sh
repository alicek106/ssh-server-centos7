#!/bin/bash
tcset --device eth0 --direction outgoing --rate $1
tcset --device eth0 --direction incoming --rate $2
/bin/bash
